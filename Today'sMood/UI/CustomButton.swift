//
//  CustomButton.swift
//  TodaysMood
//
//  Created by 이명직 on 2021/08/24.
//

import Foundation
import UIKit

class CustomButton : UIButton{
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
        
        let colorLiteral = #colorLiteral(red: 0.9882430434, green: 0.7561861873, blue: 0.7487457991, alpha: 1)
        self.layer.cornerRadius = 6
        self.layer.backgroundColor = colorLiteral.cgColor
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = UIFont(name: "THEHappyfruit", size: 16)
        
        self.layer.masksToBounds = false  // 내부에 속한 요소들이 UIView 밖을 벗어날 때, 잘라낼 것인지. 그림자는 밖에 그려지는 것이므로 false 로 설정
        self.layer.shadowOffset = CGSize(width: 0, height: 4) // 위치조정
        self.layer.shadowRadius = 5 // 반경
        self.layer.shadowOpacity = 0.3
    }
}
