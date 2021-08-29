//
//  AddViewController.swift
//  TodaysMood
//
//  Created by 이명직 on 2021/08/24.
//

import UIKit
import PagingKit

class AddViewController: UIViewController, DeliveryDataProtocol {
    

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var iconLabel: UILabel!
    @IBOutlet weak var myTextView: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var warningMessage: UILabel!
    
    weak var delegate: DeliveryDiaryProtocol?
    
    var menuViewController: PagingMenuViewController!
    var contentViewController: PagingContentViewController!
    var getLabel = "😀"
    var getMood = "happy"
    var dataSource = [(menu: String, content: UIViewController)]() {
        didSet {
            menuViewController.reloadData()
            contentViewController.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuViewController.register(nib: UINib(nibName: "iconCategoryCell", bundle: nil), forCellWithReuseIdentifier: "iconCategoryCell")
        menuViewController.registerFocusView(nib: UINib(nibName: "focus", bundle: nil))
        menuViewController.cellAlignment = .center
        
        dataSource = makeDataSource()
        
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = #colorLiteral(red: 0.7203359008, green: 0.7957891822, blue: 0.9689690471, alpha: 1)
        
        myTextView.layer.cornerRadius = 10
        myTextView.layer.borderWidth = 1
        myTextView.layer.borderColor = #colorLiteral(red: 0.7203359008, green: 0.7957891822, blue: 0.9689690471, alpha: 1)
        
        setTodayData()

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        myTextView.resignFirstResponder()
        self.view.endEditing(true)

   }
    
    func deliveryData(_ data: iconAndMood) {
        iconLabel.text = data.icon
        getMood = data.mood
    }
    
    @IBAction func didTapCompletion(_ sender: Any) {
        if titleText.text == "" {
            warningMessage.isHidden = false
        }
        else {
            delegate?.deliveryData(Diary(date: self.dateLabel.text!, title: titleText.text!, detail: myTextView.text!, image: self.iconLabel.text!, mood: getMood))
            self.dismiss(animated: true)
        }
    }
    @IBAction func didTapCancel(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    fileprivate func setTodayData() {
        let today = NSDate() //현재 시각 구하기
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 M월 d일"
        var dateString = dateFormatter.string(from: today as Date)
        dateFormatter.dateFormat = "EE"
        let temp = dateFormatter.string(from: today as Date)
        print(temp)
        self.dateLabel.text = dateString
        
        
    }
    
    fileprivate func makeDataSource() -> [(menu: String, content: UIViewController)] {
        let menu = ["신나요", "슬퍼요", "화나요"]
        
        return menu.map {
            let title = $0
            switch title {
            case "신나요":
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "HappyViewController") as! HappyViewController
                vc.delegate = self
                return (menu: title, content: vc)
            case "슬퍼요":
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "SadViewController") as! SadViewController
                vc.delegate = self
                return (menu: title, content: vc)
            default :
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MadViewController") as! MadViewController
                vc.delegate = self
                return (menu: title, content: vc)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? PagingMenuViewController {
            menuViewController = vc
            menuViewController.dataSource = self
            menuViewController.delegate = self
        }
        else if let vc = segue.destination as? PagingContentViewController {
            contentViewController = vc
            contentViewController.dataSource = self
            contentViewController.delegate = self
        }
    }
}

// 메뉴 데이터 소스
extension AddViewController: PagingMenuViewControllerDataSource {
    func numberOfItemsForMenuViewController(viewController: PagingMenuViewController) -> Int {
        return dataSource.count
    }
    
    func menuViewController(viewController: PagingMenuViewController, widthForItemAt index: Int) -> CGFloat {
        return 50
    }
    
    func menuViewController(viewController: PagingMenuViewController, cellForItemAt index: Int) -> PagingMenuViewCell {
        let cell = viewController.dequeueReusableCell(withReuseIdentifier: "iconCategoryCell", for: index) as! iconCategoryCell
        cell.label.text = dataSource[index].menu
        return cell
    }
}

// 메뉴 컨트롤 델리게이트
extension AddViewController: PagingMenuViewControllerDelegate {
    func menuViewController(viewController: PagingMenuViewController, didSelect page: Int, previousPage: Int) {
        contentViewController.scroll(to: page, animated: true)
    }
}

// 컨텐트 데이터 소스(내용)
extension AddViewController: PagingContentViewControllerDataSource {
    func numberOfItemsForContentViewController(viewController: PagingContentViewController) -> Int {
        return dataSource.count
    }
    
    // dataSource의 각 뷰를 넣어줌
    func contentViewController(viewController: PagingContentViewController, viewControllerAt index: Int) -> UIViewController {
        return dataSource[index].content
    }
}

// 컨텐트 컨트롤 델리게이트
extension AddViewController: PagingContentViewControllerDelegate {
    func contentViewController(viewController: PagingContentViewController, didManualScrollOn index: Int, percent: CGFloat) {
        // 컨텐트 스크롤하면 메뉴 스크롤한다!
        menuViewController.scroll(index: index, percent: percent, animated: false)
    }
}
