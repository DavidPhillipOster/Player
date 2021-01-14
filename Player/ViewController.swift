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
      self?.loadFile()
    }
  }

// MARK: -

  func loadFile() {
    let fm = FileManager.default
    do {
      print("\(documentsURL)") // for debugging
      let dirFiles = try fm.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil, options: [
        .skipsSubdirectoryDescendants,
        .skipsPackageDescendants,
        .skipsHiddenFiles,
        .producesRelativePathURLs] )
      let extensions = ["m4v", "mov", "MOV"]
      for file: URL in dirFiles {
        if extensions.contains(file.pathExtension)  {
          fileURL = file
          player = AVPlayer(url: file)
          moviePlayer = LandscapeAVPlayerController()
          if let player = player,
              let moviePlayer = moviePlayer{
           moviePlayer.showsPlaybackControls = false
           moviePlayer.entersFullScreenWhenPlaybackBegins = true
           moviePlayer.videoGravity = .resizeAspectFill
           moviePlayer.player = player
            present(moviePlayer, animated: true) {
              player.play()
            }
          }
          break;
        }
      }
    } catch {
    }
  }

}

