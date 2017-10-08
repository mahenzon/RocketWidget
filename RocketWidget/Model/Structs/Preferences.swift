//
//  Preferences.swift
//  RocketWidget
//
//  Created by Suren Khorenyan on 08.10.17.
//  Copyright © 2017 Suren Khorenyan. All rights reserved.
//

import Foundation

struct Preferences {
    
    fileprivate let defaults = UserDefaults.standard
    
    fileprivate let exitOnCloseKey = "exit_on_close"
    fileprivate let exitEvenIfStatusBarMenuEnabledKey = "exit_even_if_status_menu_enabled"
    fileprivate let statusBarMenuEnabledKey = "status_bar_menu_enabled"
    fileprivate let hideStatusBarMenuKey = "hide_status_bar_menu"
    fileprivate let startToStatusBarKey = "start_to_status_bar"
    fileprivate let hideFromDockWhenWindowClosedKey = "hide_from_dock_when_window_closed"
    
    var exitOnClose: Bool {
        get {
            return defaults.bool(forKey: exitOnCloseKey)
        }
        set {
            defaults.set(newValue, forKey: exitOnCloseKey)
        }
    }
    
    var exitEvenIfStatusBarMenuEnabled: Bool {
        get {
            return defaults.bool(forKey: exitEvenIfStatusBarMenuEnabledKey)
        }
        set {
            defaults.set(newValue, forKey: exitEvenIfStatusBarMenuEnabledKey)
        }
    }
    
    var statusBarMenuEnabled: Bool {
        get {
            return defaults.bool(forKey: statusBarMenuEnabledKey)
        }
        set {
            defaults.set(newValue, forKey: statusBarMenuEnabledKey)
        }
    }
    
    var hideStatusBarMenu: Bool {
        get {
            return defaults.bool(forKey: hideStatusBarMenuKey)
        }
        set {
            defaults.set(newValue, forKey: hideStatusBarMenuKey)
        }
    }
    
    var startToStatusBar: Bool {
        get {
            return defaults.bool(forKey: startToStatusBarKey)
        }
        set {
            defaults.set(newValue, forKey: startToStatusBarKey)
        }
    }
    
    var hideFromDockWhenWindowClosed: Bool {
        get {
            return defaults.bool(forKey: hideFromDockWhenWindowClosedKey)
        }
        set {
            defaults.set(newValue, forKey: hideFromDockWhenWindowClosedKey)
        }
    }
}
