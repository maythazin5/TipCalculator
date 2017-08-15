//
//  SettingsViewController.swift
//  TipCalculator
//
//  Created by May Thazin on 8/13/17.
//  Copyright © 2017 May Thazin. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var themeControl: UISegmentedControl!
    
    var tipControlSelectedIndex: Int = 0
    let defaults = UserDefaults.standard
    
    let blueColor = UIColor(red:0.36, green:0.61, blue:0.80, alpha:1.0)
    let greenColor = UIColor(red:0.31, green:0.63, blue:0.63, alpha:1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViewsWithDefaults(isChangedVal: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func updateSettings(_ sender: Any) {
        updateViewsWithDefaults(isChangedVal: true)
        
    }
    
    /**
     *   Update data to sync between views
     */
    func updateViewsWithDefaults(isChangedVal:Bool){
        
        if isChangedVal {
            defaults.set(tipControl.selectedSegmentIndex, forKey: "tipPercentageIndex")
            defaults.set(themeControl.selectedSegmentIndex, forKey: "themeColorIndex")
        }else{
            tipControl.selectedSegmentIndex = defaults.integer(forKey: "tipPercentageIndex")
            themeControl.selectedSegmentIndex = defaults.integer(forKey: "themeColorIndex")
        }
        changeViewTheme()

    }
    
    /**
     *  Change view background color
     */
    func changeViewTheme(){
        let colorIndex = defaults.integer(forKey: "themeColorIndex")
        
        if colorIndex == 1 {
            themeControl.tintColor = greenColor
            tipControl.tintColor = greenColor
        }else {
            themeControl.tintColor = blueColor
            tipControl.tintColor = blueColor
            
        }
        
    }
    
 

}
