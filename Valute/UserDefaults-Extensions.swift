//
//  UserDefaults-Extensions.swift
//  Valute
//
//  Created by iosakademija on 11/20/16.
//  Copyright © 2016 iOS akademija. All rights reserved.
//

import Foundation

enum Key: String {
    case source
    case target
}

extension UserDefaults {
    static var sourceCurrencyCode: String? {
        get {
            let defs = UserDefaults.standard
            return defs.string(forKey: Key.source.rawValue)
        }

        set(value) {
            let defs = UserDefaults.standard
            defs.set(value, forKey: Key.source.rawValue)
        }
    }
    
    static var targetCurrencyCode: String? {
        get {
            let defs = UserDefaults.standard
            return defs.string(forKey: Key.target.rawValue)
        }
        
        set (value) {
            let defs = UserDefaults.standard
            defs.set(value, forKey: Key.target.rawValue)
        }
    }
}

