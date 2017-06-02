//
//  AlertViewController.swift
//  elec
//
//  Created by user on 22/2/17.
//  Copyright © 2017 user. All rights reserved.
//

import UIKit

import GaugeView

import PopupDialog

import Toast_Swift

class AlertViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{

    
    var txttitle = ["CHECK DRESSING TAPE", "CHECK ELECTRODES ARE WET", "CHECK IF ELECTRODES ARE DISCOLORED", "SHAVED SKIN IF NECESSARY", "REPLACE SIS ELECTRODES",
                 "CHECK HARNESS CONNECTIONS", "CHECK FOR SKIN IRRITATION",
                 "CHECK MONITORING SETTING", "PERFORM HARNESS CHECK"]
    
    var txtdep = ["Check that the dressing tape is holding the entire surface of the       electrodes in contact with skin or wound." +
                  "Replace or add dressing tape if necessary.",
                 // Two
                  "Re-moisten electrodes with distilled or tap water if necessary.",
                  //Third
                  "Replace the electrodes if they are discolored (12-72 hours).",
                  // fourth 
                  "Check if hair growth is lifting electrodes from skin. Re-shave skin if necessary.",
                  // Five 
                  "If all other checks have been performed and OK, there is a possible electrode fault. Replace both SIS electrodes.",
                  // SIX 
                  "Check harness (connecting wire) has not unplugged. Check harness is connected to the two electrodes and to the SIS machine.",
                  // Seven 
                  "INFORMATION ONLY. Simulation voltage has increased: Check under electrodes and dressing tape for skin irritation.",
                  //Eight
                  "if monitoring set to MANUAL then reduce MONITORING setting. Or set to AUTO [CLICK HERE TO CHANGE SETTING]",
                  // NINE 
                  "Follow instructions to perform a harness check. Notify manufacturer or supplier if harness is broken. Replace harness if necessary. [CLICK HERE TO CHANGE SETTING]"
                  ]
    
    var images = [UIImage(named: "list_number"), UIImage(named: "list_number_two"), UIImage(named: "list_number_three"),UIImage(named: "list_number_four"),
                  UIImage(named: "list_number_five"), UIImage(named: "list_number_six"),
                  UIImage(named: "list_number_seven"),UIImage(named: "list_number_eight"), UIImage(named: "list_number_nine")]
    
    @IBOutlet weak var gauge: GaugeView!

    @IBOutlet weak var tableViewoutlet: UITableView!
    
    @IBOutlet weak var status_image: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        gauge.percentage = 60
        // Thickness of the Gauge Bar
        gauge.thickness = 20
        gauge.labelFont = UIFont.systemFont(ofSize: 40, weight: UIFontWeightThin)
        gauge.labelColor = UIColor.black
        gauge.gaugeColor = UIColor.init(red: 245/255.0, green: 152/255.0, blue: 11/255.0, alpha: 1.0)
        gauge.gaugeBackgroundColor = UIColor.white
        gauge.labelText = "60%"
        gauge.accessibilityLabel = "Gauge"
    
    
    
        // Setup for disconnecting Icon
        status_image.image = status_image.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        status_image.tintColor = UIColor.red
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: Table View Delegate Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let count = txttitle.count
        
        return count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 158
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       let cell = self.tableViewoutlet.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AlertCustomCell
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        cell.numberimage.image = images[indexPath.row]
        cell.txtheader.text = txttitle[indexPath.row]
        cell.txtdep.text = txtdep[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let txt = txttitle[indexPath.row]
        
        if(txt.range(of: "MONITORING") != nil)
        {
            dialogpopup()
            
        }
        
        else if (txt.range(of: "HARNESS") != nil)
        {
            
            harnessinfo()
        }
        
        
    }
    
    
    func harnessinfo(){
        let ratingVC = HarnessViewController(nibName: "HarnessViewController", bundle: nil)
        
        
        let popup = PopupDialog(viewController: ratingVC, buttonAlignment: .horizontal, transitionStyle: .bounceDown, gestureDismissal: true)
        
        // Create first button
        let buttonOne = CancelButton(title: "OK I UNDERSTAND", height: 60) {
            
        }
        
        
        // Add buttons to dialog
        popup.addButtons([buttonOne])
        
        // Present dialog
        present(popup, animated: true, completion: nil)
    }

    func dialogpopup(){
        let ratingVC = AlertsettingViewController(nibName: "AlertsettingViewController", bundle: nil)
        
        
        let popup = PopupDialog(viewController: ratingVC, buttonAlignment: .horizontal, transitionStyle: .bounceDown, gestureDismissal: true)
        
        // Create first button
        let buttonOne = CancelButton(title: "CANCEL", height: 60) {
            
        }
        
        // Create second button
        let buttonTwo = DefaultButton(title: "SAVE", height: 60) {
            
            self.view.makeToast("Changes will take place in the next 30 Seconds")
            
        }
        
        // Add buttons to dialog
        popup.addButtons([buttonOne, buttonTwo])
        
        // Present dialog
        present(popup, animated: true, completion: nil)
    }

    
    
}
