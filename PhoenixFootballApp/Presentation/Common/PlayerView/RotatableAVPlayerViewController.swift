//
//  RotatableAVPlayerViewController.swift
//  PhoenixFootballApp
//
//  Created by Shahanul Haque on 7/27/25.
//


import SwiftUI

import AVKit

extension AVPlayer {
    var isPlaying: Bool {
        return rate != 0 && error == nil
    }
}

class RotatableAVPlayerViewController: AVPlayerViewController {
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscapeRight
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .landscapeRight
    }
    
    
}


extension AVPlayerViewController {
    func enterFullScreen(animated: Bool) {
        print("Enter full screen")
        perform(NSSelectorFromString("enterFullScreenAnimated:completionHandler:"), with: animated, with: nil)
    }
    
    func exitFullScreen(animated: Bool) {
        print("Exit full screen")
       // perform(NSSelectorFromString("exitFullScreenAnimated:completionHandler:"), with: animated, with: nil)
        quitFullScreen()
    }
    
    func quitFullScreen() {
        let selectorName: String = {
            if #available(iOS 11, *) {
                return "_transitionFromFullScreenAnimated:completionHandler:"
            } else {
                return "_transitionFromFullScreenViewControllerAnimated:completionHandler:"
            }
        }()
        let selectorToForceQuitFullScreenMode = NSSelectorFromString(selectorName)

        if self.responds(to: selectorToForceQuitFullScreenMode) {
            self.perform(selectorToForceQuitFullScreenMode, with: true, with: nil)
        }
    }
}
var adPlayer:AVPlayerViewController?
struct PlayerViewController: UIViewControllerRepresentable {
    //var videoURL: URL?
    var player: AVPlayer
   
    @Binding var isPlaying: Bool
    @Binding var showFullScreen: Bool
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
          let controller = RotatableAVPlayerViewController()
//        let controller = AVPlayerViewController()
        

        
       // controller.videoGravity =  .resizeAspect
      //  controller.modalPresentationStyle = .fullScreen
        
        controller.player = player
        controller.delegate = context.coordinator
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Error configuring audio session: \(error)")
        }
        adPlayer = controller
        return controller
    }
    
    func updateUIViewController(_ playerController: AVPlayerViewController, context: Context) {
        // Update view frame to match video's natural size
        if isPlaying {
            playerController.player?.play()
        } else {
            playerController.player?.pause()
        }
        
        chooseScreenType(playerController)
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, AVPlayerViewControllerDelegate{
        
        var parent: PlayerViewController
        
        
        init(parent: PlayerViewController) {
            self.parent = parent
        }
        
        
        func playerViewController(_ playerViewController: AVPlayerViewController, willEndFullScreenPresentationWithAnimationCoordinator coordinator: UIViewControllerTransitionCoordinator) {
            parent.showFullScreen = false
        //    print("Full-screen mode is exiting. \(  playerViewController.player?.status.rawValue )")
            // The system pauses when returning from full screen, we need to 'resume' manually.
            coordinator.animate(alongsideTransition: nil) { transitionContext in
                playerViewController.player?.play()
            }
            
        }
        
        
        
        
        func playerViewController(_ playerViewController: AVPlayerViewController, willBeginFullScreenPresentationWithAnimationCoordinator coordinator: UIViewControllerTransitionCoordinator) {
            parent.showFullScreen = true
            print("full screen init")
//            coordinator.animate(alongsideTransition: nil) { transitionContext in
//
//
//                playerViewController.enterFullScreen(animated: true)
//
//            }
           
        }
        
        
        
        
        
     
        
        
    }
    
    private func chooseScreenType(_ controller: AVPlayerViewController) {
        print("chooseScreenType", self.showFullScreen)
        self.showFullScreen ? controller.enterFullScreen(animated: true) : controller.exitFullScreen(animated: true)
    }
}




struct VideoPlayerView: View {
    
    
    @State private var isPlaying = true
    let player: AVPlayer
    @Binding var showFullScreen:Bool

    
    var body: some View {
        VStack{
            PlayerViewController(player: player, isPlaying: $isPlaying, showFullScreen: $showFullScreen)
                .aspectRatio(CGFloat(CGFloat(16) / CGFloat(9) ), contentMode: .fit)
                .onDisappear{
                    print("player disapear => here")
                    player.pause()
                }
           // Text(player.description)
               
            
        }
    }
    
    
//   mutating func playVideo(url:String){
//        self.url = url
//
//       self.player.pause()
//
//        self.player =   AVPlayer(url: URL(string: url)!)
//    }
}

struct PlayerPrev:View{
    @State var url = "https://test-videos.co.uk/vids/bigbuckbunny/mp4/h264/720/Big_Buck_Bunny_720_10s_5MB.mp4"
    @State var url2 = "https://test-videos.co.uk/vids/bigbuckbunny/mp4/h264/720/Big_Buck_Bunny_720_10s_5MB.mp4"
    @State  var showFullScreen = false
    var body: some View{
        VideoPlayerView(player: AVPlayer(url:   URL(string: url)!), showFullScreen: $showFullScreen)

    }
}
//struct VideoPlayerView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        Prev()
//    }
//}
