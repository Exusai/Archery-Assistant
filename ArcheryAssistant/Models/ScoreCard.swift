//
//  ScoreCard.swift
//  ArcheryAssistant
//
//  Created by Samuel Arellano on 14/04/20.
//  Copyright © 2020 exusai. All rights reserved.
//

import Foundation



struct ScoreCard: Codable, Comparable {
    static func < (lhs: ScoreCard, rhs: ScoreCard) -> Bool {
        lhs.date > rhs.date
    }
    
    static func == (lhs: ScoreCard, rhs: ScoreCard) -> Bool {
        lhs.date == rhs.date
    }
    
    
    static var archiveURL: URL {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentsDirectory.appendingPathComponent("score_cards").appendingPathExtension("plist")
        return archiveURL
    }
    
    static let indoorDistances: [String : Int] = [
        "18m" : 18,
        "9m" : 9,
    ]
    
    static let outdoorDistances: [String : Int] = [
        //"100m" : 100,
        "90m" : 90,
        "80m" : 80,
        "70m" : 70,
        "60m" : 60,
        "50m" : 50,
        "40m" : 40,
        "30m" : 30,
        "20m" : 20,
    ]
    
    var series: [Serie] = []
    var isDoubleDistance: Bool
    var date: Date
    var distance: Int
    var name: String?
    var isOutdoor: Bool
    var isPractice: Bool
    var sight: Double
    
    var total: Int {
        var total: Int = 0
        for serie in self.series {
            for arrow in serie.Arrows {
                total += arrow.value
            }
        }
        return total
    }
    
    var totalXs: Int {
        var totalX: Int = 0
        for serie in self.series {
            for arrow in serie.Arrows{
                if arrow.isX {
                    totalX += 1
                }
            }
        }
        return totalX
    }
    
    var total10s: Int {
        var total10: Int = 0
        for serie in self.series {
            for arrow in serie.Arrows{
                if arrow.value == 10 {
                    total10 += 1
                }
            }
        }
        return total10
    }
    
    var totalPrimeraSerie: Int? {
        if isDoubleDistance {
            var total: Int = 0
            for serie in self.series[0...5] {
                for arrow in serie.Arrows {
                    total += arrow.value
                }
            }
            return total
        } else { return nil }
    }
    
    var totalXsPrimeraSerie: Int? {
        if isDoubleDistance {
            var totalX: Int = 0
            for serie in self.series[0...5] {
                for arrow in serie.Arrows{
                    if arrow.isX {
                        totalX += 1
                    }
                }
            }
            return totalX
        } else { return nil}
        
    }
    
    var total10sPrimeraSerie: Int? {
        if isDoubleDistance {
            var total10: Int = 0
            for serie in self.series[0...5] {
                for arrow in serie.Arrows{
                    if arrow.value == 10 {
                        total10 += 1
                    }
                }
            }
            return total10
        } else {return nil}
    }
    
    var totalSegundaSerie: Int? {
        if isDoubleDistance {
            var total: Int = 0
            for serie in self.series[6...11] {
                for arrow in serie.Arrows {
                    total += arrow.value
                }
            }
            return total
        } else { return nil }
    }
    
    var totalXsSegundaSerie: Int? {
        if isDoubleDistance {
            var totalX: Int = 0
            for serie in self.series[6...11] {
                for arrow in serie.Arrows{
                    if arrow.isX {
                        totalX += 1
                    }
                }
            }
            return totalX
        } else { return nil }
    }
    
    var total10sSegundaSerie: Int? {
        if isDoubleDistance {
            var total10: Int = 0
            for serie in self.series[6...11] {
                for arrow in serie.Arrows{
                    if arrow.value == 10 {
                        total10 += 1
                    }
                }
            }
            return total10
        } else { return nil}
    }
    
    static func loadFromFile() -> [ScoreCard] {
        let propertyListDecoder = PropertyListDecoder()
        guard let retrivednoteData = try? Data(contentsOf: self.archiveURL),
            let decodedNote = try? propertyListDecoder.decode(Array<ScoreCard>.self, from: retrivednoteData) else { print("jelp");return [] }
        guard let scoreCards = decodedNote as [ScoreCard]? else { print("error") }
        return scoreCards
    }
    
    static func saveToFile(cards: [ScoreCard]) {
        let propertyListEncoder = PropertyListEncoder()
        let encodedNote = try? propertyListEncoder.encode(cards)
        try? encodedNote?.write(to: self.archiveURL, options: .noFileProtection)
    }
    
    static func loadSampleCards() -> [ScoreCard] {
        let ar1 = Arrow(value: 10, isX: false)
        let ar2 = Arrow(value: 8, isX: false)
        let ar3 = Arrow(value: 8, isX: false)
        let ar4 = Arrow(value: 10, isX: true)
        let ar5 = Arrow(value: 7, isX: false)
        let ar6 = Arrow(value: 0, isX: false)
        
        
        let arrs = [ar1,ar2,ar3,ar4,ar5,ar6]

        let serie1 = Serie(Arrows: arrs)
        let serie2 = Serie(Arrows: arrs)
        let serie3 = Serie(Arrows: arrs)
        let serie4 = Serie(Arrows: arrs)
        let serie5 = Serie(Arrows: arrs)
        let serie6 = Serie(Arrows: arrs)

        let sers = [serie1,serie2,serie3,serie4,serie5,serie6]
        let sers2 = [serie1,serie2,serie3,serie4,serie5,serie6,serie1,serie2,serie3,serie4,serie5,serie6]
        
        return [
            ScoreCard(series: sers, isDoubleDistance: false, date: Date(), distance: 70,  isOutdoor: true, isPractice: true, sight: 5.5),
            ScoreCard(series: sers2, isDoubleDistance: true, date: Date(), distance: 70, isOutdoor: true, isPractice: false, sight: 7.55),
            ScoreCard(series: sers, isDoubleDistance: false, date: Date(), distance: 18, isOutdoor: false, isPractice: true, sight: 20.3),
        ]
    }
    
    static func newScoreCard() -> ScoreCard {
        let ar1 = Arrow(value: 0, isX: false)
        let ar2 = Arrow(value: 0, isX: false)
        let ar3 = Arrow(value: 0, isX: false)
        let ar4 = Arrow(value: 0, isX: false)
        let ar5 = Arrow(value: 0, isX: false)
        let ar6 = Arrow(value: 0, isX: false)
        let arrs = [ar1,ar2,ar3,ar4,ar5,ar6]
        let serie1 = Serie(Arrows: arrs)
        let serie2 = Serie(Arrows: arrs)
        let serie3 = Serie(Arrows: arrs)
        let serie4 = Serie(Arrows: arrs)
        let serie5 = Serie(Arrows: arrs)
        let serie6 = Serie(Arrows: arrs)
        let sers = [serie1,serie2,serie3,serie4,serie5,serie6,serie1,serie2,serie3,serie4,serie5,serie6]
        return ScoreCard(series: sers,isDoubleDistance: true, date: Date(), distance: 0, isOutdoor: true, isPractice: false, sight: 0.0)
    }
    
}



