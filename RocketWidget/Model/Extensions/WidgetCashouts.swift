//
//  WidgetCashouts.swift
//  RocketWidget
//
//  Created by Suren Khorenyan on 02.10.17.
//  Copyright © 2017 Suren Khorenyan. All rights reserved.
//

import Foundation

extension Widget {
    var cashoutsText: String {
        return unlimitedCashouts ? "Нет ограничений на снятия" : "\(freeCashOutLimit - cashOutCount) из \(freeCashOutLimit) бесплатных снятий"
    }
}
