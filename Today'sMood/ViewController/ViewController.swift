//
//  ViewController.swift
//  Today'sMood
//
//  Created by 이명직 on 2021/08/20.
//

import UIKit
import ExpyTableView
import JJFloatingActionButton
import CoreGraphics


class ViewController: UIViewController, DeliveryDiaryProtocol {

    @IBOutlet weak var myTableView: ExpyTableView!
    
    var diaryViewModel = DiaryViewModel()
    
    var emptyLabel = UILabel()
    var item = [String:[Diary]]()
    
    var itemArrayKeys = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setEmptyLabel()
        setRightButton()
        
        diaryViewModel.getDiary() { (item, keys) in
            self.item = item
            self.itemArrayKeys = keys
            self.myTableView.delegate = self
            self.myTableView.dataSource = self
            self.myTableView.reloadData()
        }
    }
    
    
    
    fileprivate func setEmptyLabel() {
        emptyLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height))
        emptyLabel.text = "새로운 기분을 추가해보세요!"
        emptyLabel.textColor = #colorLiteral(red: 0.9891662002, green: 1, blue: 0.8718685508, alpha: 1)
        emptyLabel.font = UIFont(name: "THEHappyfruit", size: 25)
        emptyLabel.textAlignment = NSTextAlignment.center
        self.myTableView.backgroundView = emptyLabel
        self.myTableView.separatorStyle = .none
    }
    
    fileprivate func saveDiary() {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(item), forKey:"diary")
    }
    
    fileprivate func isFirstTime() -> Bool {
        let defaults = UserDefaults.standard
        if defaults.object(forKey: "isFirstTime") == nil {
            defaults.set("No", forKey:"isFirstTime")
            return true
        } else {
            return false
        }
    }
    
    fileprivate func setRightButton() {
        let actionButton = JJFloatingActionButton()
        
        actionButton.buttonColor = #colorLiteral(red: 0.9882430434, green: 0.7561861873, blue: 0.7487457991, alpha: 1)

        actionButton.addItem(title: "나의 기분", image: UIImage(systemName: "chart.bar.xaxis")?.withRenderingMode(.alwaysTemplate)) { item in
            self.presentReportView()
        }

        actionButton.addItem(title: "일기 작성", image: UIImage(systemName: "pencil")?.withRenderingMode(.alwaysTemplate)) { item in
            self.presentAddView()
            
        }
        
        actionButton.display(inViewController: self)
    }
    
    fileprivate func presentReportView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let popup = storyboard.instantiateViewController(identifier: "ChartViewController") as! ChartViewController
        popup.modalTransitionStyle = .crossDissolve
        popup.modalPresentationStyle = .overFullScreen
        
        popup.diary = self.item

        self.present(popup, animated: true)
    }
    
    fileprivate func presentAddView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let popup = storyboard.instantiateViewController(identifier: "AddViewController") as! AddViewController
        popup.modalTransitionStyle = .crossDissolve
        popup.modalPresentationStyle = .overFullScreen
        
        popup.delegate = self

        self.present(popup, animated: true)
    }
    
    func deliveryData(_ data: Diary) {
        let temp = data.date.components(separatedBy: " ")
        let key = temp[0] + " " + temp[1]
        let date = temp[1] + " " + temp[2] + " " + temp[3]
        
        if item[key]?.count == nil {
            itemArrayKeys.append(key)
            item[key] = [Diary(date: date, title: data.title, detail: data.detail, image: data.image, mood: data.mood)]
        }
        else {
            item[key]?.append(Diary(date: date, title: data.title, detail: data.detail, image: data.image, mood: data.mood))
        }
        
        self.saveDiary()
        self.myTableView.reloadData()
        
    }
}

extension ViewController: ExpyTableViewDelegate, ExpyTableViewDataSource {
    
    func tableView(_ tableView: ExpyTableView, canExpandSection section: Int) -> Bool {
        return true
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if itemArrayKeys.count == 0 {
            emptyLabel.isHidden = false
            return 0
        }
        else {
            emptyLabel.isHidden = true
            return itemArrayKeys.count
        }
    }
    
    func tableView(_ tableView: ExpyTableView, expandableCellForSection section: Int) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as! HeaderCell
        cell.dataLabel.text = itemArrayKeys[section]
        cell.dataLabel.font = UIFont(name: "THEHappyfruit", size: 24)
        
        let bgView = UIView()
        bgView.backgroundColor = .gray
        cell.selectedBackgroundView = bgView
        
        let colorSeparator = ColorSeparator()
        let tempKey = itemArrayKeys[section].split(separator: " ")
        cell.myContentView.backgroundColor = colorSeparator.sepatateColorByKey(key: String(tempKey[1]))
        
        cell.sectionIndex = section
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if itemArrayKeys.count == 0 {
            return 0
        }
        else {
            return item[itemArrayKeys[section]]!.count + 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell") as! detailCell
        let diary  = item[itemArrayKeys[indexPath.section]] as! [Diary]
        cell.titleLabel.text = "\(diary[indexPath.row - 1].title)"
        cell.titleLabel.font = UIFont(name: "THEHappyfruit", size: 20)
        
        cell.dataLabel.text = diary[indexPath.row - 1].date
        cell.dataLabel.font = UIFont(name: "THEHappyfruit", size: 17)
        
        cell.icon.text = diary[indexPath.row - 1].image
        
        cell.iconView.layer.cornerRadius = 6
        cell.iconView.layer.borderColor = #colorLiteral(red: 0.9882430434, green: 0.7561861873, blue: 0.7487457991, alpha: 1)
        cell.iconView.layer.borderWidth = 2
        
        
        cell.delete = { [unowned self] in
            item[itemArrayKeys[indexPath.section]]?.remove(at: indexPath.row - 1)
            if item[itemArrayKeys[indexPath.section]]?.count == 0 {
                item.removeValue(forKey: itemArrayKeys[indexPath.section])
                itemArrayKeys.remove(at: indexPath.section)
                
            }
            self.saveDiary()
            myTableView.reloadData()
        }
        
        return cell
    }
    
    // 열리고 닫히고 상태가 변경될 경우
    func tableView(_ tableView: ExpyTableView, expyState state: ExpyState, changeForSection section: Int) {
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row != 0 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let popup = storyboard.instantiateViewController(identifier: "DetailViewController") as! DetailViewController
            popup.modalTransitionStyle = .crossDissolve
            popup.modalPresentationStyle = .overFullScreen
            
            let diary  = item[itemArrayKeys[indexPath.section]] as! [Diary]
            popup.getDiary = diary[indexPath.row - 1]

            self.present(popup, animated: true)
        }
    }
}
