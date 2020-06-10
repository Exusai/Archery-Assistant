//
//  ScoreTableViewCell.swift
//  ArcheryAssistant
//
//  Created by Samuel Arellano on 16/04/20.
//  Copyright © 2020 exusai. All rights reserved.
//

import UIKit

class ScoreTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update(with card: ScoreCard) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateLabel.text = dateFormatter.string(from: card.date)
        let distanceText = String(card.distance)
        var isDoubledist: String {
            if card.isDoubleDistance {
                return "Double"
            } else {
                return "Single"
            }
        }
        detailLabel.text = "\(distanceText)m \(isDoubledist)"
        pointsLabel.text = String(card.total)
    }

}
