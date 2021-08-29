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
        
        let colorLiteral = #colorLiteral(red: 0.4844926596, green: 0.5600600243, blue: 0.9532049298, alpha: 1)
        self.layer.cornerRadius = 10
        self.layer.backgroundColor = colorLiteral.cgColor
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = UIFont(name: "BinggraeTaom-Bold", size: 18)
    }
}
