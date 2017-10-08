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
    let popover = NSPopover()

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return prefs.exitOnClose
    }

    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        if !flag {
            sender.windows[2].makeKeyAndOrderFront(self)
        }
        return true
    }

    func resetSettings() {
        prefs.exitOnClose = false
        prefs.exitEvenIfStatusBarMenuEnabled = false
        prefs.statusBarMenuEnabled = true
        prefs.hideStatusBarMenu = true
        prefs.startToStatusBar = false
        prefs.hideFromDockWhenWindowClosed = false
    }

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        if !UserDefaults.standard.bool(forKey: "launchedBefore") {
            resetSettings()
            UserDefaults.standard.set(true, forKey: "launchedBefore")
        }
        if let button = statusBarItem.button {
            button.image = NSImage(named: NSImage.Name("statusBarArrow"))
            button.action = #selector(togglePopover(_:))
        }
        popover.contentViewController = ViewController.freshController()
    }
    
    @objc func togglePopover(_ sender: Any?) {
        if popover.isShown {
            closePopover(sender: sender)
        } else {
            showPopover(sender: sender)
        }
    }
    
    func showPopover(sender: Any?) {
        if let button = statusBarItem.button {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
        }
    }
    
    func closePopover(sender: Any?) {
        popover.performClose(sender)
    }
    
    required override init() {
        super.init()
        NotificationCenter.default.addObserver(forName: .prefsChanged, object: nil, queue: nil, using: toggleStatusBarItem)
    }

    func toggleStatusBarItem(_ notification: Notification) {
        statusBarItem.isVisible = prefs.statusBarMenuEnabled
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

