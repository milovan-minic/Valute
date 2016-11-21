//
//  CurrencyCell.swift
//  Valute
//
//  Created by iosakademija on 11/20/16.
//  Copyright © 2016 iOS akademija. All rights reserved.
//

import UIKit

class CurrencyCell: UITableViewCell {

    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var currencyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    currencyLabel.text = nil
    iconView.image = nil
        
    }
    
    func configure(withCurrencyCode currencyCode: String) {
        
        // azuriraj labelu
        currencyLabel.text = currencyCode
        
        // azuriraj zastavu koristeci Locale framework
        guard let countryCode = Locale.countryCode(forCurrencyCode: currencyCode) else {
            iconView.image = nil
            return
        }
        
        iconView.image = UIImage(named: countryCode.lowercased())
    }
}
