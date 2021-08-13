//
//  DLString.swift
//  DLWebImage
//
//  Created by qing on 2021/8/11.
//

import Foundation
import CommonCrypto

extension String {
    func md5() -> String {
        let cCharArray = self.cString(using: .utf8)
        var uint8Array = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        CC_MD5(cCharArray, CC_LONG(cCharArray!.count - 1), &uint8Array)
        return uint8Array.reduce("") { $0 + String(format: "%02X", $1)}
    }
}
