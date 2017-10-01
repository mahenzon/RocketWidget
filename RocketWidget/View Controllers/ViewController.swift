//
//  ViewController.swift
//  RocketWidget
//
//  Created by Suren Khorenyan on 30.09.17.
//  Copyright © 2017 Suren Khorenyan. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    var userConfiguration = UserConfiguration()
    let rocketWidget = RocketWidget()
    
    var imageViews = [NSImageView]()
    var textLabels = [NSTextField]()
    
    @IBOutlet weak var balanceLabel: NSTextField!
    @IBOutlet weak var rocketrubleLabel: NSTextField!
    @IBOutlet weak var remainingCashoutsLabel: NSTextField!
    @IBOutlet weak var spinner: NSProgressIndicator!
    @IBOutlet weak var refreshButton: NSButton!
    @IBOutlet weak var firstImageView: NSImageView!
    @IBOutlet weak var secondImageView: NSImageView!
    @IBOutlet weak var thirdImageView: NSImageView!
    @IBOutlet weak var firstTextLabel: NSTextField!
    @IBOutlet weak var secondTextLabel: NSTextField!
    @IBOutlet weak var thirdTextLabel: NSTextField!
    
    @IBAction func importConfigMenuItemSelected(_ sender: Any) {
        if rocketWidget.loadUserConfig() {
            fetchDataAndUpdateView()
        } else {
            createAlert(withMessage: "Произошла ошибка при попытке чтения файла конфигурации.",
                        informativeText: "Возможно, файл поврежден. Для того, чтобы получить корректный файл конфигурации, отправьте боту @AstreyBot команду /macos")
                .runModal()
        }
    }
    
    @IBAction func refreshClicked(_ sender: Any) {
        if userConfiguration.isPresent {
            refreshButton.isHidden = true
            spinner.startAnimation(sender)
        } else {
            createAlert(withMessage: "Не найдена пользовательская конфигурация!",
                        informativeText: "Для того, чтобы получить корректный файл конфигурации, отправьте боту @AstreyBot команду /macos")
                .runModal()
        }
    }
    
    override func viewDidLoad() {
        imageViews = [firstImageView, secondImageView, thirdImageView]
        textLabels = [firstTextLabel, secondTextLabel, thirdTextLabel]
    }
}

extension ViewController {
    // MARK: - Display
    func fetchDataAndUpdateView() {
        // TODO: - Update view here
    }
    func createAlert(withMessage message: String, informativeText text: String, style: NSAlert.Style = .warning) -> NSAlert {
        let alert = NSAlert()
        alert.messageText = message
        alert.informativeText = text
        alert.alertStyle = style

        return alert
    }
}
