//
//  RocketRequests.swift
//  RocketWidget
//
//  Created by Suren Khorenyan on 01.10.17.
//  Copyright © 2017 Suren Khorenyan. All rights reserved.
//

import Foundation


fileprivate let apiHost = "https://rocketbank.ru/api/v5/"

fileprivate let urlSession = URLSession.shared

class RocketRequests {
    static let shared = RocketRequests()
}
