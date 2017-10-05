//
//  ViewController.swift
//  RocketWidget
//
//  Created by Suren Khorenyan on 30.09.17.
//  Copyright © 2017 Suren Khorenyan. All rights reserved.
//

import Cocoa

fileprivate let imgs = ImageManager.shared

class ViewController: NSViewController {
    
    var userConfiguration = UserConfiguration()
    let rocketWidget = RocketWidget()
    let requests = RocketRequests.shared
    
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
    
    @IBAction func refreshMenuItemSelected(_ sender: Any) {
        refreshData()
    }
    
    
    @IBAction func refreshClicked(_ sender: Any) {
        refreshData()
    }
    
    override func viewDidLoad() {
        imageViews = [firstImageView, secondImageView, thirdImageView]
        textLabels = [firstTextLabel, secondTextLabel, thirdTextLabel]
        if userConfiguration.isPresent {
            fetchDataAndUpdateView()
        }
    }
}


extension ViewController {
    
    // MARK: - Display

    func refreshData () {
        if userConfiguration.isPresent {
            fetchDataAndUpdateView()
        } else {
            createAlert(withMessage: "Не найдена пользовательская конфигурация!",
                        informativeText: "Для того, чтобы получить корректный файл конфигурации, отправьте боту @AstreyBot команду /macos")
                .runModal()
        }
    }
    
    func fetchDataAndUpdateView() {
        refreshButton.isHidden = true
        spinner.startAnimation(nil)
        requests.widget() { result, errorMessage in
            guard errorMessage == nil else {
                DispatchQueue.main.async {
                    self.createAlert(withMessage: "Ой, ошибочка вышла!",
                                     informativeText: "Мне не удалось загрузить никакой информацию, вернулась такая ошибка:\n\(errorMessage!)")
                        .runModal()
                }
                return
            }
            guard let widgetOrResponse = result else {
                DispatchQueue.main.async {
                    self.createAlert(withMessage: "Ой, ошибочка вышла!",
                                     informativeText: "Мне не удалось загрузить никакой информации, даже ошибка не вывалилась! Попробуй перезапустить приложение и / или перезалить конфиг.")
                        .runModal()
                }
                return
            }
            switch widgetOrResponse {
            case .widget(let widget):
                DispatchQueue.main.async {
                    self.fillView(from: widget)
                    self.spinner.stopAnimation(nil)
                    self.refreshButton.isHidden = false
                }
            case .response(let response):
                let infoText: String
                if response.response.code == "INCORRECT_TOKEN" {
                    infoText = "\(response.response.description)\nПопробуйте перезалить конфиг."
                } else {
                    infoText = response.response.description
                }
                DispatchQueue.main.async {
                    self.createAlert(withMessage: "Ошибка получения данных!",
                                     informativeText: infoText)
                        .runModal()
                }
            }
        }
    }

    private func fillView(from widget: Widget) {
        balanceLabel.stringValue = widget.balance.thousandsFormatting + " ₽"
        rocketrubleLabel.stringValue = widget.rocketRubles.thousandsFormatting + " Р₽"
        remainingCashoutsLabel.stringValue = widget.cashoutsText
        
        for (label, operation) in zip(textLabels, widget.recentOperations) {
            label.attributedStringValue = rocketWidget.formatOperationLabel(operation: operation)
        }
        
        let imgsLoadQueue = DispatchQueue(label: "images_load", qos: .userInteractive, attributes: .concurrent)
        for (imgView, operation) in zip(imageViews, widget.recentOperations) {
            imgsLoadQueue.async {
                let url: URL?
                if let friend = operation.friend {
                    url = friend.userpic
                } else {
                    url = operation.merchant.icon
                }
                DispatchQueue.main.async {
                    imgView.layer?.cornerRadius = 5
                    imgView.image = imgs.getImage(forUrl: url, category: operation.category)
                }
            }
        }
    }

    func createAlert(withMessage message: String, informativeText text: String, style: NSAlert.Style = .warning) -> NSAlert {
        let alert = NSAlert()
        alert.messageText = message
        alert.informativeText = text
        alert.alertStyle = style

        return alert
    }
}
