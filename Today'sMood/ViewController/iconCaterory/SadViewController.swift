//
//  SadViewController.swift
//  TodaysMood
//
//  Created by 이명직 on 2021/08/24.
//

import UIKit

class SadViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var delegate: DeliveryDataProtocol?
    
    let sadIcons = ["😞", "😭", "😫", "😢", "😥", "😰", "🥺", "😨", "😵‍💫", "😮‍💨", "🤦‍♀️", "🤦"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sadIcons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SadIconCell", for: indexPath) as! SadIconCell
        
        cell.label.text = sadIcons[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.deliveryData(iconAndMood(icon: sadIcons[indexPath.row], mood: "sad"))
    }
}
