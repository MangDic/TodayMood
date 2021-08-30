//
//  ChartViewController.swift
//  TodaysMood
//
//  Created by 이명직 on 2021/08/25.
//

import UIKit
import Charts

class ChartViewController: UIViewController {

    @IBOutlet weak var chartContainerView: BarChartView!
    
    var diary = [String:[Diary]]()
    var emptyLabel = UILabel()
    var moodValues = [String:Double]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chartContainerView.noDataText = "데이터가 없습니다 ㅠㅠ"
        chartContainerView.noDataFont = UIFont(name: "THEHappyfruit", size: 24)!
        chartContainerView.noDataTextColor = #colorLiteral(red: 0.9891662002, green: 1, blue: 0.8718685508, alpha: 1)

        setValues() {
            if self.diary.count == 0 {
                self.setEmptyLabel()
            }
            else {
                self.customizeChart(data: self.moodValues)
            }
        }
        chartContainerView.animate(xAxisDuration: 1.0, yAxisDuration: 1.0)
    }
    
    
    @IBAction func didTabCancel(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    fileprivate func setEmptyLabel() {
        emptyLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.chartContainerView.bounds.size.width, height: self.chartContainerView.bounds.size.height))
        emptyLabel.textAlignment = NSTextAlignment.center
    }
    
    fileprivate func setValues(completion: @escaping () -> Void ) {
        if diary != nil {
            var happyCnt = 0
            var sadCnt = 0
            var angryCnt = 0
            for key in diary.keys {
                for item in diary[key]! {
                    switch item.mood {
                    case "happy":
                        happyCnt += 1
                    case "sad":
                        sadCnt += 1
                    default :
                        angryCnt += 1
                    }
                }
            }
            moodValues["신나요"] = Double(happyCnt)
            moodValues["슬퍼요"] = Double(sadCnt)
            moodValues["화나요"] = Double(angryCnt)
        }
        completion()
    }
    //dataPoints: [String], values: [Double]
    func customizeChart(data: [String:Double]) {
      
        var index = 0
      // 1. Set ChartDataEntry
      var dataEntries: [ChartDataEntry] = []
        for i in data.keys {
            if data[i] == 0 {
                continue
            }
            index += 1
            let dataEntry = PieChartDataEntry(value: data[i]!, label: i, data: i as AnyObject)
        dataEntries.append(dataEntry)
      }
      // 2. Set ChartDataSet
      let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: nil)
      pieChartDataSet.colors = colorsOfCharts(numbersOfColor: index)
        pieChartDataSet.entryLabelFont = UIFont(name: "THEHappyfruit", size: 10)
        pieChartDataSet.entryLabelColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        pieChartDataSet.selectionShift = CGFloat(10)
      // 3. Set ChartData
      let pieChartData = PieChartData(dataSet: pieChartDataSet)
      let format = NumberFormatter()
      format.numberStyle = .none
      let formatter = DefaultValueFormatter(formatter: format)
      pieChartData.setValueFormatter(formatter)
      chartContainerView.data = pieChartData
        
    }
    
    private func colorsOfCharts(numbersOfColor: Int) -> [UIColor] {
      var colors: [UIColor] = []
        colors.append(#colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1))
        colors.append(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1))
        colors.append(#colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1))
      return colors
    }
    
    fileprivate func setContainerView() {
        chartContainerView.layer.borderWidth = 1
        chartContainerView.layer.borderColor = #colorLiteral(red: 0.4344803691, green: 0.5318876505, blue: 1, alpha: 1)
    }

}
