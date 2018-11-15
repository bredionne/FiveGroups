//
//  ItemDetailVC.swift
//  FiveGroups
//
//  Created by Bre Dionne on 11/14/17.
//  Copyright © 2017 Bre Dionne. All rights reserved.
//

import UIKit

class ItemDetailVC: UIViewController {
    
    var food:NSDictionary = [:]
    var group: String = ""
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var foodGroup: UILabel!
    @IBOutlet weak var servings: UILabel!
    @IBOutlet weak var servingsCounter: UIStepper!
    @IBOutlet weak var calories: UILabel!
    @IBOutlet weak var fat: UILabel!
    @IBOutlet weak var satFat: UILabel!
    @IBOutlet weak var cholesterol: UILabel!
    @IBOutlet weak var sodium: UILabel!
    @IBOutlet weak var carbs: UILabel!
    @IBOutlet weak var fiber: UILabel!
    @IBOutlet weak var sugar: UILabel!
    @IBOutlet weak var protein: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //add the scroll view so the scrolling works
        view.addSubview(scrollView)
        
        //get all the food info to populate the screen
        foodName.text = (food.value(forKey: "name") as! String)
        let nutrients = food.value(forKey: "nutrients") as! NSArray

        for nutrient in nutrients {
            //we know the nutrient is calories because that's the only one whose unit is kcal
            if (nutrient as! NSDictionary).value(forKey: "unit") as! String == "kcal" {
                calories.text = "\(String(describing: Int(round((nutrient as! NSDictionary).value(forKey: "value")! as! Double))))"
            } else if (nutrient as! NSDictionary).value(forKey: "name") as! String == "Protein" {
                protein.text = "\(String(describing: Int(round((nutrient as! NSDictionary).value(forKey: "value")! as! Double))))g"
            } else if (nutrient as! NSDictionary).value(forKey: "name") as! String == "Total lipid (fat)" {
                fat.text = "\(String(describing: Int(round((nutrient as! NSDictionary).value(forKey: "value")! as! Double))))g"
            } else if (nutrient as! NSDictionary).value(forKey: "name") as! String == "Carbohydrate, by difference" {
                carbs.text = "\(String(describing: Int(round((nutrient as! NSDictionary).value(forKey: "value")! as! Double))))g"
            } else if (nutrient as! NSDictionary).value(forKey: "name") as! String == "Fiber, total dietary" {
                fiber.text = "Dietary Fiber \(String(describing: Int(round((nutrient as! NSDictionary).value(forKey: "value")! as! Double))))g"
            } else if (nutrient as! NSDictionary).value(forKey: "name") as! String == "Sugars, total" {
                sugar.text = "Sugars \(String(describing: Int(round((nutrient as! NSDictionary).value(forKey: "value")! as! Double))))g"
            } else if (nutrient as! NSDictionary).value(forKey: "name") as! String == "Fatty acids, total saturated" {
                satFat.text = "Saturated Fat \(String(describing: Int(round((nutrient as! NSDictionary).value(forKey: "value")! as! Double))))g"
            } else if (nutrient as! NSDictionary).value(forKey: "name") as! String == "Cholesterol" {
                cholesterol.text = "\(String(describing: Int(round((nutrient as! NSDictionary).value(forKey: "value")! as! Double))))mg"
            } else if (nutrient as! NSDictionary).value(forKey: "name") as! String == "Sodium, Na" {
                sodium.text = "\(String(describing: Int(round((nutrient as! NSDictionary).value(forKey: "value")! as! Double))))mg"
            } else if (nutrient as! NSDictionary).value(forKey: "name") as! String == "Sodium, Na" {
                sodium.text = "\(String(describing: Int(round((nutrient as! NSDictionary).value(forKey: "value")! as! Double))))mg"
            }
        }
        
