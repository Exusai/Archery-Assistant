//
//  ScoreTableViewController.swift
//  ArcheryAssistant
//
//  Created by Samuel Arellano on 16/04/20.
//  Copyright © 2020 exusai. All rights reserved.
//

import UIKit

class ScoreTableViewController: UITableViewController {
    
    var scoreCards: [ScoreCard] = []
    
    var selectedIndexPath: IndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreCards = ScoreCard.loadFromFile()
        
        if scoreCards.isEmpty {
            scoreCards = ScoreCard.loadSampleCards()
        } else {
            scoreCards = ScoreCard.loadFromFile()
        }
        scoreCards.sort()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return scoreCards.count
        } else {
            return 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScoreCardCell", for: indexPath) as! ScoreTableViewCell
        
        let card = scoreCards[indexPath.row]
        cell.update(with: card)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedIndexPath = indexPath
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
        scoreCards.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        ScoreCard.saveToFile(cards: scoreCards)
     }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ViewEditScoreCard" {
            selectedIndexPath = nil
            let indexPath = tableView.indexPathForSelectedRow!
            let scoreCard = scoreCards[indexPath.row]
            let viewEditScoreTableCard = segue.destination as! ViewEditScoreCardTableViewController
            //let viewEditScoreTableCard = navController.topViewController as! ViewEditScoreCardTableViewController
            viewEditScoreTableCard.scoringCard = scoreCard
        }
    }
    
    
    @IBAction func unwindSaveToMainTable(_ segue: UIStoryboardSegue) {
        guard segue.identifier == "saveUnwindToMainTable",
            let sourceViewController = segue.source as? ViewEditScoreCardTableViewController,
            let scoreTableWMod = sourceViewController.scoringCard else { return }
        let modCard = scoreTableWMod
        
        if let selectedIndexPath = selectedIndexPath {
            scoreCards[selectedIndexPath.row] = modCard
            ScoreCard.saveToFile(cards: scoreCards)
            tableView.reloadRows(at: [selectedIndexPath], with: .none)
        } else {
            //let newIndexPath = IndexPath(row: scoreCards.count, section: 0)
            scoreCards.insert(modCard, at: 0)
            ScoreCard.saveToFile(cards: scoreCards)
            tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        }
        
    }

}
