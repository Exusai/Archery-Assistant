//
//  Bow.swift
//  ArcheryAssistant
//
//  Created by Samuel Arellano on 10/05/20.
//  Copyright © 2020 exusai. All rights reserved.
//

import Foundation

struct Bow: Codable {
    
    static var archiveURL: URL {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentsDirectory.appendingPathComponent("bow_settings").appendingPathExtension("plist")
        return archiveURL
    }
    
    static func loadFromFile() -> Bow {
        let propertyListDecoder = PropertyListDecoder()
        guard let retrivednoteData = try? Data(contentsOf: self.archiveURL),
            let decodedNote = try? propertyListDecoder.decode(Bow.self, from: retrivednoteData) else { print("jelp");return Bow(name: "", supTiller: 0.0, braceHeight: 0.0, nockHeight: 0.0, infTiller: 0.0, arrowLenght: 0.0)}
        guard let scoreCards = decodedNote as Bow? else { print("error") }
        return scoreCards
    }
    
    static func saveToFile(bow: Bow) {
        let propertyListEncoder = PropertyListEncoder()
        let encodedNote = try? propertyListEncoder.encode(bow)
        try? encodedNote?.write(to: self.archiveURL, options: .noFileProtection)
    }
    
    var name: String?
    var supTiller: Double?
    var braceHeight: Double?
    var nockHeight: Double?
    var infTiller: Double?
    var arrowLenght: Double?
}
