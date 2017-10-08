//
//  AppDelegate.swift
//  RocketWidget
//
//  Created by Suren Khorenyan on 30.09.17.
//  Copyright © 2017 Suren Khorenyan. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    var prefs = Preferences()
    
    let statusBarItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return prefs.exitOnClose
    }

    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        if !flag {
            for window: AnyObject in sender.windows {
                window.makeKeyAndOrderFront(self)
            }
        }
        return true
    }

    func resetSettings() {
        prefs.exitOnClose = false
        prefs.exitEvenIfStatusBarMenuEnabled = false
        prefs.statusBarMenuEnabled = true
        prefs.hideStatusBarMenu = true
        prefs.startToStatusBar = false
        prefs.hideFromDockWhenWindowClosed = true
    }

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        if !UserDefaults.standard.bool(forKey: "launchedBefore") {
            resetSettings()
            UserDefaults.standard.set(true, forKey: "launchedBefore")
        }
        if let button = statusBarItem.button {
            button.image = NSImage(named: NSImage.Name("statusBarArrow"))
        }
    }
    
    required override init() {
        super.init()
        NotificationCenter.default.addObserver(forName: Notification.Name.prefsChanged, object: nil, queue: nil, using: toggleStatusBarItem)
    }

    func toggleStatusBarItem(_ notification: Notification) {
        statusBarItem.isVisible = prefs.statusBarMenuEnabled
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

