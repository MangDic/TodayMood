//
//  Diary.swift
//  TodaysMood
//
//  Created by 이명직 on 2021/08/20.
//

import Foundation
import UIKit

struct Diary: Codable {
    let date: String
    let title: String
    let detail: String
    let image: String
    let mood: String
}
