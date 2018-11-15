//
//  NewAccountVC.swift
//  FiveGroups
//
//  Created by Bre Dionne on 11/14/17.
//  Copyright © 2017 Bre Dionne. All rights reserved.
//

import UIKit

class NewAccountVC: UIViewController {
    
    @IBOutlet weak var username:UITextField!
    @IBOutlet weak var password:UITextField!
    @IBOutlet weak var confirmPassword:UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        password.isSecureTextEntry = true
        confirmPassword.isSecureTextEntry = true
        
        //dismiss keyboard when user taps outside the text fields
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
    
    func userExists(_ username: String) -> Bool {
        var exists: Bool = false
        
        //check the users plist file to see if a user with the given username already exists
        if let path = Bundle.main.path(forResource: "users", ofType: "plist") {
            if let tempDict = NSDictionary(contentsOfFile: path) {
                let tempArray = (tempDict.value(forKey: "users") as! NSArray) as Array
                for dict in tempArray {
                    if username == dict["username"] as! String {
                        exists = true
                    }
                }
            }
        }
        
        return exists
    }
    
    func createUser(_ username:String, _ password:String) {
        
        //add a new user to the plst
        let url = Bundle.main.url(forResource: "users", withExtension: "plist")
        let documentDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
        let writableFileURL = documentDirectoryURL.appendingPathComponent("users.plist", isDirectory: false)
        
        //I think I made a mistake in this method, causing the app not to allow more than one user
        do {
            try FileManager.default.copyItem(at: url!, to: writableFileURL)
        } catch {
            print("Copying file failed with error : \(error)")
        }
        
        //add the new user so they may be recognized next time they login
        if let tempDict = NSMutableDictionary(contentsOf: url!) {
            var tempArray = (tempDict.value(forKey: "users") as! NSArray) as Array
            let user:Dictionary = ["username": username, "password": password]
            tempArray.append(user as AnyObject)
            tempDict.setObject(tempArray, forKey: "users" as NSCopying)
            tempDict.write(to: writableFileURL, atomically: true)
        }
    }
    
    @IBAction func createUser(sender: UIButton) {
        
        //check for empty text fields
        if username.text == "" || password.text == "" || confirmPassword.text == "" {
            let alertController = UIAlertController(title: "Incomplete Account Creation", message: "Please enter a username and password, and retype your password to confirm.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        } else if password.text != confirmPassword.text {
            //check if two passwords do not match
            let alertController = UIAlertController(title: "Passwords Do Not Match", message: "Your passwords do not match. Please re-enter your password and confirm again.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        } else if userExists(username.text!) == true {
            //check if the username already exists with another user
            let alertController = UIAlertController(title: "Username in Use", message: "A user already exists with this username. Please try a different username.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        } else {
            //otherwise, create the user!
            createUser(username.text!, password.text!)
            
            //previous user defaults are removed so the new account is fresh
            UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
            
            //log them into the app!!
            let tabBarVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC")
            dismissKeyboard()
            self.navigationController?.pushViewController(tabBarVC!, animated: true)
            
            //clear text fields for next time a new account needs to be created
            username.text = ""
            password.text = ""
            confirmPassword.text = ""
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
