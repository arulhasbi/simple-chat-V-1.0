//
//  RegisterViewController.swift
//  simple-chat
//
//  Created by Arul on 10/8/17.
//  Copyright © 2017 69 Rising. All rights reserved.
//

import UIKit

//TODO: Import Firebase Module
import Firebase
import SVProgressHUD

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    //TODO: Pre - Linked UI Element
    @IBOutlet weak var usernameTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO: Delegate RegisterViewController as UITextFieldDelegate
        usernameTextfield.delegate = self
        passwordTextfield.delegate = self
        
        //TODO: Create tapGestureRecognizer object
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(screenTap))
        
        //TODO: Add gesture to view.addgestureRecognizer
        self.view.addGestureRecognizer(tapGesture)
        // Do any additional setup after loading the view.
    }
    
    //TODO: Create function (event) for handling tapGesture (when user touch or tap the screen)
    @objc func screenTap() {
        usernameTextfield.endEditing(true)
        passwordTextfield.endEditing(true)
    }
    
    //TODO: create regsiterButtonPressed @IBAction function to createUser
    @IBAction func registerButtonPressed(_ sender: Any) {
        Auth.auth().createUser(withEmail: usernameTextfield.text!, password: passwordTextfield.text!) { (user, error) in
            if error != nil {
                print(error!)
                SVProgressHUD.showError(withStatus: "Registration Fail")
            } else {
                print("Registration Successfull !")
                self.performSegue(withIdentifier: "registerGoToChat", sender: self)
            }
        }
    }
    
    //MARK: - UITexfield Delegate Method

    //TODO: Create didEndEditing UITextfield function
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.view.layoutIfNeeded()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
