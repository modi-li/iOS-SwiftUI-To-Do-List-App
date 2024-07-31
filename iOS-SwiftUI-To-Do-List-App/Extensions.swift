//
//  Extensions.swift
//  iOS-SwiftUI-To-Do-List-App
//
//  Created by Modi (Victor) Li.
//

import Foundation

extension Bool: Comparable {
    
    public static func < (lhs: Bool, rhs: Bool) -> Bool {
        !lhs && rhs
    }
    
}
