//
//  LogRegViewController.swift
//  ArcheryAssistant
//
//  Created by Samuel Arellano on 03/06/20.
//  Copyright © 2020 exusai. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

class LogRegViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var segmentedController: UISegmentedControl!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var usernameStack: UIStackView!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var chosePhotobutton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var usernameText: UITextField!
    
    var usrPic: Data?
    var picUrl: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerForKeyboardNotifications()
        title = "Login"
        navBar.topItem?.title = "Login"
        registerButton.isHidden = true
        usernameStack.isHidden = true
        loginButton.isHidden = false
        chosePhotobutton.isHidden = true
        
        loginButton.isEnabled = false
        registerButton.isEnabled = false
        
        imageView.layer.masksToBounds = false
        imageView.layer.cornerRadius = imageView.frame.height/2
        imageView.clipsToBounds = true
        
    }
    
    @IBAction func indexChanged(_ sender: Any) {
        switch segmentedController.selectedSegmentIndex {
        case 0:
            title = "Login"
            navBar.topItem?.title = "Login"
            registerButton.isHidden = true
            usernameStack.isHidden = true
            chosePhotobutton.isHidden = true
            loginButton.isHidden = false
        case 1:
            title = "Register"
            navBar.topItem?.title = "Register"
            registerButton.isHidden = false
            usernameStack.isHidden = false
            loginButton.isHidden = true
            chosePhotobutton.isHidden = false
        default:
            title = "Login"
            navBar.topItem?.title = "Login"
            registerButton.isHidden = true
            usernameStack.isHidden = true
            loginButton.isHidden = false
            chosePhotobutton.isHidden = true
        }
    }
    
    @IBAction func textChanged(_ sender: UITextField) {
        guard !emailText.text!.isEmpty else { return }
        guard !passwordText.text!.isEmpty else { return }
        guard passwordText.text!.count >= 6 else { return }
        loginButton.isEnabled = true
        guard !usernameText.text!.isEmpty else { return }
        registerButton.isEnabled = true
    }
    
    @IBAction func cameraButton(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
               imagePicker.delegate = self
               let alertController = UIAlertController(title: "Chose image source", message: nil, preferredStyle: .actionSheet)
               let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
               alertController.addAction(cancelAction)
               
               if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                   let libraryAction = UIAlertAction(title: "Photo library", style: .default, handler: {
                       action in imagePicker.sourceType = .photoLibrary
                       self.present(imagePicker, animated: true, completion: nil)
                   })
                   alertController.addAction(libraryAction)
               }
               
               alertController.popoverPresentationController?.sourceView = sender
               present(alertController,animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        imageView.image = selectedImage
        imageView.contentMode = .scaleAspectFill
        usrPic = selectedImage.pngData()
        dismiss(animated: true, completion: nil)
    }
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWasShown(_ notificiation: NSNotification) {
        guard let info = notificiation.userInfo,
            let keyboardFrameValue = info[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue else { return }
        let keyboardFrame = keyboardFrameValue.cgRectValue
        let keyboardSize = keyboardFrame.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillBeHidden(_ notification: NSNotification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @IBAction func logInButton(_ sender: Any) {
        guard let email = emailText.text else { return }
        guard let password = passwordText.text else { return }
        Auth.auth().signIn(withEmail: email, password: password) {
            (result, error) in
            if let result = result, error == nil {
                
                let db = Firestore.firestore()
                let ref = db.collection("users").document(result.user.uid)
                ref.getDocument { (document, error) in
                    if let document = document, document.exists {
                    let docData = document.data()
                    let logedUser = User(username: docData!["username"] as! String, email: docData!["email"] as! String, uid: result.user.uid)
                    User.saveToFile(user: logedUser)
                 } else {
                    print("Document does not exist")

                 }
                }
                
            }
        }
        self.performSegue(withIdentifier: "UnwindToConfig", sender: sender)
    }
    
    @IBAction func registerbutton(_ sender: Any) {
        if let email = emailText.text, let password = passwordText.text{
            Auth.auth().createUser(withEmail: email, password: password) {
                (result, error) in
                if let result = result, error == nil {
                    guard let mail = result.user.email, let username = self.usernameText.text  else { return }
                    let storageRef = Storage.storage().reference()
                    let db = Firestore.firestore()
                    let ref = "userPics/\(result.user.uid)/usrPic.png"
                    let usrPicRef = storageRef.child(ref)
                    if let usrPic = self.usrPic {
                        _ = usrPicRef.putData(usrPic, metadata: nil){ (metadata, error) in
                            guard metadata != nil else {print("error in uploadig pic");return}
                        }
                        /*
                        usrPicRef.downloadURL { (url, error) in
                            guard let url = url else { print("error rethiving URL"); return }
                            let newUser = User(username: username, email: mail, picURL: url, uid: result.user.uid)
                            User.saveToFile(user: newUser)
                        }*/
                        let newUser = User(username: username, email: mail, uid: result.user.uid)
                        User.saveToFile(user: newUser)
                        db.collection("users")
                            .document(result.user.uid).setData([
                                "username" : username,
                                "email" : email,
                                "image" : newUser.picURL!.absoluteString
                            ]){ [weak self] err in
                                    guard let self = self else { return }
                                    if let err = err {
                                        print("err ... \(err)")
                                    }
                                    else {
                                        print("saved ok")
                                    }
                            }
                        
                    } else {
                        let newUser = User(username: username, email: mail, uid: result.user.uid)
                        User.saveToFile(user: newUser)
                        db.collection("users")
                        .document(result.user.uid).setData([
                            "username" : username,
                            "email" : email,
                            "image" : newUser.picURL!.absoluteString
                        ]){ [weak self] err in
                                guard let self = self else { return }
                                if let err = err {
                                    print("err ... \(err)")
                                }
                                else {
                                    print("saved ok")
                                }
                        }
                    }
                    
                    //let newUser = User(username: username, email: mail, picURL: nil, uid: result.user.uid)
                    //User.saveToFile(user: newUser)
                    self.performSegue(withIdentifier: "UnwindToConfig", sender: sender)
                    //let newUser = User(username: username, email: mail, picURL: <#T##String#>, uid: result.user.uid)
                } else {
                    let alertController = UIAlertController(title: "Error", message: "An error has ocurred, try again later", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Ok", style: .default))
                    self.present(alertController, animated: true, completion: nil)
                    print(error!)
                }
            }
        }
    }
    
}


