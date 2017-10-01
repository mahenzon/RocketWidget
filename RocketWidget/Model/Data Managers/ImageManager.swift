//
//  ImageManager.swift
//  RocketWidget
//
//  Created by Suren Khorenyan on 01.10.17.
//  Copyright © 2017 Suren Khorenyan. All rights reserved.
//

import Cocoa
import Foundation

class ImageManager {
    static let shared = ImageManager()
    
    // TODO: - if url none return from base using id else img no img
    func getImage(forUrl url: URL?, category: MerchantCategory) -> NSImage {
        if let url = url, let image = NSImage(contentsOf: url) {
            return image
        } else {
            return NSImage(named: NSImage.Name(rawValue: "MissingImage"))!
        }
    }
}

