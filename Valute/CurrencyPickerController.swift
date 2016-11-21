//
//  CurrencyPickerController.swift
//  Valute
//
//  Created by iosakademija on 11/20/16.
//  Copyright © 2016 iOS akademija. All rights reserved.
//

import UIKit

protocol CurrencyPickerControllerDelegate: class {
    
    func currencyPicker(controller: CurrencyPickerController, didSelect currencyCode: String)
    
}

class CurrencyPickerController: UITableViewController {
    
    // Step 2 - Implementation of Delegate Pattern in iOS:
    // Create a weak optional property using this new protocol data type
    // Whoever wants to become a delegate for this controller, should be assigned to this property
    weak var delegate: CurrencyPickerControllerDelegate? = nil
    
    var dataSource: [String] {
        let baseArray = Locale.commonISOCurrencyCodes
        return baseArray
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
}

// MARK: - Table view data source

extension CurrencyPickerController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell", for: indexPath) as! CurrencyCell
        
        let currencyCode = dataSource[indexPath.row]
        cell.configure(withCurrencyCode: currencyCode)
        
        return cell
    }
}


// MARK: - Table view delegate

extension CurrencyPickerController {
    
}
