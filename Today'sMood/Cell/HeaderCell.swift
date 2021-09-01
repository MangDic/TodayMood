//
//  HeaderCell.swift
//  Today'sMood
//
//  Created by 이명직 on 2021/08/20.
//

import UIKit
import ExpyTableView

class HeaderCell: UITableViewCell, ExpyTableViewHeaderCell {
    
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var arrowImage: UIImageView!
    @IBOutlet weak var myContentView: UIView!
    
    var sectionIndex: Int = 0 {
        didSet {
            
        }
    }
    
    func changeState(_ state: ExpyState, cellReuseStatus cellReuse: Bool) {
        switch state {
        case .willExpand:
            self.arrowDown(animated: true)
        case .willCollapse:
            self.arrowUp(animated: true)
        case .didExpand:
            print("")
        case .didCollapse:
            print("")
        }
    }
    
    fileprivate func arrowDown(animated: Bool) {
        UIView.animate(withDuration: animated ? 0.3 : 0) {
            self.arrowImage.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        }
    }
    
    fileprivate func arrowUp(animated: Bool) {
        UIView.animate(withDuration: animated ? 0.3 : 0) {
            self.arrowImage.transform = CGAffineTransform(rotationAngle: 0)
        }
    }
}
