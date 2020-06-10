//
//  LastPracticeChartViewController.swift
//  ArcheryAssistant
//
//  Created by Samuel Arellano on 08/05/20.
//  Copyright © 2020 exusai. All rights reserved.
//

import UIKit
import Charts

class LastPracticeChartViewController: UIViewController, ChartViewDelegate {
    
    lazy var lineChart: LineChartView = {
        let chartView = LineChartView()
        
        chartView.rightAxis.enabled = false
        
        let yAxis = chartView.leftAxis
        yAxis.labelPosition = .outsideChart
        yAxis.axisMinimum = 0
        yAxis.axisMaximum = 70
        yAxis.setLabelCount(8, force: true)
        yAxis.xOffset = 10.0
        //yAxis.centerAxisLabelsEnabled = true
        
        
        chartView.xAxis.labelPosition = .bottom
        chartView.animate(yAxisDuration: 1)
        chartView.doubleTapToZoomEnabled = false
        //chartView.animate(xAxisDuration: 1)
        return chartView
    }()
    
    
    var scoreCards: [ScoreCard] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreCards = ScoreCard.loadFromFile()
        if scoreCards.isEmpty {
            scoreCards = ScoreCard.loadSampleCards()
        } else {
            scoreCards = ScoreCard.loadFromFile()
        }
        scoreCards.sort()
        
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
        if scoreCards[0].isDoubleDistance {
            lineChart.xAxis.axisMaximum = 12
            lineChart.xAxis.setLabelCount(12, force: true)
            //lineChart.xAxis.axisRange = 12
        } else {
            lineChart.xAxis.axisMaximum = 6
            lineChart.xAxis.setLabelCount(6, force: true)
            //lineChart.xAxis.axisRange = 6
        }
        view.addSubview(lineChart)
        
        var entries = [ChartDataEntry]()
        var ind: Double = 0
        var series = [Serie]()
        
        if scoreCards[0].isDoubleDistance == false {
            series = [scoreCards[0].series[0],scoreCards[0].series[1],scoreCards[0].series[2],scoreCards[0].series[3],scoreCards[0].series[4],scoreCards[0].series[5]]
        } else {
            series = scoreCards[0].series
        }
        
        for serie in series {
            ind += 1
            entries.append(ChartDataEntry(x: ind, y: Double(serie.sum)))
        }
        
        let set = LineChartDataSet(entries: entries, label: "Your points per end/set")
        set.setColor(.systemBlue)
        set.fill = Fill(color: .systemBlue)
        set.fillAlpha = 0.25
        set.drawCirclesEnabled = true
        set.circleHoleColor = .systemYellow
        set.setCircleColor(.systemRed)
        set.mode = .linear
        set.drawFilledEnabled = true
        
        let data = LineChartData(dataSet: set)
        lineChart.data = data
    }

}
