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

struct TimeTable: Codable {
  let date: Date
  let lines: [BusLine]
  init() {
    date = Date()
    lines = []
  }
}

struct BusListItem {
  let date: Date
  let line: Int
}
