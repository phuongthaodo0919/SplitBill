//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    var tipPercentage = 0.1
    var numberOfPeople = 1
    var totalPerPerson = "0.0"
    var tipPercentageStr = "10%"

    @IBOutlet weak var billTextField: UITextField!
    
    @IBOutlet weak var zeroPtcButton: UIButton!
    
    @IBOutlet weak var tenPtcButton: UIButton!
    
    @IBOutlet weak var twentyPtcButton: UIButton!
    
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    @IBAction func tipChanged(_ sender: UIButton) {
        zeroPtcButton.isSelected = false
        tenPtcButton.isSelected = false
        twentyPtcButton.isSelected = false
        sender.isSelected = true
        
        tipPercentageStr = sender.currentTitle!
        let tipPercentageStr = String(tipPercentageStr.dropLast(1))
        tipPercentage = Double(tipPercentageStr)!/100
        
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        
        splitNumberLabel.text = String(format: "%.0f",sender.value)
        numberOfPeople = Int(sender.value)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        billTextField.endEditing(true)
        let bill = billTextField.text!
        if bill != "" {
            let billTotal = Double(bill)!
            let result = billTotal * (1+tipPercentage) / Double(numberOfPeople)
            totalPerPerson = String(format:"%.2f",result)
        }
        //Show the next screen
        self.performSegue(withIdentifier: "gotoResult", sender: self)
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoResult" {
            let destinationVC = segue.destination as! ResultsViewController  //as!: force downcasting the controller to ResultsViewController
            destinationVC.tipPercentage = tipPercentageStr
            destinationVC.splitPerson = numberOfPeople
            destinationVC.totalPerPerson = totalPerPerson
        }
    }

}

