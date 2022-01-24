//
//  ja_jangApp.swift
//  ja-jang
//
//  Created by funch on 2022/01/18.
//

import SwiftUI
import Foundation
import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        NotificationCenter.default.addObserver(self, selector: #selector(taskFunc), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    @objc func taskFunc() {
        print(" task Func ")
    }
}

@main
struct DearLoveApp: App {
    
    var body: some Scene {
        WindowGroup {
            RecordView()
        }
    }
}
