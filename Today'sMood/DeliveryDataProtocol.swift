//
//  dd.swift
//  TodaysMood
//
//  Created by 이명직 on 2021/08/24.
//

import Foundation

protocol DeliveryDataProtocol: class {
    func deliveryData(_ data: iconAndMood)
}

protocol DeliveryDiaryProtocol: class {
    func deliveryData(_ data: Diary)
}
