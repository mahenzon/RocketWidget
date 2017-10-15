//
//  OperationViewController.swift
//  RocketWidget
//
//  Created by Suren Khorenyan on 12.10.17.
//  Copyright © 2017 Suren Khorenyan. All rights reserved.
//

import Cocoa
import MapKit

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
    @IBOutlet weak var bottomStackView: NSStackView!
    
    let mapView = MKMapView()

    var operation: RocketOperation?

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.setRegion(MapPin.defaultRegion, animated: true)
        bottomStackView.translatesAutoresizingMaskIntoConstraints = true
        bottomStackView.addView(mapView, in: .top)
        bottomStackView.layoutSubtreeIfNeeded()
        bottomStackView.isHidden = true
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
            mainStackView.layout()
            
            if let lat = operation.location.latitude, let lon = operation.location.longitude {
                let coord = CLLocationCoordinate2DMake(lat, lon)
                let annotation = MapPin(title: operation.name, subtitle: operation.category.name, coordinate: coord)
                mapView.addAnnotation(annotation)
                mapView.setRegion(MKCoordinateRegionMakeWithDistance(coord, MapPin.radius, MapPin.radius), animated: true)
                bottomStackView.isHidden = false
            }
            else {
                bottomStackView.isHidden = true
            }
        }
    }
}
