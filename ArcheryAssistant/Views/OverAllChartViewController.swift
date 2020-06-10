//
//  OverAllChartViewController.swift
//  ArcheryAssistant
//
//  Created by Samuel Arellano on 08/05/20.
//  Copyright © 2020 exusai. All rights reserved.
//

import UIKit
import Charts

class OverAllChartViewController: UIViewController, ChartViewDelegate {

    lazy var lineChart: LineChartView = {
        let chartView = LineChartView()
        
        chartView.rightAxis.enabled = false
        
        let yAxis = chartView.leftAxis
        yAxis.labelPosition = .outsideChart
        yAxis.axisMinimum = 0
        yAxis.axisMaximum = 360
        yAxis.setLabelCount(6, force: true)
        yAxis.xOffset = 10.0
        
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.axisMinimum = 1
        chartView.animate(yAxisDuration: 1)
        chartView.doubleTapToZoomEnabled = false
        return chartView
    }()
    
    var scoreCards: [ScoreCard] = []
    var forceLabels: Bool = true
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreCards = ScoreCard.loadFromFile()
        if scoreCards.isEmpty {
            scoreCards = ScoreCard.loadSampleCards()
        } else {
            scoreCards = ScoreCard.loadFromFile()
        }
        scoreCards.sort()
        if scoreCards.count > 30 {
            forceLabels = false
        }
        lineChart.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        scoreCards = ScoreCard.loadFromFile()
        if scoreCards.isEmpty {
            scoreCards = ScoreCard.loadSampleCards()
        } else {
            scoreCards = ScoreCard.loadFromFile()
        }
        scoreCards.sort()
        
        lineChart.delegate = self
        viewDidLayoutSubviews()
        //LineChartView().animate(yAxisDuration: 1)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        lineChart.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        lineChart.center = view.center
        lineChart.xAxis.axisMaximum = Double(scoreCards.count)
        lineChart.xAxis.setLabelCount(scoreCards.count, force: forceLabels)
        view.addSubview(lineChart)
        
        var entries = [ChartDataEntry]()
        var ind: Double = 0
        //var cards = [ScoreCard]()
        var totalDistancias = [Double]()
        
        for card in scoreCards {
            if card.isDoubleDistance {
                totalDistancias.append(Double(card.totalPrimeraSerie!))
                totalDistancias.append(Double(card.totalSegundaSerie!))
            } else {
                totalDistancias.append(Double(card.total))
            }
        }
        
        for total in totalDistancias {
            ind += 1
            entries.append(ChartDataEntry(x: ind, y: total))
        }
        
        let set = LineChartDataSet(entries: entries, label: "Points per round")
        set.setColor(.systemBlue)
        set.fill = Fill(color: .systemBlue)
        set.fillAlpha = 0.25
        set.drawCirclesEnabled = forceLabels
        set.circleHoleColor = .systemYellow
        set.setCircleColor(.systemRed)
        set.mode = .linear
        set.drawFilledEnabled = true
        
        let data = LineChartData(dataSet: set)
        lineChart.data = data
    }

}
