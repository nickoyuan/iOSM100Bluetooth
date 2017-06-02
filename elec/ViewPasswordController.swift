//
//  ViewPasswordController.swift
//  elec
//
//  Created by user on 17/1/17.
//  Copyright © 2017 user. All rights reserved.
//
import CoreBluetooth
import UIKit

class ViewPasswordController: UIViewController {
    
    
    @IBOutlet weak var name_txt: UILabel!
    
    var blecentralmanager: CBCentralManager!
    var bleperipheral: CBPeripheral!

    
    override func viewDidLoad() {
        super.viewDidLoad()

         name_txt.text = bleperipheral.name
        
        
        
        
       // blecentralmanager.connect(bleperipheral, options: [CBConnectPeripheralOptionNotifyOnDisconnectionKey : true])
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
  //  func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
   //      peripheral.discoverCharacteristics(nil, for: peripheral.services![0])
        
   // }
    


}
