//
//  String+Extensions.swift
//  Sportz_Interactive_Round_2
//
//  Created by Neosoft on 19/01/23.
//

import Foundation

extension Optional where Wrapped == String {
    func orEmpty() -> String {
        if self == nil {
            return ""
        } else {
            return self!
        }
    }
}
