//
//  ViewController.swift
//  TipCalculator
//
//  Created by May Thazin on 8/13/17.
//  Copyright © 2017 May Thazin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var totalView: UIView!
    
    let blueColor = UIColor(red:0.36, green:0.61, blue:0.80, alpha:1.0)
    let greenColor = UIColor(red:0.31, green:0.63, blue:0.63, alpha:1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // make the number keypad visislble on display
        billField.becomeFirstResponder()
        
        // update views with default settings
        if defaults.bool(forKey: "isDefaultSet")
        {
            updateViewsWithDefaults(isChangedVal: false)
            calculateTip(self)
        }
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func onTap(_ sender: Any) {
        //view.endEditing(true)
    }
    
    
    @IBAction func calculateTip(_ sender: Any) {
        updateViewsWithDefaults(isChangedVal: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        updateViewsWithDefaults(isChangedVal: false)
        calculateTip(self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        let minute:TimeInterval = 600
        let date = Date(timeIntervalSinceNow: minute)
        defaults.set(date, forKey: "tenminInterval")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let settingController = segue.destination as! SettingsViewController
        settingController.tipControlSelectedIndex = tipControl.selectedSegmentIndex
        
    }
    
    /**
     *   Update data to sync between views
     */
    func updateViewsWithDefaults(isChangedVal:Bool){
        
        if isChangedVal {
            let tipPercentage = [0.15, 0.18, 0.20]
            let bill = Double(billField.text!) ?? 0
            let tip  = bill * tipPercentage[tipControl.selectedSegmentIndex]
            let total = bill + tip
            
            tipLabel.text = String(format:"$%.2f",tip)
            totalLabel.text = String(format:"$%.2f", total)
            
            defaults.set(billField.text, forKey: "bill")
            defaults.set(tipLabel.text, forKey: "tip")
            defaults.set(totalLabel.text, forKey: "total")
            defaults.set(tipControl.selectedSegmentIndex, forKey: "tipPercentageIndex")

        }else {
            let date:Date = defaults.object(forKey: "tenminInterval") as! Date
            let current_date = Date()
          
            if current_date < date {
            
               billField.text = defaults.string(forKey: "bill")
               tipLabel.text  = defaults.string(forKey: "tip")
               totalLabel.text = defaults.string(forKey: "total")
               tipControl.selectedSegmentIndex = defaults.integer(forKey: "tipPercentageIndex")
               changeViewTheme()
            }
        }
        
        if !defaults.bool(forKey: "isDefaultSet"){
            defaults.set(true, forKey: "isDefaultSet")
        }
        defaults.synchronize()
    }
    
    
    /**
     *  Change view background color
     */
    func changeViewTheme(){
        let colorIndex = defaults.integer(forKey: "themeColorIndex")
        
        if colorIndex == 1 {
            totalView.backgroundColor = greenColor
            tipControl.tintColor = greenColor
        }else {
            totalView.backgroundColor = blueColor
            tipControl.tintColor = blueColor
            
        }
        
    }
    
    
}

