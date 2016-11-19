//
//  Locale-Extension.swift
//  Valute
//
//  Created by iosakademija on 11/19/16.
//  Copyright © 2016 iOS akademija. All rights reserved.
//

import Foundation

extension Locale {
    //	since our flag icons are all named using country codes
    //	we need to match the currency codes to the country codes
    
    static func countryCode(forCurrencyCode currencyCode: String) -> String? {
        
        for countryCode in NSLocale.isoCountryCodes {
        
            //	we need to build LocaleIdentifier, which can have many components
            //	one way to do it is to start from the components we do have
            //	in this case countryCode
            
            let comps = [NSLocale.Key.countryCode.rawValue: countryCode]
            
            //	now use the components to instantiate the identifier
            let localeIdentifier = identifier(fromComponents: comps)
            //	and then use it to build specific Locale instance for that id
            let locale = Locale(identifier: localeIdentifier)
            
            //	now ask this Locale instance for any other info you need
            guard let cc = locale.currencyCode else { continue }
            
            if cc == countryCode {
                return countryCode
            }
        }
        
        return nil
        
    }
}
