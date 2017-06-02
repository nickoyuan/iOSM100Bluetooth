//
//  AlertsettingViewController.swift
//  elec
//
//  Created by user on 28/2/17.
//  Copyright © 2017 user. All rights reserved.
//

import UIKit



class AlertsettingViewController: UIViewController {

    
    
    @IBOutlet weak var sen_test: UISegmentedControl!
    
    @IBOutlet weak var manualswitch: UISwitch!
    
    @IBOutlet weak var autoswitch: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

          auto()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func autotouch(_ sender: Any) {
        
        auto()
    }
    
    
    @IBAction func manualtouch(_ sender: Any) {
      
        manual()
    }
    
    
    func auto(){
       
        sen_test.isHidden = true
        manualswitch.setOn(false, animated: true)
        
        autoswitch.setOn(true, animated: true)
     
    }
    
    func manual(){
        
        sen_test.isHidden = false
        
        manualswitch.setOn(true, animated: true)
        
        autoswitch.setOn(false, animated: true)
        
    }
    
    
    
    

}
