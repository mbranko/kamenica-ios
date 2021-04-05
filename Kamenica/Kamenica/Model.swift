//
//  Model.swift
//  Kamenica
//
//  Created by Branko Milosavljevic on 5.4.21..
//

import Foundation

struct TimeTableItem: Codable {
    let h: Int
    let m: Int
    let t: String?
}

struct BusLine: Codable {
    let day: String
    let line: Int
    let from: [TimeTableItem]
    let to: [TimeTableItem]
}
