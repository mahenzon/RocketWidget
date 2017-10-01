//
//  RequestRelatedEnums.swift
//  RocketWidget
//
//  Created by Suren Khorenyan on 01.10.17.
//  Copyright © 2017 Suren Khorenyan. All rights reserved.
//

import Foundation

enum Methods: String {
    case widget
}

enum WidgetOrResponse {
    case widget(Widget)
    case response(Response)
}
