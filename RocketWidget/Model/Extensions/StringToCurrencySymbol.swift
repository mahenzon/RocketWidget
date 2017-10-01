//
//  StringToCurrencySymbol.swift
//  RocketWidget
//
//  Created by Suren Khorenyan on 01.10.17.
//  Copyright © 2017 Suren Khorenyan. All rights reserved.
//

import Foundation

let locale = NSLocale(localeIdentifier: "RU")

extension String {
    var currencySymbol: String {
        if let currencySymbol = locale.displayName(forKey: NSLocale.Key.currencySymbol, value: self) {
            return currencySymbol
        }
        return self
    }
}
