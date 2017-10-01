//
//  RocketWidget.swift
//  RocketWidget
//
//  Created by Suren Khorenyan on 01.10.17.
//  Copyright © 2017 Suren Khorenyan. All rights reserved.
//

import Cocoa
import Foundation

class RocketWidget {
    
    fileprivate var userConfiguration = UserConfiguration()
    
    func loadUserConfig() -> Bool {
        let dialog = NSOpenPanel()
        dialog.title = "Выберите конфигурационный файл"
        dialog.showsResizeIndicator = true
        dialog.showsHiddenFiles = false
        dialog.canChooseDirectories = false
        dialog.canCreateDirectories = false
        dialog.allowsMultipleSelection = false
        dialog.allowedFileTypes = ["rocket-widget"]
        
        if (dialog.runModal() == NSApplication.ModalResponse.OK) {
            if let fileUrl = dialog.url {
                if let jsonData = try? Data(contentsOf: fileUrl) {
                    if let userData = try? JSONDecoder().decode(UserConfigJSONModel.self, from: jsonData) {
                        userConfiguration.deviceId = userData.deviceId
                        userConfiguration.widgetToken = userData.widgetToken
                        return true
                    }
                }
            }
        }
        return false
    }
}
