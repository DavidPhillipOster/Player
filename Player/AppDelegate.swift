//  AppDelegate.swift
//  Created by David Phillip Oster on 1/14/2021.
//  Copyright © 2021 David Phillip Oster. All rights reserved.
// Open Source under Apache 2 license. See LICENSE in https://github.com/DavidPhillipOster/fileboss/ .
//

import UIKit
import AVFoundation

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    let audioSession = AVAudioSession.sharedInstance()
    do {
        try audioSession.setCategory(.playback, mode: .moviePlayback)
    } catch {
        print("Setting category to AVAudioSessionCategoryPlayback failed.")
    }
    if let window = window {
      window.rootViewController = ViewController()
      window.makeKeyAndVisible()
    }
    return true
  }

}

