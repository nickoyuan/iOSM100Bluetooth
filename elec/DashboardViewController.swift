//
//  DashboardViewController.swift
//  elec
//
//  Created by user on 30/1/17.
//  Copyright © 2017 user. All rights reserved.
//

import UIKit

// Import the Gauge
import GaugeView

import CoreData

import Foundation

import CoreBluetooth

// So CBCentralManagerDelegate is a Protocol, within the Protocol are a set of functions and rules
// blecentralmanager: CBCentralManager! is a Delegate that is created so we can use the protocols 
// Then we set blecentralmanager.delegate = self to make sure we are using the Current View 
// Controller's Protocol


class DashboardViewController: UIViewController, peripheralalertsanddata{

   
     let ble_back = DelegateBusText.singleton_instance
    
     // Container View
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var connect_image: UIImageView!
    
       // Segmented Controller
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    lazy var summaryViewController : SummaryViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        // Creates an instance of the Summary View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "SummaryViewController") as! SummaryViewController
        
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        // Adding this as a Child View Controller ("Summary") to the parent View Controller
        self.addChildViewController(viewController)
        
        self.addSubView(subView: viewController.view, toView: self.containerView)
        
        
        return viewController
    }()
    
    
    
    
    lazy var GraphViewController : GraphViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        // Creates an instance of the Summary View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "GraphViewController") as! GraphViewController
        
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        // Adding this as a Child View Controller ("Summary") to the parent View Controller
        self.addChildViewController(viewController)
        
        self.addSubView(subView: viewController.view, toView: self.containerView)
        
        
        return viewController
    }()
    

    @IBOutlet weak var btnbuttonopen: UIBarButtonItem!
   
    @IBOutlet weak var maingaugeview: GaugeView!
 
    @IBOutlet weak var battgauge: GaugeView!
    
    
    @IBOutlet weak var signalgauge: GaugeView!
    
    
    
    
    // if found == true
    var found = false
    
    var valuestr = " "
    
    var service_send = ""
    
    var swt = [CBUUID]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ble_back.own_delegate = self
        
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 103/255.0, green: 191/255.0, blue: 249/255.0, alpha: 1.0)
        
        // Setup for disconnecting Icon
        connect_image.image = connect_image.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        connect_image.tintColor = UIColor.red
        
        
        // Save this Service UUID into our Core Data !
       
     
        // gaugeView.gaugeColor = UIColor.blue
        // gaugeView.gaugeBackgroundColor = UIColor.red
        
        btnbuttonopen.target = self.revealViewController()
        btnbuttonopen.action = #selector(SWRevealViewController.revealToggle(_:))
        
        // Swipe Left 
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        setupSegment()
        
        maingaugeview.percentage = 80
        
        // Thickness of the Gauge Bar
        maingaugeview.thickness = 20
        maingaugeview.labelFont = UIFont.systemFont(ofSize: 40, weight: UIFontWeightThin)
        maingaugeview.labelColor = UIColor.black
        maingaugeview.gaugeColor = UIColor.init(red: 103/255.0, green: 191/255.0, blue: 249/255.0, alpha: 1.0)
        maingaugeview.gaugeBackgroundColor = UIColor.white
        maingaugeview.labelText = "80%"
        
        maingaugeview.accessibilityLabel = "Gauge"
        
        
        // Battery Gauge
        battgauge.percentage = 30
        battgauge.labelText  = "30%"
        battgauge.labelColor = UIColor.black
        battgauge.thickness = 10
        
        signalgauge.percentage = 50
        signalgauge.labelText  = "80%"
        signalgauge.labelColor = UIColor.black
        signalgauge.thickness = 10
        signalgauge.gaugeColor = UIColor.init(red: 245/255.0, green: 152/255.0, blue: 11/255.0, alpha: 1.0)
        
        
    }
    
    
    func setupSegment(){
        segmentedControl.removeAllSegments()
        segmentedControl.insertSegment(withTitle: "Graph", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "Summary", at: 1, animated: false)
        
        // Starting the GraphViewController Setup so Lazy gets Called
        GraphViewController.view.isHidden = false
        
    }
    
    @IBAction func toggle(_ sender: UISegmentedControl){
        
        if(sender.selectedSegmentIndex == 0)
        {
            // Summary View is Hidden
            summaryViewController.view.isHidden = true
            
            // Graph View is SHOWN
            GraphViewController.view.isHidden = false
            
            
            
        }
        
        if(sender.selectedSegmentIndex == 1)
        {
            // Summary View Controller is Shown
            summaryViewController.view.isHidden = false
            
            // Graph View is Hidden
            GraphViewController.view.isHidden = true
            
          }
        
    }
    
    func device_status(status: Int)
    {
        
        if(status == 1 || status == 3)
        {
            let alert = UIAlertController(title: "Bluetooth not on", message: "Please turn on Phone and M100 Bluetooth.", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
            
        else if(status == 2)
        {
            
            let alert = UIAlertController(title: "Bluetooth not on", message: "Please turn on Phone and M100 Bluetooth.", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
            
        else if(status == 4)
        {     let alert = UIAlertController(title: "Bluetooth not on", message: "Please turn on Phone and M100 Bluetooth.", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
            
        
    }
    
    func device_is_found(status: Int)
    {
        // Problem with calling this in the beginning??? 
        if(status == 2)
        {
            connect_image.image = connect_image.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
            connect_image.tintColor = UIColor.green
        }
            
        // If disconnected
        else if(status == 0)
        {
            connect_image.image = connect_image.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
            connect_image.tintColor = UIColor.red
        }
        
        
        
    }
    
    
   
    
       
        
    func addSubView(subView: UIView, toView parentView: UIView)
    {
        parentView.addSubview(subView)
        
        var viewBindingsDict = [String: AnyObject]()
        
        
        viewBindingsDict["subView"] = subView
        parentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[subView]|", options: [], metrics: nil, views: viewBindingsDict))
        
        parentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[subView]|", options: [], metrics: nil, views: viewBindingsDict))
        
        
    }
    
    

}
