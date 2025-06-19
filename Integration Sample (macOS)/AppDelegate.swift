//
//  AppDelegate.swift
//  Integration Sample
//
//  Created by Сергій Попов on 16.06.2025.
//

import Cocoa
import Setapp

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        SetappManager.shared.showReleaseNotesWindowIfNeeded()
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        true
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
    
    @IBAction private func showReleaseNotes(_ sender: Any) {
      SetappManager.shared.showReleaseNotesWindow()
    }
    
    func yourSigninCompletionHandler() {
        
        SetappManager.shared.reportUsageEvent(.signIn)
    }
    
    func yourSignoutCompletionHandler() {
        SetappManager.shared.reportUsageEvent(.signOut)
    }

}

