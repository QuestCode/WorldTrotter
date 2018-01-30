//
//  ConversionViewController.swift
//  tempature
//
//  Created by Devontae Reid on 1/29/18.
//  Copyright © 2018 Devontae Reid. All rights reserved.
//

import UIKit

class ConversionViewController: UIViewController {

    @IBOutlet weak var celsiusLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func fahrenheitFieldEditingChanged(_ sender: UITextField) {
        
        if let text = sender.text, !text.isEmpty {
            let celsius = convertToCelsius(degrees: text)
            self.celsiusLabel.text = celsius
        } else {
            celsiusLabel.text = "???"
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        textField.resignFirstResponder()
    }
    
    private func convertToCelsius(degrees: String) -> String {
        let celsius = (Double(degrees)! - 32) * (5/9)
        return String(format: "%.2f",celsius)
    }
    
}
