//
//  MyBowViewController.swift
//  ArcheryAssistant
//
//  Created by Samuel Arellano on 11/05/20.
//  Copyright © 2020 exusai. All rights reserved.
//

import UIKit

class MyBowViewController: UIViewController {

    @IBOutlet weak var bowNameTextField: UITextField!
    @IBOutlet weak var upperTillerTextField: UITextField!
    @IBOutlet weak var braceHeightTextField: UITextField!
    @IBOutlet weak var lowerTillerTextField: UITextField!
    @IBOutlet weak var nockHeightTextField: UITextField!
    
    var myBow: Bow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myBow = Bow.loadFromFile()
        let toolbar = UIToolbar()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.doneTapped))
        toolbar.setItems([doneButton], animated: true)
        toolbar.sizeToFit()
        
        bowNameTextField.inputAccessoryView = toolbar
        upperTillerTextField.inputAccessoryView = toolbar
        braceHeightTextField.inputAccessoryView = toolbar
        lowerTillerTextField.inputAccessoryView = toolbar
        nockHeightTextField.inputAccessoryView = toolbar
        
        updateView()
    }
    
    @objc func doneTapped() {
        view.endEditing(true)
        updateModel()
        guard let myBow = myBow else { return }
        Bow.saveToFile(bow: myBow)
        updateView()
    }
    
    func updateView() {
        guard let myBow = myBow else { return }
        if myBow.name?.isEmpty == false {
            bowNameTextField.text = myBow.name
        }
        upperTillerTextField.text = String(myBow.supTiller!)
        braceHeightTextField.text = String(myBow.braceHeight!)
        lowerTillerTextField.text = String(myBow.infTiller!)
        nockHeightTextField.text = String(myBow.nockHeight!)
    }
    
    func updateModel() {
        myBow!.name = bowNameTextField.text
        myBow!.supTiller = Double(upperTillerTextField.text!)
        myBow!.braceHeight = Double(braceHeightTextField.text!)
        myBow!.infTiller = Double(lowerTillerTextField.text!)
        myBow!.nockHeight = Double(nockHeightTextField.text!)
    }
    
    @IBAction func ediitingChanged(_ sender: Any) {
        updateModel()
    }
    
}
