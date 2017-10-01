//
//  RocketResponseModels.swift
//  RocketWidget
//
//  Created by Suren Khorenyan on 01.10.17.
//  Copyright © 2017 Suren Khorenyan. All rights reserved.
//

import Foundation

struct Coordinate: Decodable {
    var latitude: Double?
    var longitude: Double?
    var acc: Double?
}

struct MoneySpent: Decodable {
    var amount: Double
    var currency: String
    
    enum CodingKeys: String, CodingKey {
        case currency = "currency_code"
        
        case amount
    }
}

struct MerchantCategory: Decodable {
    var id: String
    var name: String
    
    enum CodingKeys: String, CodingKey {
        case id = "sub_icon"
        case name = "display_name"
    }
}

struct Merchant: Decodable {
    var id: Int
    var name: String
    var icon: URL?
}

struct RocketFriend: Decodable {
    var id: Int
    var userpic: URL?
    var firstName: String
    var lastName: String
    
    enum CodingKeys: String, CodingKey {
        case userpic = "userpic_url"
        case firstName = "first_name"
        case lastName = "last_name"
        
        case id
    }
}

struct RocketOperation: Decodable {
    var comment: String?
    var receipt: URL
    var contextType: String
    var name: String
    var friend: RocketFriend?
    var rocketRubles: Double
    var date: Int
    var money: MoneySpent
    var category: MerchantCategory
    var merchant: Merchant
    var location: Coordinate
    
    enum CodingKeys: String, CodingKey {
        case receipt = "receipt_url"
        case contextType = "context_type"
        case name = "details"
        case rocketRubles = "mimimiles"
        case date = "happened_at"
        
        case merchant
        case comment
        case money
        case category
        case location
        case friend
    }
}

struct Widget: Decodable {
    var recentOperations: [RocketOperation]
    var balance: Double
    var rocketRubles: Double
    var cashOutCount: Int
    var freeCashOutLimit: Int
    var unlimitedCashouts: Bool
    
    enum CodingKeys: String, CodingKey {
        case recentOperations = "recent_operations"
        case balance = "balace"
        case rocketRubles = "rocketrubles"
        case cashOutCount = "cash_out_count"
        case freeCashOutLimit = "free_cash_out_limit"
        case unlimitedCashouts = "unlimited_cashouts"
    }
}


// {"response":{"status":401,"description":"Авторизация по токену не удалась","code":"INCORRECT_TOKEN","show_it":false}}

struct ResponseCode: Decodable {
    var code: String
    var description: String
    var show: Bool
    var status: Int
    
    enum CodingKeys: String, CodingKey {
        case show = "show_it"
        
        case code, description, status
    }
}

struct Response: Decodable {
    var response: ResponseCode
}

