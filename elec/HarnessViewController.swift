//
//  HarnessViewController.swift
//  elec
//
//  Created by user on 28/2/17.
//  Copyright © 2017 user. All rights reserved.
//

import UIKit

class HarnessViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource{

    
    var txttitle = ["POWER OFF THE M100 DEVICE", "FOLLOW 2.1 INSTRUCTION MANUAL OF M100", "POWER ON THE M100 DEVICE", "GOLD Banana PLUGS", "READ MAIN WINDOW OF DISPLAY"]
    
    var txtdep = [" ",
                  // Two
        "READ CONNECTION OF SIS ELECTRODE TO HARNESS TO M100. WARNING: Do not connect electrodes to the harness.",
        //Third
        " ",
        // fourth
        "Hold the two gold 'banana plugs' at the ends of the black and red wires of the electrode harness in contact with one another for a maximum of 55 seconds. Make sure the contact between the 'banana plugs' is continuous,do not touch the banana plugs with your fingers or any object.",
        // Five
        "IF R= RC, is shown in the Main Window of the display, then Harness is OK. \n " +
        "IF R= OL, is shown in the Main Window of the display, then Harness is Broken."
    ]
    
    var images = [UIImage(named: "list_number"), UIImage(named: "list_number_two"), UIImage(named: "list_number_three"),UIImage(named: "list_number_four"),
                  UIImage(named: "list_number_five")]
    
    
    @IBOutlet weak var tableview: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
        self.tableview.register(UINib(nibName: "HarnessTableViewCell", bundle: nil), forCellReuseIdentifier: "harnesscell")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let count = txttitle.count
        
        return count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
      let cell = self.tableview.dequeueReusableCell(withIdentifier: "harnesscell", for: indexPath) as! HarnessTableViewCell
        
        
        cell.imgnum.image = images[indexPath.row]
        cell.txtdesc.text = txtdep[indexPath.row]
        cell.txttitle.text = txttitle[indexPath.row]
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
       // .image = images[indexPath.row]
       // cell.txtheader.text = txttitle[indexPath.row]
        //cell.txtdep.text = txtdep[indexPath.row]
        
        return cell
    }


}
