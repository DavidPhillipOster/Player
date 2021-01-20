//  ViewController.swift
//  Created by David Phillip Oster on 1/14/2021.
//  Copyright © 2021 David Phillip Oster. All rights reserved.
// Open Source under Apache 2 license. See LICENSE in https://github.com/DavidPhillipOster/fileboss/ .
//

import UIKit
import AVKit

class LandscapeAVPlayerController: AVPlayerViewController {

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
      [.landscapeLeft, .landscapeRight]
    }
}

class ViewController: UIViewController {

  var fileURL: URL?
  var moviePlayer: AVPlayerViewController?
  var player: AVPlayer?
  var isResigning = false
  var hasViewAppeared = false
  lazy var documentsURL: URL = {
    FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
  }()

  override func loadView() {
    view = UIView(frame: UIScreen.main.bounds)
    view.backgroundColor = UIColor.systemBackground
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    loadFile()
    let nc = NotificationCenter.default
    let q = OperationQueue.main
    nc.addObserver(forName: UIApplication.didBecomeActiveNotification, object: nil, queue: q) { [weak self] _ in
      if let self = self {
        self.loadFile()
        if self.hasViewAppeared {
          self.playPlayer()
        }
      }
    }
    nc.addObserver(forName: UIApplication.willResignActiveNotification, object: nil, queue: q) { [weak self] _ in
      if let self = self {
        self.isResigning = true
        self.moviePlayer?.dismiss(animated: false){ [weak self] in
          if let self = self {
            self.moviePlayer = nil
            self.isResigning = false
          }
        }
      }
    }
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    if !isResigning { playPlayer() }
    hasViewAppeared = true
  }

// MARK: -
  func playPlayer(){
    if let player = player {
      moviePlayer = LandscapeAVPlayerController()
      if let moviePlayer = moviePlayer{
        moviePlayer.showsPlaybackControls = false
        moviePlayer.entersFullScreenWhenPlaybackBegins = true
        moviePlayer.videoGravity = .resizeAspectFill
        moviePlayer.player = player
        present(moviePlayer, animated: true) {
          player.play()
        }
      }
    }
  }

  func loadFile() {
    guard let fileURL = Bundle.main.url(forResource: "nook", withExtension: "mp4") else {
      return
    }
    player = AVPlayer(url: fileURL)
  }

}

