//
//  VPTests.swift
//  VPTests
//
//  Created by Demir Kovacevic on 28/11/2019.
//  Copyright © 2019 Demir Kovacevic. All rights reserved.
//

import XCTest
import UIKit
import AVKit
import AVFoundation

@testable import VP
class VideoTests: XCTestCase {
    
    var videoView: VideoView?

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        videoView = VideoView()
        videoView?.configure(url: Bundle.main.path(forResource: "MR7", ofType: "mp4")!)
        super.setUp()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        videoView = nil
        super.setUp()
    }

    func testPlay() {
        videoView?.play()
        
        XCTAssert(videoView?.player?.timeControlStatus == AVPlayer.TimeControlStatus.waitingToPlayAtSpecifiedRate)
        XCTAssert(videoView?.player?.rate != 0)
        XCTAssert(videoView?.player?.error == nil)
    }

    func testPause() {
        videoView?.play()
        videoView?.pause()
        
        XCTAssert(videoView?.player?.timeControlStatus == AVPlayer.TimeControlStatus.paused)
    }
    
    func testStop() {
        videoView?.play()
        videoView?.stop()
        
        XCTAssert(videoView?.player?.rate == 0)
        XCTAssert(videoView?.player?.error == nil)
        XCTAssert(videoView?.player?.timeControlStatus == AVPlayer.TimeControlStatus.paused)
        
    }
    
    func testReachTheEndOfTheVideo() {
        videoView?.play()
        videoView?.isLoop = true
        
        videoView?.reachTheEndOfTheVideo(Notification.init(name: NSNotification.Name.AVPlayerItemDidPlayToEndTime))
        
        XCTAssert(videoView?.player?.timeControlStatus == AVPlayer.TimeControlStatus.waitingToPlayAtSpecifiedRate)
        XCTAssert(videoView?.player?.rate != 0)
        XCTAssert(videoView?.player?.error == nil)
    }
  
}
