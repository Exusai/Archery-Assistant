//
//  ScoresTableViewCell.swift
//  ArcheryAssistant
//
//  Created by Samuel Arellano on 24/04/20.
//  Copyright © 2020 exusai. All rights reserved.
//

import UIKit

protocol SelectedArrowDelegate: class {
    func updateSelectedArrow(with arrow: Int, section: Int, index: Int)
}

class ScoresTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    weak var delegate: SelectedArrowDelegate?

    @IBOutlet var arrowPoints: [UITextField]!
    @IBOutlet weak var totalLabel: UILabel!
    
    var arrowNumber = 0 {
        didSet {
            if oldValue == 5 {
                arrowNumber = 0
            }
        }
    }
    
    var isBeingEdited: Bool = false
    var section: Int?
    var cellInd: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        for arrowTextField in arrowPoints {
            arrowTextField.delegate = self
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        var ind = 0
        for arrowTextField in arrowPoints {
            if arrowTextField == textField {
                delegate?.updateSelectedArrow(with: ind, section: section!, index: cellInd!)
            }
            ind += 1
        }
        //updateArrowLabels()
        return false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func update(with serie: Serie) {
        //print("updating w serie")
        var ind = 0
        for texField in arrowPoints {
            var text: String {
                if serie.Arrows[ind].isX {
                    return "X"
                } /*else if serie.Arrows[ind].isM {
                    return "M"
                }*/ else {
                    return String(serie.Arrows[ind].value)
                }
            }
            texField.text = text
            ind += 1
        }
        totalLabel.text = String(serie.sum)
        if isBeingEdited {
            updateArrowLabels()
        } else {
            deSelectAllArrowLabels()
        }
    }
    
    func updateArrowLabels() {
        var ind = 0
        for arrowLabel in arrowPoints {
            if ind == arrowNumber {
                arrowLabel.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            } else {
                arrowLabel.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0)
            }
            ind += 1
        }
    }
    
    func deSelectAllArrowLabels() {
        for arrowLabel in arrowPoints {
            arrowLabel.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0)
        }
    }
    
    override func prepareForReuse() {
        //print("reusing cell")
        super.prepareForReuse()
        isBeingEdited = false
        arrowNumber = 0
        deSelectAllArrowLabels()
        //updateArrowLabels()
        for arrowLabel in arrowPoints {
            arrowLabel.text = ""
        }
        //self.isHidden = true
    }

}
