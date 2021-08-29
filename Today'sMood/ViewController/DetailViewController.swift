//
//  DetailViewController.swift
//  TodaysMood
//
//  Created by 이명직 on 2021/08/23.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var containView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var icon: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconView: UIView!
    
    
    var getDiary = Diary(date: "", title: "", detail: "", image: "", mood: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateLabel.text = getDiary.date
        detailTextView.text = getDiary.detail
        titleLabel.text = getDiary.title
        icon.text = getDiary.image
        
        
    }
    @IBAction func didTapCancel(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
