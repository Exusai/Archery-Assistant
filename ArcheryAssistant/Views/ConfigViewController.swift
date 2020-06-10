//
//  ConfigViewController.swift
//  ArcheryAssistant
//
//  Created by Samuel Arellano on 03/06/20.
//  Copyright © 2020 exusai. All rights reserved.
//

import UIKit
import FirebaseStorage

class ConfigViewController: UIViewController {
    @IBOutlet weak var usrImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    var usr: User?
    var data: [ScoreCard]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usrImage.layer.masksToBounds = false
        usrImage.layer.cornerRadius = usrImage.frame.height/2
        usrImage.clipsToBounds = true
        usrImage.contentMode = .scaleAspectFit
        usr = User.loadFromFile()
        guard let usr = usr else { return }
        if !usr.username.isEmpty && !usr.uid.isEmpty {
            userName.text = usr.username
            guard let url = usr.picURL else { usrImage.contentMode = .scaleAspectFit; return }
            usrImage.load(url: url)
            usrImage.contentMode = .scaleAspectFill
        }
        
        
    }
    @IBAction func backUp(_ sender: Any) {
        data = ScoreCard.loadFromFile()
        guard let data = data else { errorAlert(); return }
        guard let user = usr else { errorAlert(); return }
        let encoder = JSONEncoder()
        let jsonData = try? encoder.encode(data)
        guard let jsonDataToUpload = jsonData else { errorAlert(); return }
        let storageRef = Storage.storage().reference()
        let ref = "userScores/\(user.uid)/scores.json"
        let usrScores = storageRef.child(ref)
        _ = usrScores.putData(jsonDataToUpload, metadata: nil) { (metadata, error ) in
            guard metadata != nil else { self.errorAlert(); return }
            self.succesAlert1()
        }
    }
    @IBAction func load(_ sender: Any) {
        guard let usr = usr  else { errorAlert(); return }
        let storageRef = Storage.storage().reference()
        let ref = "userScores/\(usr.uid)/scores.json"
        let usrScores = storageRef.child(ref)
        usrScores.getData(maxSize: 500 * 1024 * 1024) { (data, error) in
            if let _ = error {
                self.errorAlert()
            } else {
                guard let data = data else { return }
                let jsonDecoder = JSONDecoder()
                let newData = try? jsonDecoder.decode(Array<ScoreCard>.self, from: data)
                guard let newCards = newData else { self.errorAlert(); return }
                ScoreCard.saveToFile(cards: newCards)
                self.succesAlert()
            }
        }
        
        
        
    }
    
    func errorAlert() {
        let alertController = UIAlertController(title: "Error", message: "An error has ocurred, try again later and make sure you are loged", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alertController, animated: true, completion: nil)
    }

    func succesAlert1() {
        let alertController = UIAlertController(title: "Succes", message: "Your points have been saved", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func succesAlert() {
        let alertController = UIAlertController(title: "Succes", message: "Your points have been loaded, I recomend you to re-launch the app", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func unwindToConfView(_ segue: UIStoryboardSegue) {}

}



extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
