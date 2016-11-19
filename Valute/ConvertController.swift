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
    
    let formatter : NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        return nf
    }()

    ////////////////////////////
    // Outlets and Actions //
    // TODO: Potrazi Paw app za analizu api poziva
    
    
    
    @IBOutlet weak var decimalButton: UIButton!
    @IBAction func decimalButtonTapped(_ sender: UIButton) {
    
//    guard let numString = sender.title(for: .normal) else { return }
//    var value = resultField.text ?? ""
//    defer {
//        self.didUntouchButton(sender)
//    }
    
//    if value.contains(numString) {
//        return
//    }
    
//    value += numString
//    resultField.text = value
    }
    
    
    @IBOutlet weak var deleteButton: UIButton!
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
//        var value = resultField.text ?? ""
//        guard value.characters.count > 0 else { return }
//        var chars = value.characters
//        chars.removeLast()
//        resultField.text = String(chars)
    }
    
    
    
    // = Button
    @IBOutlet weak var equalsButton: UIButton!
    // TODO: Add Action
    
    
    @IBOutlet var digitButtons: [UIButton]!
//    func digitButtonTapped(_ sender: UIButton) {
//        
//    }
    
    
    @IBOutlet var operatorButtons: [UIButton]!
//    func operationButtonTapped(_ sender: UIButton) {
//        
//    }
    
    // Definicija tipa
    // vrednost "none" znaci da ni jedna operacija trenutno nije aktivna
    enum ArithmeticOperation {
        case none
        case add, subtract, divide, multiply
        case equals
    }
    
    // 
    var activeOperation = ArithmeticOperation.none
    
    //	promenljive za čuvanje unetih brojeva
    //	izabrao sam da budu decimalni brojevi, uvek
    var firstOperand = 0.0
    var secondOperand = 0.0
    
    // sakrijem znak =, a prikazem operator
    
    @IBOutlet weak var leadingCurrencyBox: CurrencyBox!
    @IBOutlet weak var trailingCurrencyBox: CurrencyBox!
    
    
    // dodavanje leadingCurrencyBox-a kao source
    var sourceCurrencyBox: CurrencyBox {
        return leadingCurrencyBox
    }
    
    // dodavanje trailingCurrencyBox-a kao target
    var targgetCurrencyBox: CurrencyBox {
        return trailingCurrencyBox
    }
    
    // data model za konverter
    var sourceCurrencyCode: String! {
        didSet {
            sourceCurrencyBox.configure(withCurrencyCode: sourceCurrencyCode)
        }
    }
    var targetCurrencyCode: String! {
        didSet {
            targgetCurrencyBox.configure(withCurrencyCode: targetCurrencyCode)
        }
    }
    var currencyRate: Double?
    
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
    
    
    
    /// Sets currencies for startup
    func setupInitailCurrencies() {
        // privremeno dodate valute koje ce se koristiti za funkcionisanje konvertera
        self.sourceCurrencyCode = "BRL"
        self.targetCurrencyCode = "AED"
        
    }
    
    func cleanupUI() {
        
        // sakrivanje znaka =, a prikazivanje operatora
        self.equalsButton.alpha = 0
        // dodavanje alpha kanala za svu ostalu dugmad na maksimum
        self.operatorButtons.forEach {
            (btn) in  btn.alpha = 1
        }
        
        // obrisati sadrzaj tekst filda pre pocetka rada aplikacije
        self.leadingCurrencyBox.textField.text = nil
        self.trailingCurrencyBox.textField.text = nil
        
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
        setupInitailCurrencies()
    }
}


typealias Internal = ConvertController
extension Internal {
    
    func validateOperandInput() -> Double? {
//    guard let numString = resultFieldText else {
//        return nil
//    }
//    
//    let num formater.number(from: numString)?.doubleValue
//    return num
    return 0
}


    func digitButtonTapped(_ sender: UIButton) {
        guard let numString = sender.title(for: .normal) else { return }
        
//        var value = resultField.text ?? ""
        
        defer {
            self.didUntouchButton(sender)
        }
        
//        value += numString
        
//        resultField.text = value
    }
    
    func operationButtonTapped(_ sender: UIButton) {
//        var isEquals = false
//        
//        // uhvatiti sta pise na dugmetu
//        guard let caption = sender.title(for: .normal) else {
//            fatalError("Received operator button tap from from button with no caption on it!")
//        }
//        
//        // pa podsiti vrednosti prema tome
//        switch caption {
//            case "+":
//                activeOperation = .add
//            case "-":
//                activeOperation = .subtract
//            case "×":
//                activeOperation = .multiply
//            case "÷":
//                activeOperation = .divide
//            case "=":
//                isEquals = true
//            default:
//                activeOperation = .none
//        }
//        
//        if (isEquals) {
//            // pritisnut je taster =
//            // to znaci da je unesen i drugi operand
//            guard let num = validateOperandInput() else {
//                resultField.text = nil
//                return
//            }
//            
//            secondOperand = num
//            
//            // sada izracunaj operaciju
//            var rez = firstOperand
//            
//            switch activeOperation {
//            case .add:
//                rez += secondOperand
//            case .subtract:
//                rez -= secondOperand
//            case .multiply:
//                rez *= secondOperand
//            case .divide:
//                rez /= secondOperand
//            default:
//                break
//            }
//            
//            // i ispisi rezultate u tekst fildu
//            resultField.text = formatter.string(for: rez)
//            
//            // clean out placeholders
//            firstOperand = 0
//            secondOperand = 0
//        } else if activeOperation != .none {
//            //	pritisnut je neki od aritm. operatora
//            //	to znači da je unet prvi operand
//            guard let num = validateOperandInput() else {
//                resultField.text = nil
//                return
//            }
//            firstOperand = num
//            //	obriši prikaz i time se spremi za unos drugog operanda
//            resultField.text = nil
//        }
//        self.didUntouchButton(sender)
        
    }
}






































