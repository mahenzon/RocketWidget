//
//  PrefsViewController.swift
//  RocketWidget
//
//  Created by Suren Khorenyan on 08.10.17.
//  Copyright © 2017 Suren Khorenyan. All rights reserved.
//

import Cocoa

class PrefsViewController: NSViewController {
    
    @IBOutlet weak var exitOnCloseCheck: NSButton!
    @IBOutlet weak var exitEvenIfStatusBarMenuEnabledCheck: NSButton!
    @IBOutlet weak var statusBarMenuEnabledCheck: NSButton!
    @IBOutlet weak var hideStatusBarMenuCheck: NSButton!
    @IBOutlet weak var startToStatusBarCheck: NSButton!
    @IBOutlet weak var hideFromDockWhenWindowClosedCheck: NSButton!
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        NSApp.abortModal()
        view.window?.close()
    }
    @IBAction func okButtonClicked(_ sender: Any) {
        NSApp.abortModal()
        saveNewPrefs()
        view.window?.close()
    }

    var prefs = Preferences()

    override func viewDidLoad() {
        super.viewDidLoad()
        showExistingPrefs()
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        if let window = self.view.window {
            NSApp.runModal(for: window)
        }
    }
}

extension PrefsViewController {
    // MARK: - Display
    func showExistingPrefs() {
        exitOnCloseCheck.state = prefs.exitOnClose ? NSControl.StateValue.on : NSControl.StateValue.off
        exitEvenIfStatusBarMenuEnabledCheck.state = prefs.exitEvenIfStatusBarMenuEnabled ? NSControl.StateValue.on : NSControl.StateValue.off
        statusBarMenuEnabledCheck.state = prefs.statusBarMenuEnabled ? NSControl.StateValue.on : NSControl.StateValue.off
        hideStatusBarMenuCheck.state = prefs.hideStatusBarMenu ? NSControl.StateValue.on : NSControl.StateValue.off
        startToStatusBarCheck.state = prefs.startToStatusBar ? NSControl.StateValue.on : NSControl.StateValue.off
        hideFromDockWhenWindowClosedCheck.state = prefs.hideFromDockWhenWindowClosed ? NSControl.StateValue.on : NSControl.StateValue.off
    }
    
    func saveNewPrefs() {
        prefs.exitOnClose = exitOnCloseCheck.state == .on ? true : false
        prefs.exitEvenIfStatusBarMenuEnabled = exitEvenIfStatusBarMenuEnabledCheck.state == .on ? true : false
        prefs.statusBarMenuEnabled = statusBarMenuEnabledCheck.state == .on ? true : false
        prefs.hideStatusBarMenu = hideStatusBarMenuCheck.state == .on ? true : false
        prefs.startToStatusBar = startToStatusBarCheck.state == .on ? true : false
        prefs.hideFromDockWhenWindowClosed = hideFromDockWhenWindowClosedCheck.state == .on ? true : false
        NotificationCenter.default.post(name: Notification.Name.prefsChanged, object: nil)
    }
}
