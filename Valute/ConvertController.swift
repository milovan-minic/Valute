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
    
    let formatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        return nf
    }()

    ////////////////////////////
    // Outlets and Actions //
    // TODO: Potrazi Paw app za analizu api poziva
    
    
    
    @IBOutlet weak var decimalButton: UIButton!
    @IBAction func decimalButtonTapped(_ sender: UIButton) {
        
        defer {
            self.didUntouchButton(sender)
        }
    
    guard let numString = sender.title(for: .normal) else { return }
    var value = sourceCurrencyBox.ammountText ?? ""
    
    if value.contains(numString) {
        return
    }
    
    value += numString
    
    sourceCurrencyBox.ammountText = value
    }
    
    
    @IBOutlet weak var deleteButton: UIButton!
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        
        defer {
            self.didUntouchButton(sender)
        }
        
        var value = sourceCurrencyBox.ammountText ?? ""
        guard value.characters.count > 0 else { return }
        
        var chars = value.characters
        chars.removeLast()
        sourceCurrencyBox.ammountText = String(chars)
    }
    
    
    
    // = Button
    @IBOutlet weak var equalsButton: UIButton!
    // TODO: Add Action
    
    
    @IBOutlet var digitButtons: [UIButton]!
//    func digitButtonTapped(_ sender: UIButton) {
//        
//        defer {
//            self.didUntouchButton(sender)
//        }
//        
//    }
    
    
    @IBOutlet var operatorButtons: [UIButton]!

    
    // CALCULATIONS
    
    // Definicija tipa: vrsta aritmeticke operacije
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
    
    // CURRENCIES
    
    //	ovo treba da bude referenca na currencybox koji je inicirao promenu
    //	pa onda delegate poziv na osnovu ovoga zna šta da radi
    var changeCurrencyBox: CurrencyBox? = nil
    
    // sakrijem znak =, a prikazem operator
    
    @IBOutlet weak var leadingCurrencyBox: CurrencyBox!
    @IBOutlet weak var trailingCurrencyBox: CurrencyBox!
    
    
    // dodavanje leadingCurrencyBox-a kao source
    var sourceCurrencyBox: CurrencyBox {
        return leadingCurrencyBox
    }
    
    // dodavanje trailingCurrencyBox-a kao target
    var targetCurrencyBox: CurrencyBox {
        return trailingCurrencyBox
    }
    
    // data model za konverter
    var sourceCurrencyCode: String! {
        didSet {
            sourceCurrencyBox.configure(withCurrencyCode: sourceCurrencyCode)
            UserDefaults.sourceCurrencyCode = sourceCurrencyCode
        }
    }
    var targetCurrencyCode: String! {
        didSet {
            targetCurrencyBox.configure(withCurrencyCode: targetCurrencyCode)
            UserDefaults.targetCurrencyCode = targetCurrencyCode
        }
    }
    var currencyRate: Double?
    
    // TOUCHES
    
    var buttonOriginalBackgroundColor: UIColor?
    
    ////////////////////////////
}


typealias UISetup = ConvertController
extension UISetup {
    
