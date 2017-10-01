//
//  UserConfigJSONModel.swift
//  RocketWidget
//
//  Created by Suren Khorenyan on 01.10.17.
//  Copyright © 2017 Suren Khorenyan. All rights reserved.
//

import Foundation

struct UserConfigJSONModel: Decodable {
    var deviceId: String
    var widgetToken: String
    
    enum CodingKeys: String, CodingKey {
        case deviceId = "device_id"
        case widgetToken = "widget_token"
    }
}
