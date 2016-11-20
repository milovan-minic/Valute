//
//  CurrencyBox.swift
//  Valute
//
//  Created by iosakademija on 11/15/16.
//  Copyright © 2016 iOS akademija. All rights reserved.
//

import UIKit

class CurrencyBox: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var currencyCodeLabel: UILabel!
    
    //	using computed property for both get/set
    var ammountText: String? {
        get {
            return textField.text
        }

        set(str) {
            textField.text = str
        }
    }
    
    func configure(withCurrencyCode currencyCode: String) {
        // update label
        currencyCodeLabel.text = currencyCode
        
        // update flag image, using Locale framework
        guard let countryCode = Locale.countryCode(forCurrencyCode: currencyCode) else {
            flagImageView.image = nil
            return
        }
        
        flagImageView.image = UIImage(named: countryCode.lowercased())
    }

}
