//
//  DiaryViewModel.swift
//  TodaysMood
//
//  Created by 이명직 on 2021/08/27.
//

import Foundation

class DiaryViewModel {
    
    var myDiary = [String:[Diary]]()
    var itemArrayKeys = [String]()
    
    func getDiary(completion: @escaping ([String:[Diary]], [String]) -> Void) {
        if let data = UserDefaults.standard.value(forKey:"diary") as? Data {
            print("User 데이터가 있어")
            let diaryData = try? PropertyListDecoder().decode([String:[Diary]].self, from: data)
            sortData(getData: diaryData!)
            completion(self.myDiary, self.itemArrayKeys)
        }
        else {
            print("User 데이터가 없어")
            UserDefaults.standard.set(try? PropertyListEncoder().encode(myDiary), forKey:"diary")
            completion(self.myDiary, self.itemArrayKeys)
        }
    }
    
    fileprivate func sortData(getData: [String:[Diary]]) {
        let newArr = getData.sorted(by: {getNumberByKey(key: $0.key) < getNumberByKey(key: $1.key)})
        self.itemArrayKeys.removeAll()
        for i in newArr {
            self.itemArrayKeys.append(i.key)
            self.myDiary[i.key] = i.value
        }
    }
    
    fileprivate func getNumberByKey(key : String) -> Int{
        var number = 0
        let temp = key.split(separator: " ")
        let lastData = temp[1].split(separator: "월")
        return Int(lastData[0])!
    }
}
