//
//  ble_background.swift
//  elec
//
//  Created by user on 14/2/17.
//  Copyright © 2017 user. All rights reserved.
//

import Foundation
import UIKit
import CoreBluetooth

import Foundation

@objc protocol peripheralalertsanddata {
    
    // Methods 
    func device_status(status: Int)
    
    func device_is_found(status: Int)
    
    @objc optional func connection_is_established(status: Bool)
    
}



class DelegateBusText: NSObject, CBCentralManagerDelegate ,CBPeripheralDelegate {
    
    
    // CBUUID Instances of the CBUUID class represent the 128-bit universally unique identifiers (UUIDs) of attributes used in Bluetooth low energy communication
    
    // Service UUID
    //var serivce_uuid = CBUUID(string: "0000abcd-1212-efde-1523-785fef13d123")
    var serivce_uuid = CBUUID(string: "0000abcd-0000-1000-8000-00805f9b34fb")
    // Characteristic UUID
    //var charact_uuid = CBUUID(string: "0000ef23-1212-efde-1523-785fef13d123")
    var charact_uuid = CBUUID(string: "0000ef23-0000-1000-8000-00805f9b34fb")
    
    // Creating only one instance
    static let singleton_instance = DelegateBusText()
    
    
    var centralManager : CBCentralManager!
    var bleperipheral: CBPeripheral!
    
    var own_delegate : peripheralalertsanddata? = nil
    
    var valuestr = " "
    
    var timer : Timer?
    
    // Array of Float values to send into notification broadcast
    var finalvalues = [Float]()
    
    
   
    
    
    
    // Alloc Allocates memory
    // Init initializes the object
    override init()
    {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
        
    }
    
    deinit {
         print("object is getting destroyed")
    }
    
    
    
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        
        if(peripheral != bleperipheral)
        {
            return
        }
        
         let uuidForBTService: [CBUUID] = [charact_uuid]
        
        // For each service in peripheral serivce
        for service in peripheral.services!{
            
            // If the peripheral service == our Service
            // Then discoverCharacteristics for our Characteristic UUID
            if service.uuid == serivce_uuid{
                peripheral.discoverCharacteristics(uuidForBTService, for: service as CBService)
            }
            
        }
        
        
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        
        if(peripheral != bleperipheral)
        {
            return
        }
        
