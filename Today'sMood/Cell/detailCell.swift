//
//  detailCell.swift
//  Today'sMood
//
//  Created by 이명직 on 2021/08/20.
//

import UIKit

class detailCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var iconView: UIView!
    @IBOutlet weak var icon: UILabel!
    
    var delete : (() -> ()) = {}
    
    @IBAction func didTabDelete(_ sender: Any) {
        delete()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