        //get the food groups
        if "\(String(describing: food.value(forKey: "fg")!))" == "Fruits and Fruit Juices" {
            foodGroup.text = "This is a fruit"
            group = "fruits"
        } else if "\(String(describing: food.value(forKey: "fg")!))" == "Vegetables and Vegetable Products" {
            foodGroup.text = "This is a vegetable"
            group = "vegetables"
        } else if "\(String(describing: food.value(forKey: "fg")!))" == "Legumes and Legume Products" || "\(String(describing: food.value(forKey: "fg")!))" == "Poultry Products" || "\(String(describing: food.value(forKey: "fg")!))" == "Sausages and Luncheon Meats" || "\(String(describing: food.value(forKey: "fg")!))" == "Finfish and Shellfish Products" || "\(String(describing: food.value(forKey: "fg")!))" == "Nut and Seed Products" || "\(String(describing: food.value(forKey: "fg")!))" == "Beef Products" || "\(String(describing: food.value(forKey: "fg")!))" == "Pork Products" {
            //there were many groups defined by USDA that could fall in this category
            foodGroup.text = "This is a meat/nut/legume"
            group = "meat"
        } else if "\(String(describing: food.value(forKey: "fg")!))" == "Dairy and Egg Products" {
            foodGroup.text = "This is a dairy"
            group = "dairy"
        } else if "\(String(describing: food.value(forKey: "fg")!))" == "Fast Foods" || "\(String(describing: food.value(forKey: "fg")!))" == "Snacks" || "\(String(describing: food.value(forKey: "fg")!))" == "Sweets" {
            foodGroup.text = "This is a fats, sweets, and oils"
            group = "fats"
        } else if "\(String(describing: food.value(forKey: "fg")!))" == "Baked Products" || "\(String(describing: food.value(forKey: "fg")!))" == "Cereal Grains and Pasta" || "\(String(describing: food.value(forKey: "fg")!))" == "Breakfast Cereals" {
            foodGroup.text = "This is a bread/cereal/rice/pasta"
            group = "grains"
        } else {
            foodGroup.text = "This is a \(String(describing: food.value(forKey: "fg")!))"
        }
    }
    
    //use stepper to edit the amount of servings to add to the log
    @IBAction func changeServings(sender: UIStepper) {
        servings.text = "\(Int(servingsCounter.value))"
    }
    
    @IBAction func addToLog(sender: UIButton) {
        let serv = Int(servings.text!)
        
        //depending on the food group, add that value to what already exists for the group in UserDefaults
        if group == "fats" {
            if (UserDefaults.standard.object(forKey: "fats") != nil) {
                let fats = UserDefaults.standard.integer(forKey: "fats")
                UserDefaults.standard.set(fats + serv!, forKey: "fats")
            } else {
                UserDefaults.standard.set(serv, forKey: "fats")
            }
        } else if group == "dairy" {
            if (UserDefaults.standard.object(forKey: "dairy") != nil) {
                let dairy = UserDefaults.standard.integer(forKey: "dairy")
                UserDefaults.standard.set(dairy + serv!, forKey: "dairy")
            } else {
                UserDefaults.standard.set(serv, forKey: "dairy")
            }
        } else if group == "meat" {
            if (UserDefaults.standard.object(forKey: "meat") != nil) {
                let meat = UserDefaults.standard.integer(forKey: "meat")
                UserDefaults.standard.set(meat + serv!, forKey: "meat")
            } else {
                UserDefaults.standard.set(serv, forKey: "meat")
                print(UserDefaults.standard.integer(forKey: "meat"))
            }
        } else if group == "vegetables" {
            if (UserDefaults.standard.object(forKey: "vegetables") != nil) {
                let vegetables = UserDefaults.standard.integer(forKey: "vegetables")
                UserDefaults.standard.set(vegetables + serv!, forKey: "vegetables")
            } else {
                UserDefaults.standard.set(serv, forKey: "vegetables")
            }
        } else if group == "fruits" {
            if (UserDefaults.standard.object(forKey: "fruits") != nil) {
                let fruits = UserDefaults.standard.integer(forKey: "fruits")
                UserDefaults.standard.set(fruits + serv!, forKey: "fruits")
            } else {
                UserDefaults.standard.set(serv, forKey: "fruits")
            }
        } else if group == "grains" {
            if (UserDefaults.standard.object(forKey: "grains") != nil) {
                let grains = UserDefaults.standard.integer(forKey: "grains")
                UserDefaults.standard.set(grains + serv!, forKey: "grains")
            } else {
                UserDefaults.standard.set(serv, forKey: "grains")
            }
        } else {
            //some search results don't fall into any one category, so we ask the user to narrow or expand their search
            let alertController = UIAlertController(title: "Not Specific Enough", message: "This food may have too many food groups involved, or doesn't necessarily involve one specific food group. Try narrowing it down.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
        
        //send user back to the search screen once the food has been added to the log
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        navigationController?.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews(){
        super.viewWillLayoutSubviews()
        scrollView.contentSize = CGSize(width: 375, height: 736)
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
