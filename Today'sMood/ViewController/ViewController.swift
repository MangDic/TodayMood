//
//  ViewController.swift
//  Today'sMood
//
//  Created by 이명직 on 2021/08/20.
//

import UIKit
import ExpyTableView
import JJFloatingActionButton


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
        
        diaryViewModel.getDiary() { diaryData in
            self.item = diaryData
            self.myTableView.delegate = self
            self.myTableView.dataSource = self
            self.setKey()
        }
    }
    
    fileprivate func setEmptyLabel() {
        emptyLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height))
        emptyLabel.text = "새로운 기분을 추가해보세요!"
        emptyLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        emptyLabel.font = UIFont(name: "BinggraeTaom-Bold", size: 20)
        emptyLabel.textAlignment = NSTextAlignment.center
        self.myTableView.backgroundView = emptyLabel
        self.myTableView.separatorStyle = .none
    }
    
    fileprivate func setKey() {
        for i in item.keys {
            itemArrayKeys.append(i)
        }
    }
    
    fileprivate func saveDiary() {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(item), forKey:"diary")
    }
    
    fileprivate func setRightButton() {
        let actionButton = JJFloatingActionButton()
        
        actionButton.buttonColor = #colorLiteral(red: 0.7203359008, green: 0.7957891822, blue: 0.9689690471, alpha: 1)

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
        let date = temp[1] + " " + temp[2]
        
        if item[key]?.count == nil {
            print("카운트 0")
            itemArrayKeys.append(key)
            item[key] = [Diary(date: date, title: data.title, detail: data.detail, image: data.image, mood: data.mood)]
        }
        else {
            print("append")
            item[key]?.append(Diary(date: date, title: data.title, detail: data.detail, image: data.image, mood: data.mood))
        }
       
        self.myTableView.reloadData()
        self.saveDiary()
        
    }
}

extension ViewController: ExpyTableViewDelegate, ExpyTableViewDataSource {
    
    func tableView(_ tableView: ExpyTableView, canExpandSection section: Int) -> Bool {
        return true
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        print(item)
        print(item.count)
        print(itemArrayKeys)
        if item.count == 0 {
            emptyLabel.isHidden = false
            return 0
        }
        else {
            emptyLabel.isHidden = true
            return item.count
        }
    }
    
    // 헤더 셀 설정 (펼쳐지는 섹션)
    func tableView(_ tableView: ExpyTableView, expandableCellForSection section: Int) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as! HeaderCell
        cell.dataLabel.text = itemArrayKeys[section]
        cell.dataLabel.font = UIFont(name: "BinggraeTaom-Bold", size: 20)
        
        let bgView = UIView()
        bgView.backgroundColor = .gray
        cell.selectedBackgroundView = bgView
        
        cell.sectionIndex = section
        
        
        return cell
    }
    
    // 각 섹션에 들어갈 row의 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if itemArrayKeys.count == 0 {
            return 0
        }
        else {
            return item[itemArrayKeys[section]]!.count + 1
        }
    }
    
    // 펼쳐진 셀 설정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell") as! detailCell
        let diary  = item[itemArrayKeys[indexPath.section]] as! [Diary]
        cell.titleLabel.text = "\(diary[indexPath.row - 1].title)"
        cell.titleLabel.font = UIFont(name: "BinggraeTaom", size: 15)
        
        cell.dataLabel.text = diary[indexPath.row - 1].date
        cell.dataLabel.font = UIFont(name: "BinggraeTaom", size: 15)
        
        cell.icon.text = diary[indexPath.row - 1].image
        
        cell.iconView.layer.cornerRadius = 20
        cell.iconView.layer.borderColor = #colorLiteral(red: 0.7067331076, green: 0.7954463959, blue: 0.9846035838, alpha: 1)
        cell.iconView.layer.borderWidth = 1
        
        cell.delete = { [unowned self] in
            item[itemArrayKeys[indexPath.section]]?.remove(at: indexPath.row - 1)
            if item[itemArrayKeys[indexPath.section]]?.count == 0 {
                item.removeValue(forKey: itemArrayKeys[indexPath.section])
                itemArrayKeys.remove(at: indexPath.section)
                
            }
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
