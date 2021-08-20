//
//  ViewController.swift
//  MetWords
//
//  Created by Li Jian on 2021/6/23.
//

import Cocoa
import SafariServices.SFSafariApplication
import SafariServices.SFSafariExtensionManager

let appName = "遇见单词"
let extensionBundleIdentifier = "com.metwords.MetWords.Extension"

class ViewController: NSViewController {

    @IBOutlet var appNameLabel: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.appNameLabel.stringValue = appName
        SFSafariExtensionManager.getStateOfSafariExtension(withIdentifier: extensionBundleIdentifier) { (state, error) in
            guard let state = state, error == nil else {
                // Insert code to inform the user that something went wrong.
                return
            }

            DispatchQueue.main.async {
                if (state.isEnabled) {
                    self.appNameLabel.stringValue = "\(appName) 扩展已启用。"
                } else {
                    self.appNameLabel.stringValue = "\(appName) 扩展未启用。你可以在 Safari 首选项启用本扩展。"
                }
            }
        }
    }
    
    @IBAction func openSafariExtensionPreferences(_ sender: AnyObject?) {
        SFSafariApplication.showPreferencesForExtension(withIdentifier: extensionBundleIdentifier) { error in
            guard error == nil else {
                // Insert code to inform the user that something went wrong.
                return
            }

            DispatchQueue.main.async {
                NSApplication.shared.terminate(nil)
            }
        }
    }

}
