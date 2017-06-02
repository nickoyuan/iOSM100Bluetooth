//
//  MenuslideController.swift
//  elec
//
//  Created by user on 1/2/17.
//  Copyright © 2017 user. All rights reserved.
//

import UIKit

class MenuslideController: UIViewController, UITabBarDelegate, UITableViewDataSource{

    var menuNameArr:Array = [String]()
    
    @IBOutlet weak var viewbackground: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        menuNameArr = ["Dashboard","EMS"]
        
      
        let gradientlayer = CAGradientLayer()
        gradientlayer.frame = CGRect(x: 0, y: 0, width: viewbackground.frame.size.width, height: viewbackground.frame.size.height)
        
        
        gradientlayer.colors = [UIColor(red: 36/255.5, green: 200/255.5, blue: 254/255.5, alpha: 1.0).cgColor,
                                UIColor(red: 102/255.5, green: 250/255.5, blue: 238/255.5, alpha: 1.0).cgColor]
        
        gradientlayer.locations = [0.3,0.8,1.0]
        
        gradientlayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        
        gradientlayer.endPoint = CGPoint(x: 1.0, y: 0.0)
        
        viewbackground.layer.insertSublayer(gradientlayer, at: 0)
        
    
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuNameArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: menuNameArr[indexPath.row], for: indexPath) as UITableViewCell
        
        
        //cell.textLabel?.text = menuNameArr[indexPath.row]
        
        return cell
    }
    
 
    

}
