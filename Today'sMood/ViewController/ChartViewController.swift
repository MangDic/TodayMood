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
    var values: [Double] = []
    var mood: [String] = []
    var emptyLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chartContainerView.noDataText = "데이터가 없습니다 ㅠㅠ"
        chartContainerView.noDataFont = UIFont(name: "BinggraeTaom-Bold", size: 20)!
        
        setValues() {
            if self.diary.count == 0 {
                self.setEmptyLabel()
            }
            else {
                self.customizeChart(dataPoints: self.mood, values: self.values.map{ Double($0) })
            }
        }
        chartContainerView.animate(xAxisDuration: 1.0, yAxisDuration: 1.0)
    }
    
    @IBAction func didTabCancel(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    fileprivate func setEmptyLabel() {
        emptyLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.chartContainerView.bounds.size.width, height: self.chartContainerView.bounds.size.height))
        emptyLabel.text = "데이터가 없습니다 ㅠㅠ"
        emptyLabel.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        emptyLabel.font = UIFont(name: "BinggraeTaom-Bold", size: 20)
        emptyLabel.textAlignment = NSTextAlignment.center
    }
    
    fileprivate func setValues(completion: @escaping () -> Void ) {
        if diary != nil {
            var happyCnt = 0
            var sadCnt = 0
            var angryCnt = 0
            var keyOfMood = [String:Any]()
            for key in diary.keys {
                for item in diary[key]! {
                    switch item.mood {
                    case "happy":
                        happyCnt += 1
                        keyOfMood["좋아요"] = ""
                    case "sad":
                        sadCnt += 1
                        keyOfMood["슬퍼요"] = ""
                    default :
                        angryCnt += 1
                        keyOfMood["화나요"] = ""
                    }
                }
            }
            values = [Double(happyCnt), Double(sadCnt), Double(angryCnt)]
            for key in keyOfMood.keys {
                mood.append(key)
            }
        }
        completion()
    }
    
    func customizeChart(dataPoints: [String], values: [Double]) {
      
      // 1. Set ChartDataEntry
      var dataEntries: [ChartDataEntry] = []
      for i in 0..<dataPoints.count {
        let dataEntry = PieChartDataEntry(value: values[i], label: dataPoints[i], data: dataPoints[i] as AnyObject)
        dataEntries.append(dataEntry)
      }
      // 2. Set ChartDataSet
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: nil)
      pieChartDataSet.colors = colorsOfCharts(numbersOfColor: dataPoints.count)
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
