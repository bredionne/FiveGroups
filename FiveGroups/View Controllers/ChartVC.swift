//
//  ChartVC.swift
//  FiveGroups
//
//  Created by Bre Dionne on 11/14/17.
//  Copyright © 2017 Bre Dionne. All rights reserved.
//

import UIKit

class ChartVC: UIViewController {
    
    @IBOutlet weak var fats: UILabel!
    @IBOutlet weak var dairy: UILabel!
    @IBOutlet weak var meats: UILabel!
    @IBOutlet weak var vegetables: UILabel!
    @IBOutlet weak var fruits: UILabel!
    @IBOutlet weak var grains: UILabel!
    @IBOutlet weak var water: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        //Show all user values for food group and water progress
        
        //check if the user default exists
        if UserDefaults.standard.object(forKey: "fats") != nil {
            //show value
            fats.text = "\(UserDefaults.standard.integer(forKey: "fats"))"
            if (UserDefaults.standard.integer(forKey: "fats") > 3) {
                fats.textColor = UIColor.red
            } else {
                fats.textColor = UIColor.green
            }
        } else {
            //if it doesn't exist, set quantity as 0
            fats.text = "0"
            fats.textColor = UIColor.green
        }
        
        if UserDefaults.standard.object(forKey: "dairy") != nil {
        dairy.text = "\(UserDefaults.standard.integer(forKey: "dairy"))/3"
            if (UserDefaults.standard.integer(forKey: "dairy") < 3) {
                //value is red if the user has not yet achieved recommended servings of a given group
                dairy.textColor = UIColor.red
            } else {
                //value is green once the user has achieved recommended servings of a given group
                dairy.textColor = UIColor.green
            }
        } else {
            dairy.text = "0/3"
            dairy.textColor = UIColor.red
        }
        
        if UserDefaults.standard.object(forKey: "meat") != nil {
            meats.text = "\(UserDefaults.standard.integer(forKey: "meat"))/3"
            if (UserDefaults.standard.integer(forKey: "meat") < 3) {
                meats.textColor = UIColor.red
            } else {
                meats.textColor = UIColor.green
            }
        } else {
            meats.text = "0/3"
            meats.textColor = UIColor.red
        }
        
        if UserDefaults.standard.object(forKey: "vegetables") != nil {
            vegetables.text = "\(UserDefaults.standard.integer(forKey: "vegetables"))/5"
            if (UserDefaults.standard.integer(forKey: "vegetables") < 5) {
                vegetables.textColor = UIColor.red
            } else {
                vegetables.textColor = UIColor.green
            }
        } else {
            vegetables.text = "0/5"
            vegetables.textColor = UIColor.red
        }
        
        if UserDefaults.standard.object(forKey: "fruits") != nil {
            fruits.text = "\(UserDefaults.standard.integer(forKey: "fruits"))/4"
            if (UserDefaults.standard.integer(forKey: "fruits") < 4) {
                fruits.textColor = UIColor.red
            } else {
                fruits.textColor = UIColor.green
            }
        } else {
            fruits.text = "0/4"
            fruits.textColor = UIColor.red
        }
        
        if UserDefaults.standard.object(forKey: "fruits") != nil {
            grains.text = "\(UserDefaults.standard.integer(forKey: "grains"))/11"
            if (UserDefaults.standard.integer(forKey: "grains") < 11) {
                grains.textColor = UIColor.red
            } else {
                grains.textColor = UIColor.green
            }
        } else {
            grains.text = "0/11"
            grains.textColor = UIColor.red
        }
        
        if UserDefaults.standard.object(forKey: "water") != nil {
            water.text = "\(UserDefaults.standard.integer(forKey: "water"))/64 oz"
            //based on recommended 8 cups of water per day
            if (UserDefaults.standard.integer(forKey: "water") < 64) {
                water.textColor = UIColor.red
            } else {
                water.textColor = UIColor.green
            }
        } else {
            water.text = "0/64 oz"
            water.textColor = UIColor.red
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
