//
//  LoginVC.swift
//  FiveGroups
//
//  Created by Bre Dionne on 11/14/17.
//  Copyright © 2017 Bre Dionne. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet weak var username:UITextField!
    @IBOutlet weak var password:UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        password.isSecureTextEntry = true
        
        //dismiss keyboard if user does taps outside a text field
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Sign Out"
        navigationItem.backBarButtonItem = backItem
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func validateUser(_ username: String, _ password: String) -> Bool {
        var valid: Bool = false
        
        //check plist in document directory to see if the user and password combo matches what is in store
        let documentDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
        let usersUrl = documentDirectoryURL.appendingPathComponent("users.plist", isDirectory: false)
        if let tempDict = NSDictionary(contentsOf: usersUrl) {
            let tempArray = (tempDict.value(forKey: "users") as! NSArray) as Array
            for dict in tempArray {
                if username == dict["username"] as! String && password == dict["password"] as! String {
                    //if it is a match, the user is a valid user
                    valid = true
                }
            }
        }
        
        return valid
    }
    
    @IBAction func login(sender: UIButton) {
        
        //validate for empty text fields
        if username.text == "" || password.text == ""  {
            let alertController = UIAlertController(title: "Incomplete Login", message: "Please enter a username and password.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        } else {
            if validateUser(username.text!, password.text!) == true {
                //if user is a match, log them into the app!
                let tabBarVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC")
                dismissKeyboard()
                
                self.navigationController?.pushViewController(tabBarVC!
                    , animated: true)
                
                //reset text fields for when the user signs out
                username.text = ""
                password.text = ""
            } else {
                let alertController = UIAlertController(title: "Failed Login", message: "Please enter a valid username and password combination.", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
