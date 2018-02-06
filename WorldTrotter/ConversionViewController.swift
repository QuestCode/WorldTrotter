//
//  ConversionViewController.swift
//  tempature
//
//  Created by Devontae Reid on 1/29/18.
//  Copyright © 2018 Devontae Reid. All rights reserved.
//

import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate {

    // MARK: - Properties -
    @IBOutlet weak var degreeFLabel: UILabel!
    @IBOutlet weak var isReallyLabel: UILabel!
    @IBOutlet weak var degreeCLabel: UILabel!
    @IBOutlet weak var celsiusLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    var fahrenheitValue: Measurement<UnitTemperature>? {
        didSet {
            updateCelsiusLabel()
        }
    }
    var celsiusValue: Measurement<UnitTemperature>? {
        if let fahrenheitValue = fahrenheitValue {
            return fahrenheitValue.converted(to: .celsius)
        } else {
            return nil
        }
    }
    
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let date = Date()
        let calendar = Calendar.current
        if calendar.component(.hour, from: date) >= 17 {
            // orginal rgb(225,88,41)
            view.backgroundColor = UIColor.black

            
            let ciColor = CIColor(color: celsiusLabel.textColor!)
            let isReallyCIColor = CIColor(color: isReallyLabel.textColor!)
            let textFieldCIColor = CIColor(color: UIColor(red: 199/256, green: 199/256, blue: 205/256, alpha: 1.0))
            
            let newRed = 1.0 - ciColor.red
            let newGreen = 1.0 - ciColor.green
            let newBlue = 1.0 - ciColor.blue
            
            let newIsReallyRed = 1.0 - isReallyCIColor.red
            let newIsReallyGreen = 1.0 - isReallyCIColor.green
            let newIsReallyBlue = 1.0 - isReallyCIColor.blue
            
            let newTextFieldRed = 1.0 - textFieldCIColor.red
            let newTextFieldGreen = 1.0 - textFieldCIColor.green
            let newTextFieldBlue = 1.0 - textFieldCIColor.blue
            
            celsiusLabel.textColor = UIColor(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
            textField.textColor = UIColor(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
            degreeFLabel.textColor = UIColor(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
            degreeCLabel.textColor = UIColor(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
            isReallyLabel.textColor = UIColor(red: newIsReallyRed, green: newIsReallyGreen, blue: newIsReallyBlue, alpha: 1.0)
            textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder!,
                                                                 attributes: [NSAttributedStringKey.foregroundColor: UIColor(red: newTextFieldRed, green: newTextFieldGreen, blue: newTextFieldBlue, alpha: 1.0)])
            
        }
        
    }
    
    // MARK: - Class Functions -
    
    @IBAction func fahrenheitFieldEditingChanged(_ sender: UITextField) {
        
        if let text = sender.text, let value = Double(text) {
            if !letterIsFound(input: text) {
                fahrenheitValue = Measurement(value: value, unit: .fahrenheit)
            }
        } else {
            fahrenheitValue = nil
        }
    }
    
    private func updateCelsiusLabel() {
        if let celsiusValue = celsiusValue {
            celsiusLabel.text = numberFormatter.string(from: NSNumber(value: celsiusValue.value))
        } else {
            celsiusLabel.text = "???"
        }
    }
    
    
    private func letterIsFound(input: String) -> Bool {
        let letters = NSCharacterSet.letters
        
        if let _ = input.rangeOfCharacter(from: letters) {
            return true
        } else {
            return false
        }
    }
    
    // Close keyboard
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        textField.resignFirstResponder()
    }
    
    private func convertToCelsius(degrees: String) -> String {
        let celsius = (Double(degrees)! - 32) * (5/9)
        return String(format: "%.2f",celsius)
    }
    
    // MARK: - Delegate Functions -
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        if letterIsFound(input: string) {
            return false
        } else {
            let existingTextHasDecimalSeparator = textField.text?.range(of: ".")
            let replacementTextHasDecimalSeparator = string.range(of: ".")
            
            if existingTextHasDecimalSeparator != nil,
                replacementTextHasDecimalSeparator != nil {
                return false
            } else {
                return true
            }
        }
    }
    
}
