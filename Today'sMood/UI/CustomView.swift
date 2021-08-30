//
//  CustomView.swift
//  TodaysMood
//
//  Created by 이명직 on 2021/08/24.
//

import Foundation
import UIKit

class CustomView : UIView {
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
        
        self.layer.cornerRadius = 10
        
        self.layer.masksToBounds = false  // 내부에 속한 요소들이 UIView 밖을 벗어날 때, 잘라낼 것인지. 그림자는 밖에 그려지는 것이므로 false 로 설정
        self.layer.shadowOffset = CGSize(width: 0, height: 4) // 위치조정
        self.layer.shadowRadius = 5 // 반경
        self.layer.shadowOpacity = 0.3
    }
}
