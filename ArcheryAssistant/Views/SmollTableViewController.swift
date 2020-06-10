//
//  SmollTableViewController.swift
//  ArcheryAssistant
//
//  Created by Samuel Arellano on 24/04/20.
//  Copyright © 2020 exusai. All rights reserved.
//

import UIKit

class SmollTableViewController: UITableViewController, InputDelegate, SelectedArrowDelegate {
    func updateSelectedArrow(with arrow: Int, section: Int, index: Int) {
        self.currentArrow = arrow
        
        if edditingSection != section {
            self.edditingSection = section
        }
        
        if index == 0 {
            self.currentInputShown = 1
        } else if currentInputShown != index + 1 {
            self.currentInputShown = index
        }
        tableView.reloadData()
    }
    
    func updateTable(with arrow: Arrow) {
        if scoreTable!.isDoubleDistance {
            if edditingSection == 0 {
                series[currentInputShown - 1].Arrows[currentArrow] = arrow
            } else {
                series[currentInputShown + 5].Arrows[currentArrow] = arrow
            }
        } else {
            series[currentInputShown - 1].Arrows[currentArrow] = arrow
        }
        self.scoreTable!.series = self.series
        currentArrow += 1
        c = 0
        tableView.reloadData()
    }
    
    var scoreTable: ScoreCard?
    
    var series: [Serie] = []
    
    let headerTitles = ["First Distance", "Second Distance"]
    
    var currentInputShown: Int = 1 {
        didSet {
            if oldValue == 6 {
                currentInputShown = 1
                if self.scoreTable!.isDoubleDistance {
                    edditingSection += 1
                }
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        series = scoreTable!.series
        tableView.dataSource = self
    }
    
    var edditingSection: Int = 0 {
        didSet{
            if oldValue == 1 {
                edditingSection = 0
            }
            c = 0
        }
    }
    
    var currentArrow: Int = 0 {
        didSet {
            if oldValue == 5 {
                currentInputShown += 1
                currentArrow = 0
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        guard let scoreTable = scoreTable else { return 0 }
        if scoreTable.isDoubleDistance {
            return 2
        } else {
            return 1
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let scoreTable = scoreTable else { return 0 }
        if scoreTable.isDoubleDistance {
            if section == edditingSection {
                return 7
            } else {
                return 6
            }
        } else {
            return 7
        }
    }
    
    var c = 0
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let scoreCell = tableView.dequeueReusableCell(withIdentifier: "scores", for: indexPath) as! ScoresTableViewCell
        let inputCell = tableView.dequeueReusableCell(withIdentifier: "scoreInput", for: indexPath) as! InputTableViewCell
        inputCell.delegate = self
        scoreCell.delegate = self
        if scoreTable!.isDoubleDistance {
            if indexPath.section != edditingSection {
                c = 0
            }
        }
        if indexPath.row == currentInputShown && indexPath.section == edditingSection {
            c = 1
            return inputCell
        } else {
            if indexPath.row == (currentInputShown - 1) && indexPath.section == edditingSection {
                scoreCell.isBeingEdited = true
                scoreCell.arrowNumber = currentArrow
            } else {
                scoreCell.isBeingEdited = false
            }
            var index = (indexPath.row - c + (indexPath.section * 6))
            if index < 0 {
                index = 0
            }
            scoreCell.section = indexPath.section
            scoreCell.cellInd = indexPath.row
            scoreCell.update(with: series[index])
            return scoreCell
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section < headerTitles.count {
            return headerTitles[section]
        }
        return nil
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if edditingSection != indexPath.section {
            self.edditingSection = indexPath.section
        }
        
        if indexPath.row == 0 {
            self.currentInputShown = 1
        } else if currentInputShown != indexPath.row + 1 {
            self.currentInputShown = indexPath.row
        } 
        c = 0
        tableView.reloadData()
    }
    @IBAction func saveButtonTapped(_ sender: Any) {
        self.scoreTable!.series = self.series
    }
}


