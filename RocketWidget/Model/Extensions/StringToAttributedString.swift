//
//  StringToAttributedString.swift
//  RocketWidget
//
//  Created by Suren Khorenyan on 02.10.17.
//  Copyright © 2017 Suren Khorenyan. All rights reserved.
//

import Foundation

extension String {
    var htmlToAttributedString: NSAttributedString {
        return try! NSAttributedString(data: Data(utf8),
                                       options: [.documentType: NSAttributedString.DocumentType.html,
                                                 .characterEncoding: String.Encoding.utf8.rawValue],
                                       documentAttributes: nil)
    }
}
