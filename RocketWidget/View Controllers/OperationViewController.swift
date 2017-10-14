//
//  OperationViewController.swift
//  RocketWidget
//
//  Created by Suren Khorenyan on 12.10.17.
//  Copyright © 2017 Suren Khorenyan. All rights reserved.
//

import Cocoa

class OperationViewController: NSViewController {
    
    let rocketWidget = RocketWidget.shared

    @IBOutlet weak var mainStackView: NSStackView!
    @IBOutlet weak var operationNameLabel: NSTextField!
    @IBOutlet weak var categoryLabel: NSTextField!
    @IBOutlet weak var moneyAmountLabel: NSTextFieldCell!
    @IBOutlet weak var rocketRublesAmountLabel: NSTextField!
    @IBOutlet weak var commentLabel: NSTextField!
    @IBOutlet weak var dateTimeLabel: NSTextField!
    @IBOutlet weak var receiptLabel: HyperTextField!
    
    var operation: RocketOperation?

    override func viewWillAppear() {
        super.viewWillAppear()
    }
    override func viewDidAppear() {
        super.viewDidAppear()
        if let operation = operation {
            operationNameLabel.stringValue = operation.name
            categoryLabel.stringValue = operation.category.name
            moneyAmountLabel.stringValue = operation.money.formatted
            if operation.rocketRubles == 0 {
                rocketRublesAmountLabel.isHidden = true
            } else {
                rocketRublesAmountLabel.isHidden = false
                rocketRublesAmountLabel.stringValue = operation.rocketRubles < 0 ? "": "+" + operation.rocketRubles.rrFormatted
            }
            if let comment = operation.comment {
                commentLabel.isHidden = false
                commentLabel.attributedStringValue = rocketWidget.format(comment: comment)
            }
            else {
                commentLabel.isHidden = true
            }
            dateTimeLabel.stringValue = operation.date.mediumTimeFormatting
            receiptLabel.href = operation.receipt
        }
    }
}
