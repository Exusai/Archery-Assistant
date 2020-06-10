//
//  ScoreViewController.swift
//  ArcheryAssistant
//
//  Created by Samuel Arellano on 20/04/20.
//  Copyright © 2020 exusai. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController, UIScrollViewDelegate, UITextFieldDelegate {
    
    var scoreTable: ScoreCard?
    var arrowNumber = 0 {
        didSet {
            if oldValue == 5 {
                stepper.value += 1
                arrowNumber = 0
            }
        }
    }

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var buttonContainer: UIView!
    
    @IBOutlet weak var numberOfSerieLabel: UILabel!
    @IBOutlet weak var totalOfThisEnd: UILabel!
    
    @IBOutlet var arrowTextFields: [UITextField]!
    @IBOutlet weak var progress: UIProgressView!
    @IBOutlet weak var stepper: UIStepper!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 5.0
        scrollView.contentSize = .init(width: 2500, height: 2500)
        updateZoomFor(size: view.bounds.size)
        if scoreTable!.isDoubleDistance {
            stepper.maximumValue = 11
        } else {
            stepper.maximumValue = 5
        }
        
        for arrowTextField in arrowTextFields {
            arrowTextField.delegate = self
        }
        
        updateView()
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        var ind = 0
        for arrowTextField in arrowTextFields {
            if arrowTextField == textField {
                arrowNumber = ind
            }
            ind += 1
        }
        updateView()
        return false
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return buttonContainer
    }
    
    func updateZoomFor(size: CGSize) {
        let widthScale = size.width / buttonContainer.bounds.width
        let heightScale = size.height / buttonContainer.bounds.height
        let scale = min(widthScale, heightScale)
        scrollView.minimumZoomScale = scale
        scrollView.zoomScale = scale
    }
    
    func updateArrowLabels() {
        var ind = 0
        for arrowLabel in arrowTextFields {
            if ind == arrowNumber {
                arrowLabel.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            } else {
                arrowLabel.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0)
            }
            ind += 1
        }
    }
    
    func updateView() {
        guard let scoreTable = scoreTable else { return }
        updateArrowLabels()
        progress.progress = Float(stepper.value / stepper.maximumValue)
        numberOfSerieLabel.text = "Round: \(String(Int(stepper.value) + 1))"
        var ind = 0
        for texField in arrowTextFields {
            var text: String {
                if scoreTable.series[Int(stepper.value)].Arrows[ind].isX {
                    return "X"
                } else {
                    return String(scoreTable.series[Int(stepper.value)].Arrows[ind].value)
                }
            }
            texField.text = text
            ind += 1
        }
        totalOfThisEnd.text = String(scoreTable.series[Int(stepper.value)].sum)
    }
    
    @IBAction func stepperChanged(_ sender: Any) {
        updateView()
    }
    
    @IBAction func tapped(_ sender: UIButton) {
        scoreTable?.series[Int(stepper.value)].Arrows[arrowNumber].value = 1
        scoreTable?.series[Int(stepper.value)].Arrows[arrowNumber].isX = false
        //scoreTable?.series[Int(stepper.value)].orderArrows()
        arrowNumber += 1
        updateView()
    }
    @IBAction func twoPointTapped(_ sender: Any) {
        scoreTable?.series[Int(stepper.value)].Arrows[arrowNumber].value = 2
        scoreTable?.series[Int(stepper.value)].Arrows[arrowNumber].isX = false
        //scoreTable?.series[Int(stepper.value)].orderArrows()
        arrowNumber += 1
        updateView()
    }
    @IBAction func threePointTapped(_ sender: Any) {
        scoreTable?.series[Int(stepper.value)].Arrows[arrowNumber].value = 3
        scoreTable?.series[Int(stepper.value)].Arrows[arrowNumber].isX = false
        //scoreTable?.series[Int(stepper.value)].orderArrows()
        arrowNumber += 1
        updateView()
    }
    @IBAction func fourPointTapped(_ sender: Any) {
        scoreTable?.series[Int(stepper.value)].Arrows[arrowNumber].value = 4
        scoreTable?.series[Int(stepper.value)].Arrows[arrowNumber].isX = false
        //scoreTable?.series[Int(stepper.value)].orderArrows()
        arrowNumber += 1
        updateView()
    }
    @IBAction func fivePointTapped(_ sender: Any) {
        scoreTable?.series[Int(stepper.value)].Arrows[arrowNumber].value = 5
        scoreTable?.series[Int(stepper.value)].Arrows[arrowNumber].isX = false
        //scoreTable?.series[Int(stepper.value)].orderArrows()
        arrowNumber += 1
        updateView()
    }
    @IBAction func sixPointTapped(_ sender: Any) {
        scoreTable?.series[Int(stepper.value)].Arrows[arrowNumber].value = 6
        scoreTable?.series[Int(stepper.value)].Arrows[arrowNumber].isX = false
        //scoreTable?.series[Int(stepper.value)].orderArrows()
        arrowNumber += 1
        updateView()
    }
    @IBAction func sevenPointTapped(_ sender: Any) {
        scoreTable?.series[Int(stepper.value)].Arrows[arrowNumber].value = 7
        scoreTable?.series[Int(stepper.value)].Arrows[arrowNumber].isX = false
        //scoreTable?.series[Int(stepper.value)].orderArrows()
        arrowNumber += 1
        updateView()
    }
    @IBAction func eightPointTapped(_ sender: Any) {
        scoreTable?.series[Int(stepper.value)].Arrows[arrowNumber].value = 8
        scoreTable?.series[Int(stepper.value)].Arrows[arrowNumber].isX = false
        //scoreTable?.series[Int(stepper.value)].orderArrows()
        arrowNumber += 1
        updateView()
    }
    @IBAction func ninePointTapped(_ sender: Any) {
        scoreTable?.series[Int(stepper.value)].Arrows[arrowNumber].value = 9
        scoreTable?.series[Int(stepper.value)].Arrows[arrowNumber].isX = false
        //scoreTable?.series[Int(stepper.value)].orderArrows()
        arrowNumber += 1
        updateView()
    }
    @IBAction func tenPointTapped(_ sender: Any) {
        scoreTable?.series[Int(stepper.value)].Arrows[arrowNumber].value = 10
        scoreTable?.series[Int(stepper.value)].Arrows[arrowNumber].isX = false
        //scoreTable?.series[Int(stepper.value)].orderArrows()
        arrowNumber += 1
        updateView()
    }
    @IBAction func xPointTapped(_ sender: Any) {
        scoreTable?.series[Int(stepper.value)].Arrows[arrowNumber].value = 10
        scoreTable?.series[Int(stepper.value)].Arrows[arrowNumber].isX = true
        //scoreTable?.series[Int(stepper.value)].orderArrows()
        arrowNumber += 1
        updateView()
    }
    
    
    @IBAction func unwindToScoreView(_ segue: UIStoryboardSegue) {}
    
    @IBAction func unwindSaveToScoreView(_ segue: UIStoryboardSegue) {
        guard segue.identifier == "saveUnwindToScore",
            let sourceViewController = segue.source as? SmollTableViewController,
            let scoreTableWMod = sourceViewController.scoreTable else { return }
        self.scoreTable = scoreTableWMod
        updateView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "table" {
            let vc = segue.destination as! SmollTableViewController
            guard let scoreTable = scoreTable else { return }
            //print(scoreTable.isDoubleDistance)
            vc.scoreTable = scoreTable
        }
    }
    
    //@IBAction func tapRecognition(_ sender: UITapGestureRecognizer) {
    //    let location = sender.location(in: buttonContainer)
    //    print(location)
    //}
    
}
