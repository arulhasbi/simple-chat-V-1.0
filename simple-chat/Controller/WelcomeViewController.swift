//
//  WelcomeViewController.swift
//  simple-chat
//
//  Created by Arul on 10/8/17.
//  Copyright © 2017 69 Rising. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // loginButton.buttonType
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //TODO: Make loginPressed and registerPressed Function
    @IBAction func loginPressed(_ sender: Any) {
        
        performSegue(withIdentifier: "goToLogin", sender: self)
        
    }
    
    @IBAction func registerPressed(_ sender: Any) {
        
        performSegue(withIdentifier: "goToRegister", sender: self)
        
    }

}
