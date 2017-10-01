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
            // TODO: - refresh view
        }
    }
    
    @IBAction func refreshClicked(_ sender: Any) {
        refreshButton.isHidden = true
        spinner.startAnimation(sender)
    }
    
    override func viewDidLoad() {
        imageViews = [firstImageView, secondImageView, thirdImageView]
        textLabels = [firstTextLabel, secondTextLabel, thirdTextLabel]
    }
}

