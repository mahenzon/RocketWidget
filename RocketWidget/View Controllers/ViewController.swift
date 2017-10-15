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

    let operationDetailsPopover = NSPopover()
    var eventMonitor: EventMonitor?

    var userConfiguration = UserConfiguration()
    let rocketWidget = RocketWidget.shared
    let requests = RocketRequests.shared
    
    var imageViews = [NSImageView]()
    var textLabels = [NSTextField]()
    var stackViews = [NSStackView]()
    
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
    
    @IBOutlet weak var firstStackView: NSStackView!
    @IBOutlet weak var secondStackView: NSStackView!
    @IBOutlet weak var thirdStackView: NSStackView!

    @IBAction func importConfigMenuItemSelected(_ sender: Any) {
        switch rocketWidget.loadUserConfig() {
        case .failed: showAlert(withMessage: "Произошла ошибка при попытке чтения файла конфигурации.",
                                informativeText: "Возможно, файл поврежден. Для того, чтобы получить корректный файл конфигурации, отправьте боту @AstreyBot команду /macos")
        case .aborted: break
        case .succeded: fetchDataAndUpdateView()
        }
    }

    @IBAction func refreshMenuItemSelected(_ sender: Any) {
        closeOperationPopover(sender)
        refreshData()
    }

    @IBAction func refreshClicked(_ sender: Any) {
        closeOperationPopover(sender)
        refreshData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        operationDetailsPopover.contentViewController = rocketWidget.operationViewController()
        imageViews = [firstImageView, secondImageView, thirdImageView]
        textLabels = [firstTextLabel, secondTextLabel, thirdTextLabel]
        stackViews = [firstStackView, secondStackView, thirdStackView]

        NotificationCenter.default.addObserver(forName: .widgetUpdated, object: nil, queue: nil) { notification in
            if let widget = notification.object as? Widget {
                DispatchQueue.main.async {
                    self.fillView(from: widget)
                }
            }
        }

        if userConfiguration.isPresent {
            fetchDataAndUpdateView()
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}


extension ViewController {

    // MARK: - Display

    func showAlert(withMessage message: String, informativeText text: String) {
        let alert = rocketWidget.createAlert(withMessage: message, informativeText: text)
        if let window = self.view.window {
            alert.beginSheetModal(for: window, completionHandler: nil)
        } else {
            alert.runModal()
        }
    }

    func refreshData () {
        if userConfiguration.isPresent {
            fetchDataAndUpdateView()
        } else {
            showAlert(withMessage: "Не найдена пользовательская конфигурация!",
                      informativeText: "Для того, чтобы получить файл конфигурации, отправьте боту @AstreyBot команду /macos")
        }
    }
    
    func fetchDataAndUpdateView() {
        refreshButton.isHidden = true
        spinner.startAnimation(nil)
        requests.widget() { result, errorMessage in
            guard errorMessage == nil else {
                DispatchQueue.main.async {
                    self.spinner.stopAnimation(nil)
                    self.refreshButton.isHidden = false
                    self.showAlert(withMessage: "Ой, ошибочка вышла!",
                                   informativeText: "Мне не удалось загрузить никакой информацию, вернулась такая ошибка:\n\(errorMessage!)")
                }
                return
            }
            guard let widgetOrResponse = result else {
                DispatchQueue.main.async {
                    self.spinner.stopAnimation(nil)
                    self.refreshButton.isHidden = false
                    self.showAlert(withMessage: "Ой, ошибочка вышла!", informativeText: "Мне не удалось загрузить никакой информации, даже ошибка не вывалилась! Попробуй перезапустить приложение и / или перезалить конфиг.")
                }
                return
            }
            switch widgetOrResponse {
            case .widget(let widget):
                self.rocketWidget.widgetCache = widget
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: .widgetUpdated, object: widget)
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
                    self.spinner.stopAnimation(nil)
                    self.refreshButton.isHidden = false
                    self.showAlert(withMessage: "Ошибка получения данных!", informativeText: infoText)
                }
            }
        }
    }

    private func fillView(from widget: Widget) {
        balanceLabel.stringValue = widget.balance.thousandsFormatting + " ₽"
        rocketrubleLabel.stringValue = widget.rocketRubles.rrFormatted
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
}

extension ViewController {

    // MARK: - Click handling

    override func mouseDown(with event: NSEvent) {
        handleClick(event: event)
    }

    func handleClick(event: NSEvent) {
        closeOperationPopover(event)
        for (i, stackView) in stackViews.enumerated() {
            if clickbelongs(point: event.locationInWindow, frame: stackView.frame) {
                return processOperationClick(on: i)
            }
        }
    }

    func clickbelongs(point: NSPoint, frame: NSRect) -> Bool {
        if point.x < frame.maxX && point.x > frame.minX && point.y < frame.maxY && point.y > frame.minY {
            return true
        }
        return false
    }

    func processOperationClick(on: Int) {
        let vc = operationDetailsPopover.contentViewController as! OperationViewController
        vc.operation = rocketWidget.widgetCache?.recentOperations[on]
        operationDetailsPopover.show(relativeTo: stackViews[on].bounds, of: stackViews[on], preferredEdge: .minY)
    }

    func closeOperationPopover(_ sender: Any?) {
        if operationDetailsPopover.isShown {
            operationDetailsPopover.performClose(sender)
        }
    }
}

extension ViewController {

    // MARK: - Handle escape key in popovers

    override func keyDown(with event: NSEvent) {
        var nothingWasOpened = true
        if event.keyCode == 53 {  // esc key
            if operationDetailsPopover.isShown {
                operationDetailsPopover.performClose(event)
                nothingWasOpened = false
            }
            if let appdel = NSApplication.shared.delegate as? AppDelegate {
                if appdel.popover.isShown {
                    appdel.closePopover(sender: event)
                    nothingWasOpened = false
                }
            }
        }

        if nothingWasOpened {
            super.keyDown(with: event)
        }
    }
}