        for characteristic in service.characteristics! {
            
            if characteristic.uuid == charact_uuid {
                
                peripheral.readValue(for: characteristic)
            }
        }
        
        
    }
    
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        
        if (characteristic.uuid == charact_uuid)
        {
            
            // Data type
            
            let value = characteristic.value
            
            let datalength = value!.count / MemoryLayout<UInt8>.size
            
            var dataArray = [UInt8](repeating: 0, count: datalength)
            
            value!.copyBytes(to: &dataArray, count: datalength * MemoryLayout<Int8>.size)
            
           
            var floatpoint : Float = 0.0
            
            var i = 0;
            
            // New Array to store every byte received
            var newArray = [UInt8]()
            
            finalvalues.removeAll()
            
            
            for number in dataArray {
                
                i = i + 1;
                
                
              
                if(i%2 == 0)
                {
                    newArray.append(number)
                    
                    memcpy(&floatpoint, newArray, 2)
                    print("f=\(floatpoint)")
                    
                  
                    var datas = NSData(bytes: newArray, length: 2)
                    
                    var real : UInt32 = 0
                    
                    datas.getBytes(&real)
                    
                    
                    print("f=\(real)")
                    
                    
                    
                    
                    
                    //var finally = sfloatdouble(value: newArray)
                    
                     // print("f=\(finally)")
                    
                    
                    
                    
                    finalvalues.append(floatpoint)
                    i=0;
                    newArray = []
                    
                    
                }else{
                    
                    newArray.append(number)
                    
                    // print("\(newArray)" + "\n")
                }
                
                
                /*
                if(i%4 == 0)
                {   newArray.append(number)
                    
                    memcpy(&floatpoint, newArray, 4)
                    print("f=\(floatpoint)")
                    
                    finalvalues.append(floatpoint)
                    i=0;
                    newArray = []
                }
                else{
                    
                     newArray.append(number)
                    
                    // print("\(newArray)" + "\n")
                }
              */
            }
            
            // Make sure New Data Notify Gets called ! 
            // Debug here first
            self.centralManager.cancelPeripheralConnection(self.bleperipheral)
            
            
            let userinfodata : [String: Array<Float>] = ["floatarray" : finalvalues]
            
            NotificationCenter.default.post(name:  NSNotification.Name("newDataNotify"), object: nil, userInfo: userinfodata)
        }
        
        
    }

    
  
    
  
    
    
    func sfloatdouble(value: [Int8]) -> Double {
        
        // Declared as Uint 16
        let ieee11073 = UInt16(value[0] + value[1])
        
        // Declared as Uint16
        var mantissa : UInt16 = ieee11073 & 0x0FFF
        
        if(mantissa >= 0x0800)
        {
            //mantissa = UInt16(-1 * (0x1000 - mantissa))
        }

        if(mantissa == 0x07FF)
        {
            mantissa = UInt16(Double.nan)
        }
            
        else if (mantissa == 0x0800)
        {
             mantissa = UInt16(Double.nan)
        }
            
        else if (mantissa == 0x07FE)
        {
            mantissa = UInt16(Double.infinity)
        }
            
        else if (mantissa == 0x0802)
        {
            mantissa = UInt16(-1 * Double.infinity)
        }
            
        else if (mantissa == 0x0801)
        {
           mantissa = UInt16(Double.nan)
        }
        
        // Int 8
        var expo = Int8(ieee11073 >> 12)
        
        if(expo >= 0x08)
        {
            expo = -1 * (0x10 - expo)
        }

        var magnitude = pow(10.0, Double(expo))
        
        var output = Double(mantissa) * magnitude
        
        
        return output
    }
    
    
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        
       //  if(timer != nil)
        // {
         //   timer?.invalidate()
        //  }
        
          own_delegate?.device_is_found(status: 2)
          bleperipheral.discoverServices(nil)
        
    }
    
    
    //Invoked when an existing connection with a peripheral is torn down.
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        
        // This is for when device's connection has disconnected
        own_delegate?.device_is_found(status: 0)
        
        // Time interval is in Seconds
        if(timer == nil)
         {
            timer  = Timer.scheduledTimer(
            timeInterval: 30.0, target: self, selector: Selector(("connectionTask")),
            userInfo: nil, repeats: true)
         }
        
        
    }
    
    func connectionTask()
    {
        centralManager.connect(bleperipheral, options: nil)
        
    }
    
    
    //Using a preset function that is called if a state has being updated
    //And passed in the CBCentralManager Object
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        
        switch central.state {
            // Connection with State is lost
            
        // State unknown, update imminent.
        case .unknown:
            
            if (timer != nil)
            {
                timer?.invalidate()
                timer = nil
            }
            
            own_delegate?.device_status(status: 1)
             stop_scanning()
            
        // If it is unsupported
        case .unsupported:
            
            if (timer != nil)
            {
                timer?.invalidate()
                timer = nil
            }
            
            own_delegate?.device_status(status: 2)
            stop_scanning()
            
        // Connection was lost
        case .resetting:
            
            if (timer != nil)
            {
                timer?.invalidate()
                timer = nil
            }
            
            own_delegate?.device_status(status: 3)
            stop_scanning()
            
        // This application is not Authorisied to use BLE
        case .unauthorized:
            
            if (timer != nil)
            {
                timer?.invalidate()
                timer = nil
            }
            
           own_delegate?.device_status(status: 4)
            
            stop_scanning()
            
            
        case .poweredOff:
            
            if (timer != nil)
            {
                timer?.invalidate()
                timer = nil
            }
            
            own_delegate?.device_status(status: 4)
            stop_scanning()
            
        case .poweredOn:
            
            
            if (timer != nil)
            {
                timer?.invalidate()
                timer = nil
            }
            
            centralManager.scanForPeripherals(withServices: nil, options: [CBCentralManagerScanOptionAllowDuplicatesKey: false])
            
            own_delegate?.device_status(status: 5)
            
        
        }
        
    }

    


    
    /* Invoked when the central manager discovers a peripheral while scanning.
     */
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        if(peripheral.name != nil)
        {
            
            valuestr = peripheral.name!
            
            
            if((valuestr.range(of: "BL")) != nil || (valuestr.range(of: "LA")) != nil)
            {
                own_delegate?.device_is_found(status: 1)
                
                // Need to store your CBPeripheral instance somewhere that keeps a STRONG
                // reference to it.
                
                self.bleperipheral = peripheral
                bleperipheral.delegate = self
               
               
                centralManager.connect(bleperipheral, options: [CBConnectPeripheralOptionNotifyOnDisconnectionKey : true])
                
             
             
                 stop_scanning()
                
                
            
            }
            
        }
    }
    
    func stop_scanning(){
        centralManager.stopScan()
    }
    
    
    
    
}
