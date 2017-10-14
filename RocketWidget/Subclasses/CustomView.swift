//
//  CustomView.swift
//  RocketWidget
//
//  Created by Suren Khorenyan on 14.10.17.
//  Copyright © 2017 Suren Khorenyan. All rights reserved.
//  This custom view is for getting rid of the purr sound when keys are pressed

import Cocoa

class CustomView: NSView {
    override var acceptsFirstResponder: Bool {
        return true
    }
}
