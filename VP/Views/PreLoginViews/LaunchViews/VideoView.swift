//
//  VideoView.swift
//  VP
//
//  Created by Demir Kovacevic on 28/11/2019.
//  Copyright © 2019 Demir Kovacevic. All rights reserved.
//

import SwiftUI
import UIKit
import AVKit
import AVFoundation

struct Video: UIViewRepresentable {
    
    var url: String
    
    typealias UIViewType = VideoView
    
    func makeUIView(context: Self.Context) -> Self.UIViewType {
        VideoView()
    }

    func updateUIView(_ uiView: Self.UIViewType, context: Self.Context) {
        uiView.configure(url: url)
        uiView.isLoop = true
        uiView.play()
    }
    
    func makeCoordinator() -> Coordinator{
        Coordinator(url: url)
    }
}

class Coordinator: NSObject {
    let videoView: VideoView
    
    init(url: String) {
        self.videoView = VideoView(frame: CGRect.zero)
        self.videoView.configure(url: url)
    }
}

class VideoView: UIView {

  var playerLayer: AVPlayerLayer?
  var player: AVPlayer?
  var isLoop: Bool = false
    
  override func layoutSubviews() {
      super.layoutSubviews()
      playerLayer?.frame = bounds
  }

  func configure(url: String) {
      let videoURL = URL(fileURLWithPath: url)
          player = AVPlayer(url: videoURL)
          playerLayer = AVPlayerLayer(player: player)
          playerLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
          if let playerLayer = self.playerLayer {
              layer.addSublayer(playerLayer)
          }
    NotificationCenter.default.addObserver(self, selector: #selector(reachTheEndOfTheVideo(_:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                                 object: self.player?.currentItem)
  }

  func play() {
      if player?.rate == 0 && player?.error == nil {
          player?.play()
      }
  }

  func pause() {
      player?.pause()
  }

  func stop() {
      player?.pause()
      player?.seek(to: CMTime.zero)
  }

  @objc func reachTheEndOfTheVideo(_ notification: Notification) {
      if isLoop {
          player?.pause()
          player?.seek(to: CMTime.zero)
          player?.play()
      }
  }

}
