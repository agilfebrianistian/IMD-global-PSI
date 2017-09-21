//
//  PSIDetailsVC.swift
//  IMDTest
//
//  Created by Agil Febrianistian on 9/17/17.
//  Copyright © 2017 Agil Febrianistian. All rights reserved.
//

import UIKit
import Charts
import SwiftyJSON

class PSIDetailsVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var chartContainer: LineChartView!
    
    var regionName : String!
    var items : [Items]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let startDateString = items.first?.timestamp.toDate().toString()
        let endDateString = items.last?.timestamp.toDate().toString()
        
        dateLabel.text = "Range from "+startDateString!+" until "+endDateString!
        tableView.register(UINib(nibName: "HeaderCell", bundle: nil), forCellReuseIdentifier: "HeaderCell")
        setUpChart()
        
        self.tableView.tableHeaderView = self.chartContainer
    }
    
    func readings() -> [[String:Double]]{
        
        var readings =  [[String : Double]]()
        for i in 0..<items.count {
            var reading = [String:Double]()
            for j in items[i].readings {
                var e = j.1.filter({$0.0 == regionName})
                reading[j.0] = e[0].1.doubleValue
            }
            readings.append(reading)
        }
        return readings
    }
    
    func setUpChart(){
        
        var pm10SubIndexValues  = [ChartDataEntry]()
        var pm25SubIndexValues  = [ChartDataEntry]()
        var so2SubIndexValues  = [ChartDataEntry]()
        var coSubIndexValues  = [ChartDataEntry]()
        var o3SubIndexValues  = [ChartDataEntry]()
        
        for i in 0..<readings().count {
            pm10SubIndexValues.append(ChartDataEntry(x: Double(i), y: readings()[i][PM10_SUB_INDEX]!))
            pm25SubIndexValues.append(ChartDataEntry(x: Double(i), y: readings()[i][PM25_SUB_INDEX]!))
            so2SubIndexValues.append(ChartDataEntry(x: Double(i), y: readings()[i][SO2_SUB_INDEX]!))
            coSubIndexValues.append(ChartDataEntry(x: Double(i), y: readings()[i][CO_SUB_INDEX]!))
            o3SubIndexValues.append(ChartDataEntry(x: Double(i), y: readings()[i][O3_SUB_INDEX]!))
        }
        
        let line1 = LineChartDataSet(values: pm10SubIndexValues, label: PM10_SUB_INDEX)
        line1.colors = [NSUIColor.red]
        line1.circleHoleColor = NSUIColor.red
        line1.circleColors = [NSUIColor.clear]
        
        let line2 = LineChartDataSet(values: pm25SubIndexValues, label: PM25_SUB_INDEX)
        line2.colors = [NSUIColor.gray]
        line2.circleHoleColor = NSUIColor.gray
        line2.circleColors = [NSUIColor.clear]
        
        let line3 = LineChartDataSet(values: so2SubIndexValues, label: SO2_SUB_INDEX)
        line3.colors = [NSUIColor.blue]
        line3.circleHoleColor = NSUIColor.blue
        line3.circleColors = [NSUIColor.clear]
        
        let line4 = LineChartDataSet(values: coSubIndexValues, label: CO_SUB_INDEX)
        line4.colors = [NSUIColor.cyan]
        line4.circleHoleColor = NSUIColor.cyan
        line4.circleColors = [NSUIColor.clear]
        
        let line5 = LineChartDataSet(values: o3SubIndexValues, label: O3_SUB_INDEX)
        line5.colors = [NSUIColor.magenta]
        line5.circleHoleColor = NSUIColor.magenta
        line5.circleColors = [NSUIColor.clear]
        
        let data = LineChartData()
        data.addDataSet(line1)
        data.addDataSet(line2)
        data.addDataSet(line3)
        data.addDataSet(line4)
        data.addDataSet(line5)
        
        chartContainer.data = data
        chartContainer.chartDescription?.text = "PSI Data"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension PSIDetailsVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].readings.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as! HeaderCell
        let timestamp =  items[section].update_timestamp.toDate().toString()
        cell.headerTitle.text = "updated at "+timestamp
        return cell.contentView
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "psiCell", for: indexPath)
        
        var reading =  [[String : Int]]()
        for j in items[indexPath.section].readings {
            var e = j.1.filter({$0.0 == regionName})
            reading.append([j.0:e[0].1.intValue])
        }
        
        cell.textLabel?.text = "\(String(describing: reading[indexPath.row].keys.first!))"
        cell.detailTextLabel?.text = "\(String(describing: reading[indexPath.row].values.first!))"
        
        return cell
    }
}
