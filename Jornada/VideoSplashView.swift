import SwiftUI
import AVKit

// MARK: - Custom Video Player (no controls)
struct CustomVideoPlayer: UIViewControllerRepresentable {
    let player: AVPlayer

    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.player = player
        controller.showsPlaybackControls = false
        return controller
    }

    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {}
}

// MARK: - Splash Screen View
struct VideoSplashView: View {
    @State private var player: AVPlayer?
    @State private var showMainView = false

    var body: some View {
        ZStack {
            if showMainView {
                MainView()
                    .transition(.opacity)
            } else {
                if let player = player {
                    CustomVideoPlayer(player: player)
                        .aspectRatio(contentMode: .fill)
                        .ignoresSafeArea()
                        .onAppear {
                            player.play()
                            NotificationCenter.default.addObserver(
                                forName: .AVPlayerItemDidPlayToEndTime,
                                object: player.currentItem,
                                queue: .main
                            ) { _ in
                                withAnimation(.easeOut(duration: 0.5)) {
                                    showMainView = true
                                }
                            }
                        }
                } else {
                    Color.black.ignoresSafeArea()
                    Text("❌ splash.mp4 not found")
                        .foregroundColor(.white)
                }
            }
        }
        .onAppear {
            if let url = Bundle.main.url(forResource: "splash", withExtension: "mp4") {
                player = AVPlayer(url: url)
                loadAndPlayMusic()
            } else {
                print("❌ splash.mp4 NOT FOUND")
            }
        }
    }
}

// MARK: - Preview
#Preview {
    VideoSplashView()
}