    func assignButtonTaps() {
        for btn in digitButtons {
            btn.addTarget(self, action: #selector(ConvertController.digitButtonTapped(_:)), for: .touchUpInside)
        }

        let operators = operatorButtons + [equalsButton]
        for btn in operators {
            btn.addTarget(self, action: #selector(ConvertController.operationButtonTapped(_:)), for: .touchUpInside)
        }
    }
    
    func assignButtonTargets() {
        let allButtons = digitButtons + operatorButtons + [decimalButton, deleteButton, equalsButton]
        
        for btn in allButtons {
//            btn.addTarget(self, action: #selector(ConvertController.didTouchButton(_:)), for: .touchDown)
            btn.addTarget(self, action: #selector(ConvertController.didTouchButton(_:)), for: .touchDown)
            
            btn.addTarget(self, action: #selector(ConvertController.didUntouchButton(_:)), for: .touchCancel)
            btn.addTarget(self, action: #selector(ConvertController.didUntouchButton(_:)), for: .touchUpOutside)
        }
    }
    
    
    
    
    func didTouchButton(_ sender: UIButton){
        buttonOriginalBackgroundColor = sender.backgroundColor
        
        // prvo, ako nema boje, koristiti veoma providnu crnu
        guard let _ = sender.backgroundColor else {
            sender.backgroundColor = UIColor.black.withAlphaComponent(0.2)
            return
        }
        
        // Posto je boja pozadine za dugmad vec delimicno providna,
        // onda treba povecati alpha komponentu da bi se video tap
        
        // Evo nacina da se izvuku RGBA komponente iz UIColor
        // postaviti podrazumevanu (crna)
        
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        // i providnost namestiti na 20%
        var a: CGFloat = 0.2
        
        // ovaj metod ce dodati komponentama navedenim iznad za datu UIColor vrednost
        guard let _ = sender.backgroundColor?.getRed(&r, green: &g, blue: &b, alpha: &a) else {
            // ako ekstrakcija ne uspe, postaviti boju na crnu sa 20% providnosti
            sender.backgroundColor = UIColor.black.withAlphaComponent(0.2)
            return
        }
        
        // ako uspe, onda postavi boju sa duplom vrednosti alpha komponente
        sender.backgroundColor = UIColor(red: r, green: g, blue: b, alpha: a*2)
        
    }
    
    func didUntouchButton(_ sender: UIButton) {
        
        sender.backgroundColor = buttonOriginalBackgroundColor
        buttonOriginalBackgroundColor = nil
        
    }
    
    func configureDecimalButton() {
        let locale = NSLocale.current
        guard let decimalSign = locale.decimalSeparator else { return }
        decimalButton.setTitle(decimalSign, for: .normal)
    }
    
    
    
    /// Sets currencies for startup
    func setupInitailCurrencies() {
        // privremeno dodate valute koje ce se koristiti za funkcionisanje konvertera
        self.sourceCurrencyCode = UserDefaults.sourceCurrencyCode ?? "USD"
        self.targetCurrencyCode = UserDefaults.targetCurrencyCode ?? "EUR"
        
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
    
    func setupCurrencyBoxes() {
        sourceCurrencyBox.delegate = self
        targetCurrencyBox.delegate = self
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
        setupCurrencyBoxes()
    }
}


typealias Internal = ConvertController
extension Internal {
    
    func validateOperandInput() -> Double? {
    guard let numString = sourceCurrencyBox.ammountText else {
        return nil
    }

    let num = formatter.number(from: numString)?.doubleValue
    return num

}


    func digitButtonTapped(_ sender: UIButton) {
        
        defer {
            self.didUntouchButton(sender)
        }
        
        guard let numString = sender.title(for: .normal) else { return }
        
        var value = sourceCurrencyBox.ammountText ?? ""
        
        value += numString
        
        sourceCurrencyBox.ammountText = value
        
    }
    
    func operationButtonTapped(_ sender: UIButton) {
        
        defer {
            self.didUntouchButton(sender)
        }
        
        var isEquals = false
    
//        // uhvatiti sta pise na dugmetu
        guard let caption = sender.title(for: .normal) else {
            fatalError("Received operator button tap from from button with no caption on it!")
        }

//        // pa podsiti vrednosti prema tome
        switch caption {
            case "+":
                activeOperation = .add
            case "-":
                activeOperation = .subtract
            case "×":
                activeOperation = .multiply
            case "÷":
                activeOperation = .divide
            case "=":
                isEquals = true
            default:
                activeOperation = .none
        }

        if (isEquals) {
            // pritisnut je taster =
            // to znaci da je unesen i drugi operand
            guard let num = validateOperandInput() else {
                sourceCurrencyBox.ammountText = nil
                return
            }
            
            secondOperand = num
            
            // sada izracunaj operaciju
            var rez = firstOperand
            
            switch activeOperation {
            case .add:
                rez += secondOperand
            case .subtract:
                rez -= secondOperand
            case .multiply:
                rez *= secondOperand
            case .divide:
                rez /= secondOperand
            default:
                break
            }
            
            // i ispisi rezultate u tekst fildu
            sourceCurrencyBox.ammountText = formatter.string(for: rez)
            
            // pobrisi placeholdere
            firstOperand = 0
            secondOperand = 0
            
            // ponovo prikazi dugmad za operacije i sakrij dugme =
            UIView.animate(withDuration: 0.4, animations: {
                self.equalsButton.alpha = 0
                self.operatorButtons.forEach { (btn) in
                    btn.alpha = 1
                }
            })
            
        } else if activeOperation != .none {
            //	pritisnut je neki od aritmetickih operatora
            //	to znaci da je unet prvi operand
            guard let num = validateOperandInput() else {
                sourceCurrencyBox.ammountText = nil
                return
            }
            firstOperand = num
            //	obrisi prikaz i time se spremi za unos drugog operanda
            sourceCurrencyBox.ammountText = nil
            
            // sakrij svu dugmad za operacije i prikazi dugme =
            UIView.animate(withDuration: 0.25, animations: {
                self.equalsButton.alpha = 1
                self.operatorButtons.forEach { (btn) in
                    btn.alpha = 0
                }
            })
        }
    }
}



extension ConvertController: CurrencyBoxDelegate {
    
    func currencyBoxInitiatedChange(_ currencyBox: CurrencyBox) {
        
    }
}


extension ConvertController: CurrencyPickerControllerDelegate {
    // Step4: adopt the protocol and implement the required method

    func currencyPicker(controller: CurrencyPickerController, didSelect currencyCode: String) {
        // update the currency...
        // which box?
    }
}






































