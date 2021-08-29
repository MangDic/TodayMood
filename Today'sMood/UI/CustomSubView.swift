//
//  CustomSubView.swift
//  TodaysMood
//
//  Created by 이명직 on 2021/08/27.
//

import Foundation
import UIKit

class CustomSubView : UIView {
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
        
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = #colorLiteral(red: 0.7203359008, green: 0.7957891822, blue: 0.9689690471, alpha: 1)
    }
}
