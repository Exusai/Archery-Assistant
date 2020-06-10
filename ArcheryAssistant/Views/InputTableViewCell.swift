//
//  InputTableViewCell.swift
//  ArcheryAssistant
//
//  Created by Samuel Arellano on 25/04/20.
//  Copyright © 2020 exusai. All rights reserved.
//

import UIKit

protocol InputDelegate: class {
    func updateTable(with arrow: Arrow)
}

class InputTableViewCell: UITableViewCell {
    
    weak var delegate: InputDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func buttonsPressed(_ sender: UIButton) {
        var arrow: Arrow
        let stringVal = sender.title(for: .normal)!
        if stringVal == "X" {
            arrow = Arrow(value: 10, isX: true)
        } else if stringVal == "M" {
            arrow = Arrow(value: 0, isX: false)
        } else {
            arrow = Arrow(value: Int(stringVal)!, isX: false)
        }
        //print("touched")
        delegate?.updateTable(with: arrow)
        //suscoreTable!.series[serie].Arrows[currentArrow] = arrow
        //tableView.beginUpdates()
        //currentArrow += 1
    }
    

}
