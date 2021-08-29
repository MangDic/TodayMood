//
//  HappyViewController.swift
//  TodaysMood
//
//  Created by 이명직 on 2021/08/24.
//

import UIKit

class HappyViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let happyIcons = ["😀", "😁", "😂", "🤣", "😃", "😄", "😅", "😆", "😼", "😻", "😺", "😎", "😆", "😊", "🤗"]
    
    weak var delegate: DeliveryDataProtocol?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return happyIcons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HappyIconCell", for: indexPath) as! HappyIconCell
        
        cell.label.text = happyIcons[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.deliveryData(iconAndMood(icon: happyIcons[indexPath.row], mood: "happy"))
    }

}
