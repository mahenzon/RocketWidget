//
//  CurrencyFormatters.swift
//  RocketWidget
//
//  Created by Suren Khorenyan on 14.10.17.
//  Copyright © 2017 Suren Khorenyan. All rights reserved.
//

import Foundation

extension Money {
    var formatted: String {
        return amount.thousandsFormatting + " " + currency.currencySymbol
    }
}

extension Double {
    var rrFormatted: String {
        return self < 0 ? "": "+" + self.thousandsFormatting + " Р₽"
    }
}
