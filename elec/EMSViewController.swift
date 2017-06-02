//
//  EMSViewController.swift
//  elec
//
//  Created by user on 24/2/17.
//  Copyright © 2017 user. All rights reserved.
//

import UIKit

import PopupDialog

import Toast_Swift

class EMSViewController: UIViewController {

    
    
    @IBOutlet weak var manualswitch: UISwitch!
    
    @IBOutlet weak var autoswitch: UISwitch!
    
    
    @IBOutlet weak var manimg: UIImageView!
    
    @IBOutlet weak var autoimg: UIImageView!
    
    @IBOutlet weak var sen_text: UILabel!
    
    
    @IBOutlet weak var btn_burger: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        manimg.image = manimg.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        manimg.tintColor = UIColor.gray
        
        autoimg.image = autoimg.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        autoimg.tintColor = UIColor.gray
        
        
        auto()
        
        // Swipe Left
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        // Button Burger
        btn_burger.target = self.revealViewController()
        btn_burger.action = #selector(SWRevealViewController.revealToggle(_:))
        
        // Nav Controller
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 29/255.0, green: 98/255.0, blue: 240/255.0, alpha: 1.0)

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // AUTO IS CLICKED
    
    @IBAction func one_clickbtn(_ sender: Any) {
        
        auto()
        
    }
    
    @IBAction func two_clickbtn(_ sender: Any) {
        
            manual()
       
         let ratingVC = RatingViewController(nibName: "RatingViewController", bundle: nil)
        
        
        let popup = PopupDialog(viewController: ratingVC, buttonAlignment: .horizontal, transitionStyle: .bounceDown, gestureDismissal: true)
        
        // Create first button
        let buttonOne = CancelButton(title: "CANCEL", height: 60) {
             self.auto()
        }
        
        // Create second button
        let buttonTwo = DefaultButton(title: "SAVE", height: 60) {
             self.sen_text.text = "Sensitivity Selected: 4"
            
            
            self.view.makeToast("Changes will take place in the next 30 Seconds")
        }
        
        // Add buttons to dialog
        popup.addButtons([buttonOne, buttonTwo])
        
        // Present dialog
        present(popup, animated: true, completion: nil)
    }
    
    
    
    func auto(){
        
        sen_text.isHidden = true
        manualswitch.setOn(false, animated: true)
        
        autoswitch.setOn(true, animated: true)
        
    }
    
    
    func manual(){
        
        sen_text.isHidden = false
        
        manualswitch.setOn(true, animated: true)
        
        autoswitch.setOn(false, animated: true)
        
    }

    
    
    /*
 
     // create the alert
     let alert = UIAlertController(title: "MANUAL SELECTION", message: "PLEASE Only Select Manual Option if you understand what you are doing! Click CANCEL to return to AUTOMATIC.", preferredStyle: UIAlertControllerStyle.alert)
     
     // add the actions (buttons)
     alert.addAction(UIAlertAction(title: "1", style: UIAlertActionStyle.default, handler: nil))
     alert.addAction(UIAlertAction(title: "2", style: UIAlertActionStyle.cancel, handler: nil))
     alert.addAction(UIAlertAction(title: "3", style: UIAlertActionStyle.destructive, handler: nil))
     
     // show the alert
     self.present(alert, animated: true, completion: nil)

 
    */
    
    
}
