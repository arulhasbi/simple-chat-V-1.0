//
//  ChatViewController.swift
//  simple-chat
//
//  Created by Arul on 10/8/17.
//  Copyright © 2017 69 Rising. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var messageTableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    var messageArray : [Message] = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        messageTableView.delegate = self
        messageTableView.dataSource = self
        messageTextfield.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped))
        // Do any additional setup after loading the view.
        messageTableView.addGestureRecognizer(tapGesture)
        // 3
        messageTableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "customMessageCell")
        configureTableView()
        retrieveMessage()
    }
    
    @objc func tableViewTapped() {
        messageTextfield.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logoutButton(_ sender: Any) {
        let alert = UIAlertController(title: "Logout", message: "Are you sure want to logout ?", preferredStyle: .alert)
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel)
        let actionLogout = UIAlertAction(title: "Logout", style: .default) { (action) in
            do {
                try Auth.auth().signOut()
                print("Logout Success !")
                guard (self.navigationController?.popToRootViewController(animated: true)) != nil
                    else {
                        print("Nothing is returned !, already in root view controller !")
                        return
                }
            } catch {
                print(error)
            }
        }
        alert.addAction(actionLogout)
        alert.addAction(actionCancel)
        present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    // 1
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 2
        let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell", for: indexPath) as! CustomMessageCell
        cell.messageBody.text = messageArray[indexPath.row].messageBody
        cell.senderUsername.text = messageArray[indexPath.row].sender
        cell.avatarImageView.image = UIImage(named: "logo - brainstorm")
        return cell
    }
    
    func configureTableView() {
        messageTableView.rowHeight = UITableViewAutomaticDimension
        messageTableView.estimatedRowHeight = 120.0
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.23) {
            self.heightConstraint.constant = 310
            self.view.layoutIfNeeded()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.23) {
            self.heightConstraint.constant = 50
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func sendButtonPressed(_ sender: Any) {
        if messageTextfield.text != "" {
            messageTextfield.endEditing(true)
            messageTextfield.isEnabled = false
            sendButton.isEnabled = false
            
            let messagesDB = Database.database().reference().child("Meesages")
            let messageDictionary = ["Sender" : Auth.auth().currentUser?.email, "MeesageBody": messageTextfield.text!]
            messagesDB.childByAutoId().setValue(messageDictionary) {
                (error, ref) in
                if error != nil {
                    print(error!)
                }
                else {
                    print("Message Has Been Sent Successfully !")
                    self.messageTextfield.isEnabled = true
                    self.sendButton.isEnabled = true
                    self.messageTextfield.text = ""
                }
            }
        }
        
    }
    
    func retrieveMessage() {
        let messageDB = Database.database().reference().child("Meesages")
        messageDB.observe(.childAdded) { (snapshot) in
            let snapshotValue = snapshot.value as! Dictionary<String, String>
            
            let text = snapshotValue["MeesageBody"]!
            let sender = snapshotValue["Sender"]!
            
            var messageS = Message()
            messageS.messageBody = text
            messageS.sender = sender
            self.messageArray.append(messageS)
            self.messageTableView.reloadData()
        }
    }
    
}
