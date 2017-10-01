//
//  UserConfiguration.swift
//  RocketWidget
//
//  Created by Suren Khorenyan on 01.10.17.
//  Copyright © 2017 Suren Khorenyan. All rights reserved.
//

import Foundation

struct UserConfiguration {
    fileprivate let deviceIdKey = "device_id"
    fileprivate let widgetTokenKey = "widget_token"
    
    var deviceId: String {
        get {
            if let deviceId = UserDefaults.standard.string(forKey: deviceIdKey) {
                return deviceId
            }
            return ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: deviceIdKey)
        }
    }
    
    var widgetToken: String {
        get {
            if let widgetToken = UserDefaults.standard.string(forKey: widgetTokenKey) {
                return widgetToken
            }
            return ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: widgetTokenKey)
        }
    }
    
    var isPresent: Bool {
        if deviceId == "" && widgetToken == "" {
            return false
        }
        return true
    }
}
