//
//  HyperlinkTextField.swift
//  RocketWidget
//
//  Created by Suren Khorenyan on 14.10.17.
//  Copyright © 2017 Suren Khorenyan. All rights reserved.
//

import Cocoa

class HyperTextField: NSTextField {
    var href: URL = URL(string: "https://rocketbank.ru")!

    override func mouseDown(with event: NSEvent) {
        NSWorkspace.shared.open(self.href)
    }
}
