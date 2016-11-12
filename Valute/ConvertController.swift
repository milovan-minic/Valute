//
//  ConvertController.swift
//  Valute
//
//  Created by iosakademija on 11/1/16.
//  Copyright © 2016 iOS akademija. All rights reserved.
//

import UIKit

class ConvertController: UIViewController {
    
    var dataSource: [String] = {
        return Locale.commonISOCurrencyCodes
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    ////////////////////////////
    // Outlets and Actions //
    // TODO: Potrazi Paw app za analizu api poziva
    
    
    
    @IBOutlet weak var decimalButton: UIButton!
    @IBAction func decimalButtonTapped(_ sender: UIButton) {
    }
    
    
    @IBOutlet weak var deleteButton: UIButton!
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
    }
    
    // = Button
    @IBOutlet weak var equalsButton: UIButton!
    // TODO: Add Action
    
    
    @IBOutlet var digitButtons: [UIButton]!
    func digitButtonTapped(_ sender: UIButton) {
        
    }
    
    
    @IBOutlet var operatorButtons: [UIButton]!
    func operationButtonTapped(_ sender: UIButton) {
        
    }
    
    // Definicija tipa
    // vrednost "none" znaci da ni jedna operacija trenutno nije aktivna
    enum ArithmeticOperation {
        case none
        case add, subtract, divide, multiply
        case equals
    }
    
    // 
    var exqalOperation = ArithmeticOperation.none
    
    //	promenljive za čuvanje unetih brojeva
    //	izabrao sam da budu decimalni brojevi, uvek
    var firstOperand = 0.0
    var secondOperand = 0.0
    
    
    
    ////////////////////////////
    
}


typealias UISetup = ConvertController
extension UISetup {
    
    func assignButtonTaps() {
        for btn in digitButtons {
            btn.addTarget(self, action: #selector(ConvertController.digitButtonTapped(_:)), for: .touchUpInside)
        }
        for btn in operatorButtons {
            btn.addTarget(self, action: #selector(ConvertController.operationButtonTapped(_:)), for: .touchUpInside)
        }
    }
    
    func assignButtonTargets() {
        let allButtons = digitButtons + operatorButtons + [decimalButton, deleteButton]
        
        for btn in allButtons {
//            btn.addTarget(self, action: #selector(ConvertController.didTouchButton(_:)), for: .touchDown)
            btn.addTarget(self, action: #selector(ConvertController.didTouchButton(_:)), for: .touchDown)
            
            btn.addTarget(self, action: #selector(ConvertController.didUntouchButton(_:)), for: .touchCancel)
            btn.addTarget(self, action: #selector(ConvertController.didUntouchButton(_:)), for: .touchUpOutside)
        }
    }
    
    
    
    
    func didTouchButton(_ sender: UIButton){
        
    }
    
    func didUntouchButton(_ sender: UIButton) {
        
    }
    
    func configureDecimalButton() {
        let locale = NSLocale.current
        guard let decimalSign = locale.decimalSeparator else { return }
        decimalButton.setTitle(decimalSign, for: .normal)
    }
    
    func cleanupUI() {
        
    }
    
}



typealias ViewLifecycle = ConvertController
extension ViewLifecycle {
    override func viewDidLoad() {
        self.title = self.navigationItem.title?.uppercased()
        
        assignButtonTargets()
        assignButtonTaps()
        configureDecimalButton()
        cleanupUI()
    }
}
























