//
//  DiaryViewModel.swift
//  TodaysMood
//
//  Created by 이명직 on 2021/08/27.
//

import Foundation

class DiaryViewModel {
    
    var myDiary = [String:[Diary]]()
    
    func getDiary(completion: @escaping ([String:[Diary]]) -> Void) {
        if let data = UserDefaults.standard.value(forKey:"diary") as? Data {
            let diaryData = try? PropertyListDecoder().decode([String:[Diary]].self, from: data)
            self.myDiary = diaryData!
            completion(myDiary)
        }
    }
}
