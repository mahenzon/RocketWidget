//
//  StringMD5.swift
//  RocketWidget
//
//  Created by Suren Khorenyan on 01.10.17.
//  Copyright © 2017 Suren Khorenyan. All rights reserved.
//

extension String {
    var md5Value: String {
        // MARK: - Encoding a MD5 digest of bytes to a string
        let str = md5([Byte](self.utf8)).reduce("") { str, byte in
            let radix = 16
            let s = String(byte, radix: radix)
            // Ensure byte values less than 16 are padding with a leading 0
            let sum = str + (byte < Byte(radix) ? "0" : "") + s
            return sum
        }
        return str
    }
}
