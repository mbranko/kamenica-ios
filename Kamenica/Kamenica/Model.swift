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

struct BusListItem: Hashable {
  let id = UUID()
  let date: Date
  let line: Int
  let tag: String?
  var alarm: Bool = false
  init(_ date: Date, _ line: Int, _ tag: String?) {
    self.date = date
    self.line = line
    self.tag = tag
  }
  func hash(into hasher: inout Hasher) {
    hasher.combine(date)
    hasher.combine(line)
  }
}

class AppState: ObservableObject {
  @Published var busesFrom: [BusListItem] = []
  @Published var busesTo: [BusListItem] = []
  @Published var timeTableDate: Date = Date()
}
