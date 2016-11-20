//
//  UserDefaults-Extensions.swift
//  Valute
//
//  Created by iosakademija on 11/20/16.
//  Copyright © 2016 iOS akademija. All rights reserved.
//

import Foundation

enum UserDefaultKeys: String {
    case sourceCurrencyCode
    case targetCurrencyCode
}

extension UserDefaults {
    static var sourceCurrencyCode: String? {
        get {
            let defs = UserDefaults.standard
            return defs.string(forKey: UserDefaultKeys.sourceCurrencyCode.rawValue)
        }

        set(value) {
            let defs = UserDefaults.standard
            defs.set(value, forKey: UserDefaultKeys.sourceCurrencyCode.rawValue)
        }
    }
    
    static var targetCurrencyCode: String? {
        get {
            let defs = UserDefaults.standard
            return defs.string(forKey: UserDefaultKeys.targetCurrencyCode.rawValue)
        }
        
        set (value) {
            let defs = UserDefaults.standard
            defs.set(value, forKey: UserDefaultKeys.targetCurrencyCode.rawValue)
        }
    }
}

