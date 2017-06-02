//
//  GraphViewController.swift
//  elec
//
//  Created by user on 31/1/17.
//  Copyright © 2017 user. All rights reserved.
//

import UIKit

// Import the Charts
import Charts




class GraphViewController: UIViewController, ChartViewDelegate{

    @IBOutlet weak var linechartview: LineChartView!
    
    
    
    var yVals1 : [ChartDataEntry] = [ChartDataEntry]()
    
    // Float array from global
    var newfloatarray = [Float]()
    
    // counter 
    var counter = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        newfloatarray.append(0.0)

        //We set the ChartViewDelegate to our ViewController.
        self.linechartview.delegate = self
        
        //We change the descriptionText that will appear at the bottom of our chart.
        self.linechartview.descriptionText = "Tap node for Details"
        
        
        //Here, we set our description text color to white and our grid background color to dark grey.
        self.linechartview.descriptionTextColor = UIColor.white
        
        gradent()
        
        
        
        //We make sure our user get feedback if there is not data provided.
        
        self.linechartview.noDataText = "No data provided"
        
        //Finally, we call / create a custom function that will add data to our chart.
        setChartData()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
          NotificationCenter.default.addObserver(self, selector: #selector(self.newChartData(_:)), name:  NSNotification.Name("newDataNotify"), object: nil)
        
    }
    
    // If View has disappeared then remove notification listener
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("newDataNotify"), object: nil)
    }
    
    
    func newChartData(_ notification: Notification)
    {
        newfloatarray.removeAll()
        newfloatarray = notification.userInfo?["floatarray"] as! Array<Float>
       
        
        for element in newfloatarray{
            print(element)
        }
       
       setChartData()
    }
    
   
    
    func setChartData(){
        
        // 1 - creating an array of data entries
        
        for i in 0..<newfloatarray.count{
            
            yVals1.append(ChartDataEntry(x: counter, y: Double(newfloatarray[i])))
          
            counter = counter + 1.0
        }
        
        // 2 - create a data set with our array
        let set1: LineChartDataSet = LineChartDataSet(values: yVals1, label: "First Set")
        set1.axisDependency = .left // Line will correlate with left axis values
        
        //set1.setColor(UIColor.red.withAlphaComponent(0.5)) // our line's opacity is 50%
        //set1.setCircleColor(UIColor.red) // our circle will be dark red
        
        set1.lineWidth = 2.0
        //set1.circleRadius = 6.0 // the radius of the node circle
        set1.fillAlpha = 255
        set1.fillColor = UIColor.init(red: 103.0/255.5, green: 191/255.5, blue: 249/255.5, alpha: 1.0)
        set1.highlightColor = UIColor.white
        
        // Disable hole drawing
        set1.drawCircleHoleEnabled = false
        
        // Disable the Circles
        set1.drawCirclesEnabled = false
        
        // Filling of the Graph Color
        set1.drawFilledEnabled = true
        
        // Cubic Graph
        set1.mode = LineChartDataSet.Mode.cubicBezier
        
        // This is animation (In seconds)
        linechartview.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        
        // Adding limits
        //let ll = ChartLimitLine(limit: 5.0, label: "Threshold")
        //linechartview.rightAxis.addLimitLine(ll)
        
        
        // Disable Grid Lines for the right YAxis
        let yaxis = linechartview.getAxis(YAxis.AxisDependency.right)
        yaxis.drawLabelsEnabled = false
        
        // Disable Grid Lines
        yaxis.drawGridLinesEnabled = false
      
        
        
        // Disable Grid lines for the left YAxis
        let xaxis = linechartview.getAxis(YAxis.AxisDependency.left)
        //xaxis.drawLabelsEnabled = false
        
        // Disable Grid Lines
        xaxis.drawGridLinesEnabled = false
        linechartview.xAxis.drawGridLinesEnabled = false
        
        // Move XAxis label Position to bottom of graph
        self.linechartview.xAxis.labelPosition = XAxis.LabelPosition.bottom
        
        // Delete the Legend
        self.linechartview.legend.enabled = false
        
        // double Tap to zoom false
        self.linechartview.doubleTapToZoomEnabled = false
        
       
        
        
        
        
        //3 - create an array to store our LineChartDataSets
        var dataSets : [LineChartDataSet] = [LineChartDataSet]()
        dataSets.append(set1)
        
        //4 - pass our months in for our x-axis label value along with our dataSets
        let data: LineChartData = LineChartData(dataSets: dataSets)
        data.setValueTextColor(UIColor.white)
        
        //5 - finally set our data
        self.linechartview.data = data
        
        data.notifyDataChanged()
        linechartview.notifyDataSetChanged()
        
        linechartview.fitScreen()
        //linechartview.resetViewPortOffsets()
        //self.linechartview.invalidateIntrinsicContentSize()
        
      
    }
    
    func gradent(){
        
        let gradientlayer = CAGradientLayer()
        gradientlayer.frame = self.view.frame
        
        
        gradientlayer.colors = [UIColor(red: 36/255.5, green: 200/255.5, blue: 254/255.5, alpha: 1.0).cgColor,
                                UIColor(red: 102/255.5, green: 250/255.5, blue: 238/255.5, alpha: 1.0).cgColor]
        
        gradientlayer.locations = [0.3,0.8,1.0]
        
        gradientlayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        
        gradientlayer.endPoint = CGPoint(x: 1.0, y: 0.0)
        
        //self.view.layer.insertSublayer(gradientlayer, at: 0)
        //linechartview.gridBackgroundColor = UIColor.
    
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    

}
