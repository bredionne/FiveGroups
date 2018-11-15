//
//  SearchVC.swift
//  FiveGroups
//
//  Created by Bre Dionne on 11/14/17.
//  Copyright © 2017 Bre Dionne. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {
    
    @IBOutlet weak var search:UITextField!
    @IBOutlet weak var searchButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //dismiss keyboard when user taps outside text field
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func searchForFood(sender: UIButton) {
        
        //check for empty text field
        if (search.text == "") {
            let alertController = UIAlertController(title: "No Food Entered", message: "Please enter the name of a food you would like to searh for.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        } else {
            
            //search for the food in the USDA database
            let urlString = "https://api.nal.usda.gov/ndb/search/?format=json&q=\(search.text!)&ds=Standard%20Reference&max=10&api_key=y6Z3VipcSq0MYSn9iRl7n0dYPwugwtqmW5rID9Yc"
            
            //be sure to replace spaces with the escape so we actually hit the endpoint
            let noSpaceString = urlString.replacingOccurrences(of: " ", with: "%20")
            
            let endpoint = URL(string: noSpaceString)
            let data = try? Data(contentsOf: endpoint!)
            
            if let json: NSDictionary = (try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers)) as? NSDictionary {
                //get the list of foods
                if let list = json["list"] as? NSDictionary {
                    if let items = list.object(forKey: "item") {
                        //open a foods table with the ten most relevant search results
                        let foodsTableVC = FoodsTableVC()
                        //pass the items to the vc
                        foodsTableVC.items = items as! NSArray
                        search.text = ""
                        dismissKeyboard()
                        navigationController?.pushViewController(foodsTableVC, animated: true)
                    }
                } else {
                    //if there are no results, prompt user to modify search
                    let alertController = UIAlertController(title: "No Results Found", message: "No results for found for your search. Try a more generic food item.", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                    search.text = ""
                }
            } else {
                //if there are no results, prompt user to modify search
                let alertController = UIAlertController(title: "No Results Found", message: "No results for found for your search. Try a more generic food item.", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
                search.text = ""
            }
        }
    }
    
    @IBAction func addWater(sender: UIButton) {
        //add a serving of water to the log, using User Defaults
        if (UserDefaults.standard.object(forKey: "water") != nil) {
            let water = UserDefaults.standard.integer(forKey: "water")
            //8 being the an 8oz cup, which is considered a serving of water
            UserDefaults.standard.set(water + 8, forKey: "water")
        } else {
            UserDefaults.standard.set(8, forKey: "water")
        }
        
        //give user some feedback that the water was added
        let alertController = UIAlertController(title: "Water Added", message: "One serving of water has been added to your daily progress.", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
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
