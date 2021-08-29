//
//  MadViewController.swift
//  TodaysMood
//
//  Created by 이명직 on 2021/08/24.
//

import UIKit

class MadViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let madIcons = ["😠", "🙁", "😩", "😮‍💨", "😡", "🤯", "🤬", "👿", "😾", "🙅‍♀️","👎", "💢"]
    
    weak var delegate: DeliveryDataProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return madIcons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MadIconCell", for: indexPath) as! MadIconCell
        
        cell.label.text = madIcons[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.deliveryData(iconAndMood(icon: madIcons[indexPath.row], mood: "angry"))
    }

}
