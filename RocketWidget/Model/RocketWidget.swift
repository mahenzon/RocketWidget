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

    static let shared = RocketWidget()

    fileprivate var userConfiguration = UserConfiguration()

    var widgetCache: Widget?

    func loadUserConfig() -> ConfigImportResult {
        let dialog = NSOpenPanel()
        dialog.title = "Выберите конфигурационный файл"
        dialog.showsResizeIndicator = true
        dialog.showsHiddenFiles = false
        dialog.canChooseDirectories = false
        dialog.canCreateDirectories = false
        dialog.allowsMultipleSelection = false
        dialog.allowedFileTypes = ["rocket-widget"]

        switch dialog.runModal() {
        case .OK:
            if let fileUrl = dialog.url {
                if let jsonData = try? Data(contentsOf: fileUrl) {
                    if let userData = try? JSONDecoder().decode(UserConfigJSONModel.self, from: jsonData) {
                        userConfiguration.deviceId = userData.deviceId
                        userConfiguration.widgetToken = userData.widgetToken
                        return .succeded
                    }
                }
            }
        case .cancel: return .aborted
        default: break
        }
        return .failed
    }

    func formatOperationLabel(operation: RocketOperation) -> NSAttributedString {
        var htmlFormattedString = ""
        htmlFormattedString += "<span style=\"font-size: 18\">"
        htmlFormattedString += operation.name.truncate() + " "
        htmlFormattedString += "<b>" + operation.money.formatted + "</b>"
        htmlFormattedString += "</span>"
        htmlFormattedString += "<br>"
        htmlFormattedString += "<span style=\"font-size: 16; color: gray\">"
        htmlFormattedString += operation.date.timeFormatting
        htmlFormattedString += "</span>"

        return htmlFormattedString.htmlToAttributedString
    }
    
    func format(comment: String) -> NSAttributedString {
        var preparedString = ""
        preparedString += "<span style=\"font-size: 16\">"
        preparedString += "<b>Комметарий:</b>"
        preparedString += " </span>"
        preparedString += "<span style=\"font-size: 16; color: SlateGrey\">"
        preparedString += comment
        preparedString += "</span>"
        
        return preparedString.htmlToAttributedString
    }

    // MARK: - Instantiation StroyBoard for the SB item
    func freshController() -> ViewController {
        let storyboard = NSStoryboard(name: NSStoryboard.Name(rawValue: "Main"), bundle: nil)
        let identifier = NSStoryboard.SceneIdentifier(rawValue: "MainViewController")
        guard let viewcontroller = storyboard.instantiateController(withIdentifier: identifier) as? ViewController else {
            fatalError("Why cant i find ViewController? - Check Main.storyboard")
        }
        return viewcontroller
    }

    // MARK: - Instantiation StroyBoard for the Operatins view
    func operationViewController() -> OperationViewController {
        let storyboard = NSStoryboard(name: NSStoryboard.Name(rawValue: "Main"), bundle: nil)
        let identifier = NSStoryboard.SceneIdentifier(rawValue: "OperationView")
        guard let viewcontroller = storyboard.instantiateController(withIdentifier: identifier) as? OperationViewController else {
            fatalError("Why cant i find OperationViewController? - Check Main.storyboard")
        }
        return viewcontroller
    }

    func getPrefsViewController() -> PrefsViewController {
        let storyboard = NSStoryboard(name: NSStoryboard.Name(rawValue: "Main"), bundle: nil)
        let identifier = NSStoryboard.SceneIdentifier(rawValue: "PreferencesViewController")
        guard let viewcontroller = storyboard.instantiateController(withIdentifier: identifier) as? PrefsViewController else {
            fatalError("Why cant i find PreferencesViewController? - Check Main.storyboard")
        }
        return viewcontroller
    }
}
