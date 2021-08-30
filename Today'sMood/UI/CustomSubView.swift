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
        self.layer.borderWidth = 2
        self.layer.borderColor = #colorLiteral(red: 0.9882430434, green: 0.7561861873, blue: 0.7487457991, alpha: 1)
        
    }
}
