//
//  User.swift
//  ArcheryAssistant
//
//  Created by Samuel Arellano on 03/06/20.
//  Copyright © 2020 exusai. All rights reserved.
//

import Foundation

struct User: Codable {
    static var archiveURL: URL {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentsDirectory.appendingPathComponent("user").appendingPathExtension("plist")
        return archiveURL
    }
    
    static func loadFromFile() -> User {
        let propertyListDecoder = PropertyListDecoder()
        guard let retrivednoteData = try? Data(contentsOf: self.archiveURL),
            let decodedUsr = try? propertyListDecoder.decode(User.self, from: retrivednoteData) else { print("jelp");return User(username: "", email: "", uid: "")}
        guard let user = decodedUsr as User? else { print("error"); return User(username: "", email: "",  uid: "")}
        return user
    }
    
    static func saveToFile(user: User) {
        let propertyListEncoder = PropertyListEncoder()
        let encodedNote = try? propertyListEncoder.encode(user)
        try? encodedNote?.write(to: self.archiveURL, options: .noFileProtection)
    }
    
    var username: String
    var email: String
    var uid: String
    
    var picURL: URL? {
        return URL(string: "https://firebasestorage.googleapis.com/v0/b/archery-assistant.appspot.com/o/userPics%2F\(uid)%2FusrPic.png?alt=media")
    }
    
}
