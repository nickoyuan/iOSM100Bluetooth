//
//  ViewController.swift
//  elec
//
//  Created by user on 14/1/17.
//  Copyright © 2017 user. All rights reserved.
//
import CoreBluetooth
import UIKit

// Objective C 
import Foundation

import CoreData

class ViewController: UIViewController, peripheralalertsanddata{
   
    
    
    let ble_back = DelegateBusText.singleton_instance
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!

   
    @IBOutlet weak var statustxt: UILabel!
    
    
    var seeking = false
    
    var valuestr = " "
    
    var found = false
    
    
    
    //var searchResults : [Bledata] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        ble_back.own_delegate = self
   
        
    }
    
    
    func device_is_found(status: Int) {
        
        if(status == 1)
        {
            let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
             self.present(alert, animated: false, completion: nil)
            
        }
       else if (status == 2)
        {
             ble_back.own_delegate = nil
            
            self.dismiss(animated: true, completion: nil)
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyboard.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
            self.present(newViewController, animated: true, completion: nil)

        }
        
    }
    
    func device_status(status: Int){
        
        //print(status)
        
        if(status == 5)
        {
            self.spinner.startAnimating()
            statustxt.text = "Scanning..."
        }
        
        else if(status == 1 || status == 3)
        {
            spinner.stopAnimating()
            statustxt.text = "Oops, something went wrong, please restart!"
        }
            
        else if(status == 2)
        {
            spinner.stopAnimating()
            let alert = UIAlertController(title: "Bluetooth Error", message: "Old Android version, this device does not support newest Bluetooth.", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            statustxt.text = "Please update your Android Device and retry"
        }
        
        else if(status == 4)
        {     spinner.stopAnimating()
              statustxt.text = "Please restart your Phone Bluetooth"
        }
            
            
        else{
            spinner.stopAnimating()
            statustxt.text = "Please turn on Phone Bluetooth"
        }
        
        
    }

    // MARK: - Before it disappears
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
     
        
    }
    
    
    
    
    override func viewDidDisappear(_ animated: Bool) {
      
    }
    

}

