//
//  ViewController.swift
//  Example
//
//  Created by Stas Kirichok on 28-08-2018.
//  Copyright © 2018 Windmill Smart Solutions. All rights reserved.
//

import UIKit

class SummatorViewController: UIViewController {
  
  @IBOutlet private var firstField: UITextField!
  @IBOutlet private var secondField: UITextField!
  @IBOutlet private var resultField: UITextField!
  
  private let summator = SummatorService()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    firstField.delegate = self
    secondField.delegate = self
  }
  
  private func calculateSum() {
    let firstNumber = Int(firstField.text!) ?? 0
    let secondNumber = Int(secondField.text!) ?? 0
    let result = summator.addNumbers(first: firstNumber, second: secondNumber)
    resultField.text = "\(result)"
  }
  
}

extension SummatorViewController: UITextFieldDelegate {
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    textField.text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
    calculateSum()
    
    return false
  }
  
}

