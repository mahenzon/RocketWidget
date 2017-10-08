//
//  StringTruncate.swift
//  RocketWidget
//
//  Created by Suren Khorenyan on 08.10.17.
//  Copyright © 2017 Suren Khorenyan. All rights reserved.
//

import Foundation

extension String {
    func truncate(length: Int, trailing: String = "...") -> String {
        if self.characters.count > length {
            return String(self.characters.prefix(length)) + trailing
        } else {
            return self
        }
    }
}
