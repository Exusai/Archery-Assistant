//
//  ViewEditScoreCardTableViewController.swift
//  ArcheryAssistant
//
//  Created by Samuel Arellano on 15/04/20.
//  Copyright © 2020 exusai. All rights reserved.
//

import UIKit

class ViewEditScoreCardTableViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //print(distances.count)
        return distances.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //print(distances[row])
        return distances[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        distance = distances[row]
        distanceLabel.text = distances[row]
        updateMainObject()
    }
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var distancePicker: UIPickerView!
    @IBOutlet weak var doubleDistnceSwitch: UISwitch!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var sightTextField: UITextField!
    
    @IBOutlet weak var indoorOutdoorSwitcher: UISegmentedControl!
    @IBOutlet weak var practicecmpetitionSwitcher: UISegmentedControl!
    
    //firstDistance arrow vals
    @IBOutlet var serie1Arrows: [UITextField]!
    @IBOutlet var serie2Arrows: [UITextField]!
    @IBOutlet var serie3Arrows: [UITextField]!
    @IBOutlet var serie4Arrows: [UITextField]!
    @IBOutlet var serie5Arrows: [UITextField]!
    @IBOutlet var serie6Arrows: [UITextField]!
    
    //second distance arrow vals
    @IBOutlet var serie7Arrows: [UITextField]!
    @IBOutlet var serie8Arrows: [UITextField]!
    @IBOutlet var serie9Arrows: [UITextField]!
    @IBOutlet var serie10Arrows: [UITextField]!
    @IBOutlet var serie11Arrows: [UITextField]!
    @IBOutlet var serie12Arrows: [UITextField]!
    
    //first distance Sum Labels
    @IBOutlet weak var firstRoundTotal: UILabel!
    @IBOutlet weak var firstRoundX: UILabel!
    @IBOutlet weak var firstRound10: UILabel!
    
    @IBOutlet weak var secondRoundTotal: UILabel!
    @IBOutlet weak var secondRoundX: UILabel!
    @IBOutlet weak var secondRound10: UILabel!
    
    @IBOutlet weak var thirdRoundTotal: UILabel!
    @IBOutlet weak var thirdRoundX: UILabel!
    @IBOutlet weak var thirdRound10: UILabel!
    
    @IBOutlet weak var fourthRoundTotal: UILabel!
    @IBOutlet weak var fourthRoundX: UILabel!
    @IBOutlet weak var forthRound10: UILabel!
    
    @IBOutlet weak var fifthRoundTotal: UILabel!
    @IBOutlet weak var fifthRoundX: UILabel!
    @IBOutlet weak var fifthRound10: UILabel!
    
    @IBOutlet weak var sixthRoundTotal: UILabel!
    @IBOutlet weak var sixthRoundX: UILabel!
    @IBOutlet weak var sixthRound10: UILabel!
    
    
    //first distance totals
    @IBOutlet weak var firstRoundTotalLabel: UILabel! //this one is for the first distance total
    @IBOutlet weak var firstRoundTotalX: UILabel!
    @IBOutlet weak var firstRoundTotal10: UILabel!
    
    //Second distance sum labels
    @IBOutlet weak var seventhRoundTotal: UILabel!
    @IBOutlet weak var seventhRoundX: UILabel!
    @IBOutlet weak var seventhRound10: UILabel!
    
    @IBOutlet weak var eighthRoundTotal: UILabel!
    @IBOutlet weak var eighthRoundX: UILabel!
    @IBOutlet weak var eighthRound10: UILabel!
    
    @IBOutlet weak var ninethRoundTotal: UILabel!
    @IBOutlet weak var ninethRoundX: UILabel!
    @IBOutlet weak var ninethRound10: UILabel!
    
    @IBOutlet weak var tenthRoundTotal: UILabel!
    @IBOutlet weak var tenthRoundX: UILabel!
    @IBOutlet weak var tenthRound10: UILabel!
    
    @IBOutlet weak var eleventhRoundTotal: UILabel!
    @IBOutlet weak var eleventhRoundX: UILabel!
    @IBOutlet weak var eleventhRound10: UILabel!
    
    @IBOutlet weak var twelfthRoundTotal: UILabel!
    @IBOutlet weak var twelfthRoundX: UILabel!
    @IBOutlet weak var twelfthRound10: UILabel!
    
    //second distance totals
    @IBOutlet weak var secondRoundTotalLabel: UILabel! //this one is for the second distance
    @IBOutlet weak var secondRoundTotalX: UILabel!
    @IBOutlet weak var secondroundTotal10: UILabel!
    
    @IBOutlet weak var absoluteTotalLabel: UILabel!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    let datePickerCellIndexPath = IndexPath(row: 1, section: 0)
    let distancePickerCellIndexPath  = IndexPath(row: 3, section: 2)
    let dateLabelCellIndexPath = IndexPath(row: 0, section: 0)
    let distanceLabelCellIndexPath = IndexPath(row: 2, section: 2)
    let sightAndTargetButtonCellIndexPath = IndexPath(row: 0, section: 3)
    let firstTableCellIndexPath = IndexPath(row: 1, section: 3)
    let secondTableCellIndexpath = IndexPath(row: 2, section: 3)
    let absoluteTotalCellIndexpath = IndexPath(row: 3, section: 3)
    
    var isDatePickerShown: Bool = false {
        didSet {
            datePicker.isHidden = !isDatePickerShown
        }
    }
    
    var isDistancePickerShown: Bool = false {
        didSet {
            distancePicker.isHidden = !isDistancePickerShown
        }
    }
    
    var scoringCard: ScoreCard?
    var isOutdoor: Bool = true
    var isDoubleDistance: Bool = true
    var isPractice: Bool = true
    var distance: String = "0"
    var sight: String = ""
    var name: String = ""
    var user: User?
    
    var distances: [String] {
        if isOutdoor {
            let outDists = ScoreCard.outdoorDistances.keys
            return Array(outDists).sorted().reversed()
        } else {
            let inDists = ScoreCard.indoorDistances.keys
            return Array(inDists).sorted()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.date = Calendar.current.startOfDay(for: Date()) //if date has not been selected
        updateDateLabel()
        self.distancePicker.delegate = self
        self.distancePicker.dataSource = self
        
        let toolbar = UIToolbar()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.doneTapped))
        toolbar.setItems([doneButton], animated: true)
        toolbar.sizeToFit()
        let distancia1 = [serie1Arrows,serie2Arrows,serie3Arrows,serie4Arrows,serie5Arrows,serie6Arrows,serie7Arrows,serie8Arrows,serie9Arrows,serie10Arrows,serie11Arrows,serie12Arrows]
        for dist in distancia1 {
            for arrs in dist! {
                arrs.inputAccessoryView = toolbar
            }
        }
        
        user = User.loadFromFile()
        
        updateView()
    }
    
    @objc func doneTapped() {
        view.endEditing(true)
    }
    
    func updateView(){
        if let scoreCard = scoringCard {
            var scoreCard = scoreCard
            navigationItem.title = "View Score Table"
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            
            dateLabel.text = dateFormatter.string(from: scoreCard.date)
            datePicker.date = scoreCard.date
            
            doubleDistnceSwitch.isOn = scoreCard.isDoubleDistance
            distanceLabel.text = String(scoreCard.distance)
            sightTextField.text = String(scoreCard.sight)
            
            if let user = user {
                nameTextField.text = user.username
            }
            
            
            if scoreCard.name?.isEmpty == false {
                nameTextField.text = scoreCard.name
            }
            
            if scoreCard.isOutdoor {
                indoorOutdoorSwitcher.selectedSegmentIndex = 0
            } else {
                indoorOutdoorSwitcher.selectedSegmentIndex = 1
            }
            if scoreCard.isPractice {
                practicecmpetitionSwitcher.selectedSegmentIndex = 0
            } else {
                practicecmpetitionSwitcher.selectedSegmentIndex = 1
            }
            /*
            doubleDistnceSwitch.isEnabled = false
            indoorOutdoorSwitcher.isEnabled = false
            practicecmpetitionSwitcher.isEnabled = false
            distancePicker.isUserInteractionEnabled = false
            distancePicker.isOpaque = true
            */
            if scoreCard.isDoubleDistance {
                
                guard let firstTotal = scoreCard.totalPrimeraSerie else { return }
                guard let firstXs = scoreCard.totalXsPrimeraSerie else { return }
                guard let first10s = scoreCard.total10sPrimeraSerie else { return }
                guard let secondTotal = scoreCard.totalSegundaSerie else { return }
                guard let secondXs = scoreCard.totalXsSegundaSerie else { return }
                guard let second10s = scoreCard.total10sSegundaSerie else { return }
                
                firstRoundTotal.text = String(scoreCard.series[0].sum)
                secondRoundTotal.text = String(scoreCard.series[1].sum)
                thirdRoundTotal.text = String(scoreCard.series[2].sum)
                fourthRoundTotal.text = String(scoreCard.series[3].sum)
                fifthRoundTotal.text = String(scoreCard.series[4].sum)
                sixthRoundTotal.text = String(scoreCard.series[5].sum)
                seventhRoundTotal.text = String(scoreCard.series[6].sum)
                eighthRoundTotal.text = String(scoreCard.series[7].sum)
                ninethRoundTotal.text = String(scoreCard.series[8].sum)
                tenthRoundTotal.text = String(scoreCard.series[9].sum)
                eleventhRoundTotal.text = String(scoreCard.series[10].sum)
                twelfthRoundTotal.text = String(scoreCard.series[11].sum)
                
                firstRoundX.text = String(scoreCard.series[0].sumX)
                secondRoundX.text = String(scoreCard.series[1].sumX)
                thirdRoundX.text = String(scoreCard.series[2].sumX)
                fourthRoundX.text = String(scoreCard.series[3].sumX)
                fifthRoundX.text = String(scoreCard.series[4].sumX)
                sixthRoundX.text = String(scoreCard.series[5].sumX)
                seventhRoundX.text = String(scoreCard.series[6].sumX)
                eighthRoundX.text = String(scoreCard.series[7].sumX)
                ninethRoundX.text = String(scoreCard.series[8].sumX)
                tenthRoundX.text = String(scoreCard.series[9].sumX)
                eleventhRoundX.text = String(scoreCard.series[10].sumX)
                twelfthRoundX.text = String(scoreCard.series[11].sumX)
                
                firstRound10.text = String(scoreCard.series[0].sum10)
                secondRound10.text = String(scoreCard.series[1].sum10)
                thirdRound10.text = String(scoreCard.series[2].sum10)
                forthRound10.text = String(scoreCard.series[3].sum10)
                fifthRound10.text = String(scoreCard.series[4].sum10)
                sixthRound10.text = String(scoreCard.series[5].sum10)
                seventhRound10.text = String(scoreCard.series[6].sum10)
                eighthRound10.text = String(scoreCard.series[7].sum10)
                ninethRound10.text = String(scoreCard.series[8].sum10)
                tenthRound10.text = String(scoreCard.series[9].sum10)
                eleventhRound10.text = String(scoreCard.series[10].sum10)
                twelfthRound10.text = String(scoreCard.series[11].sum10)
                
                firstRoundTotalLabel.text = String(firstTotal)
                secondRoundTotalLabel.text = String(secondTotal)
                
                absoluteTotalLabel.text = String(scoreCard.total)
                
                firstRoundTotalX.text = String(firstXs)
                firstRoundTotal10.text = String(first10s)
                
                secondRoundTotalX.text = String(secondXs)
                secondroundTotal10.text = String(second10s)
                
                let distancia1 = [serie1Arrows,serie2Arrows,serie3Arrows,serie4Arrows,serie5Arrows,serie6Arrows,serie7Arrows,serie8Arrows,serie9Arrows,serie10Arrows,serie11Arrows,serie12Arrows]
                
                for ind in 0...11 {
                    scoreCard.series[ind].orderArrows()
                    let serie = distancia1[ind]
                    for index in 0...5 {
                        var text: String {
                            if scoreCard.series[ind].Arrows[index].isX {
                                return "X"
                            } else {
                                return String(scoreCard.series[ind].Arrows[index].value)
                            }
                        }
                        serie![index].text = text
                    }
                }
            } else {
                
                firstRoundTotal.text = String(scoreCard.series[0].sum)
                secondRoundTotal.text = String(scoreCard.series[1].sum)
                thirdRoundTotal.text = String(scoreCard.series[2].sum)
                fourthRoundTotal.text = String(scoreCard.series[3].sum)
                fifthRoundTotal.text = String(scoreCard.series[4].sum)
                sixthRoundTotal.text = String(scoreCard.series[5].sum)
                
                firstRoundX.text = String(scoreCard.series[0].sumX)
                secondRoundX.text = String(scoreCard.series[1].sumX)
                thirdRoundX.text = String(scoreCard.series[2].sumX)
                fourthRoundX.text = String(scoreCard.series[3].sumX)
                fifthRoundX.text = String(scoreCard.series[4].sumX)
                sixthRoundX.text = String(scoreCard.series[5].sumX)
                
                firstRound10.text = String(scoreCard.series[0].sum10)
                secondRound10.text = String(scoreCard.series[1].sum10)
                thirdRound10.text = String(scoreCard.series[2].sum10)
                forthRound10.text = String(scoreCard.series[3].sum10)
                fifthRound10.text = String(scoreCard.series[4].sum10)
                sixthRound10.text = String(scoreCard.series[5].sum10)
                
                firstRoundTotalLabel.text = String(scoreCard.total)
                firstRoundTotal10.text = String(scoreCard.total10s)
                firstRoundTotalX.text = String(scoreCard.totalXs)
                
                let distancia1 = [serie1Arrows,serie2Arrows,serie3Arrows,serie4Arrows,serie5Arrows,serie6Arrows]
                for ind in 0...5 {
                    scoreCard.series[ind].orderArrows()
                    let serie = distancia1[ind]
                    for index in 0...5 {
                        var text: String {
                            if scoreCard.series[ind].Arrows[index].isX {
                                return "X"
                            } else {
                                return String(scoreCard.series[ind].Arrows[index].value)
                            }
                        }
                        serie![index].text = text
                    }
                }
            }
            
        } else {
            navigationItem.title = "New Score Table"
            scoringCard = ScoreCard.newScoreCard()
        }
    }
    
    func updateDateLabel() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateLabel.text = dateFormatter.string(from: datePicker.date)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case datePickerCellIndexPath:
            if isDatePickerShown {
                return 216.0
            } else {
                return 0.0
            }
        case distancePickerCellIndexPath:
            if isDistancePickerShown {
                return 216.0
            } else {
                return 0.0
            }
        case secondTableCellIndexpath:
            if doubleDistnceSwitch.isOn {
                return 260.0
            } else {
                return 0.0
            }
        case absoluteTotalCellIndexpath:
            if doubleDistnceSwitch.isOn {
                return 44.0
            } else {
                return 0.0
            }
        case firstTableCellIndexPath:
            return 260
        case sightAndTargetButtonCellIndexPath:
            return 88.0
        default:
            return 44.0
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath {
        case dateLabelCellIndexPath:
            if isDatePickerShown {
                isDatePickerShown = false
            } else if isDistancePickerShown {
                isDistancePickerShown = false
                isDatePickerShown = true
            } else {
                isDatePickerShown = true
            }
            tableView.beginUpdates()
            tableView.endUpdates()
        case distanceLabelCellIndexPath:
            if isDistancePickerShown {
                isDistancePickerShown = false
            } else if isDatePickerShown {
                isDatePickerShown = false
                isDistancePickerShown = true
            } else {
                isDistancePickerShown = true
            }
            tableView.beginUpdates()
            tableView.endUpdates()
        default:
            break
        }
    }

    @IBAction func cambioDeModalidad(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            //print("outdoor")
            isDistancePickerShown = false
            isOutdoor = true
            distancePicker.reloadAllComponents()
            tableView.beginUpdates()
            tableView.endUpdates()
        case 1:
            //print("Indoor")
            isDistancePickerShown = false
            isOutdoor = false
            distancePicker.reloadAllComponents()
            tableView.beginUpdates()
            tableView.endUpdates()
        default:
            break
        }
        updateMainObject()
        
    }
    
    @IBAction func changePracticeToCompetition(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            isPractice = true
        case 1:
            isPractice = false
        default:
            break
        }
        updateMainObject()
    }
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
       updateDateLabel()
        //dobLabel.textColor = .white
        //dobLabel.text = dateFormatter.string(from: birthDayDatePicker.date)
        updateMainObject()
    }
    
    @IBAction func doubleDistanceToogle(_ sender: Any) {
        isDoubleDistance.toggle()
        tableView.beginUpdates()
        tableView.endUpdates()
        updateMainObject()
    }
    
    @IBAction func sightChanged(_ sender: UITextField) {
        guard let sightValue = sightTextField.text else { return }
        sight = sightValue
        self.scoringCard!.sight = Double(sightValue) ?? 0.0
        //print(sender.text)
        updateMainObject()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //updateMainObject()
        if segue.identifier == "toTarget" {
            updateMainObject()
            let newViewController = segue.destination as? ScoreViewController
            newViewController?.scoreTable = scoringCard
        }
        
    }
    
    func updateMainObject() {
        self.scoringCard!.date = datePicker.date
        self.scoringCard!.isOutdoor = self.isOutdoor
        self.scoringCard!.isPractice = self.isPractice
        self.isDoubleDistance = doubleDistnceSwitch.isOn
        self.scoringCard!.isDoubleDistance = self.isDoubleDistance
        self.scoringCard!.name = nameTextField.text
        //self.scoringCard!.distance = Int(String(self.distance.prefix(2))) ?? 0
        self.scoringCard!.distance = Int(String(self.distanceLabel.text!.prefix(2))) ?? 0
        self.scoringCard!.sight = Double(self.sightTextField.text!) ?? 0.0
        if self.scoringCard!.isDoubleDistance {
            let distancia1 = [serie1Arrows,serie2Arrows,serie3Arrows,serie4Arrows,serie5Arrows,serie6Arrows,serie7Arrows,serie8Arrows,serie9Arrows,serie10Arrows,serie11Arrows,serie12Arrows]
            for ind in 0...11 {
                let serie = distancia1[ind]
                for index in 0...5 {
                    var val = 0
                    var isX = false
                    if serie![index].text! == "X"{
                        val = 10
                        isX = true
                    } else {
                        val = Int(serie![index].text!) ?? 0
                    }
                    self.scoringCard!.series[ind].Arrows[index].value = val
                    self.scoringCard!.series[ind].Arrows[index].isX = isX
                }
                self.scoringCard!.series[ind].orderArrows()
            }
        } else {
            let distancia1 = [serie1Arrows,serie2Arrows,serie3Arrows,serie4Arrows,serie5Arrows,serie6Arrows]
            for ind in 0...5 {
                let serie = distancia1[ind]
                for index in 0...5 {
                    var val = 0
                    var isX = false
                    if serie![index].text! == "X"{
                        val = 10
                        isX = true
                    } else {
                        val = Int(serie![index].text!) ?? 0
                    }
                    self.scoringCard!.series[ind].Arrows[index].value = val
                    self.scoringCard!.series[ind].Arrows[index].isX = isX
                }
                self.scoringCard!.series[ind].orderArrows()
                }
        }
        
    }
    
    @IBAction func unwindToScoreTable(_ segue: UIStoryboardSegue) {}
    
    @IBAction func unwindSaveToScoreTable(_ segue: UIStoryboardSegue) {
        guard segue.identifier == "saveUnwindToScoreTable",
            let sourceViewController = segue.source as? ScoreViewController,
            let scoreTableWMod = sourceViewController.scoreTable else { return }
        self.scoringCard = scoreTableWMod
        
        //tableView.reloadRows(at: [firstTableCellIndexPath,secondTableCellIndexpath], with: .none)
        //tableView.reloadData()
        updateView()
        updateMainObject()
    }
    
}
