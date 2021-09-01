//
//  ColorSeparator.swift
//  TodaysMood
//
//  Created by 이명직 on 2021/08/30.
//

import Foundation
import UIKit

class ColorSeparator {
    func sepatateColorByKey(key: String) -> UIColor {
        var color = UIColor()
        switch key {
        case "1월":
            color = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        case "2월":
            color = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        case "3월":
            color = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        case "4월":
            color = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        case "5월":
            color = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        case "6월":
            color = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        case "7월":
            color = #colorLiteral(red: 1, green: 0.7287777066, blue: 0.970733583, alpha: 1)
        case "8월":
            color = #colorLiteral(red: 0.6163480878, green: 0.9439821839, blue: 1, alpha: 1)
        case "9월":
            color = #colorLiteral(red: 1, green: 0.555460155, blue: 0.5334179401, alpha: 1)
        case "10월":
            color = #colorLiteral(red: 0.8328177333, green: 0.5459619761, blue: 1, alpha: 1)
        case "11월":
            color = #colorLiteral(red: 0.7130406499, green: 0.7088038325, blue: 0.7162986398, alpha: 1)
        default:
            color = #colorLiteral(red: 1, green: 0.4190351963, blue: 0.5978549123, alpha: 1)
        }
        
        return color
    }
}
