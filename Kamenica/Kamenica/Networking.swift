import Foundation

func loadData(view: ContentView) {
  let text: String = readFile("bus-lines.json")
  if text == "" {
    guard let url = URL(string: "https://kamenica.info/media/bus-lines.json") else {
      print("Invalid URL")
      return
    }
    let request = URLRequest(url: url)
    print(request)
    URLSession.shared.dataTask(with: request) { data, response, error in
      if let data = data {
        do {
          let decoder = JSONDecoder()
          let dateFormatter = DateFormatter()
          dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
          decoder.dateDecodingStrategy = .formatted(dateFormatter)
          let obj = try decoder.decode(TimeTable.self, from: data)
          (view.busesFrom, view.busesTo) = createBusList(obj)
          view.tableDate = obj.date
          let forSave = try? String(data: JSONEncoder().encode(obj), encoding: .utf8)
          writeFile("bus-lines.json", forSave!)
        } catch let error {
          print(error)
        }
      }
    }.resume()
  } else {
    print("loading from file")
    let jsonData = text.data(using: .utf8)!
    if let content = try? JSONDecoder().decode(TimeTable.self, from: jsonData) {
      DispatchQueue.main.async {
        view.tableDate = content.date
        (view.busesFrom, view.busesTo) = createBusList(content)
      }
    }
  }
}

func readFile(_ fileName: String) -> String {
  if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
    let fileUrl = dir.appendingPathComponent(fileName)
    do {
      let text = try String(contentsOf: fileUrl, encoding: .utf8)
      return text
    } catch {}
    return ""
  }
  return ""
}

func writeFile(_ fileName: String, _ text: String) {
  if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
    let fileUrl = dir.appendingPathComponent(fileName)
    do {
      try text.write(to: fileUrl, atomically: false, encoding: .utf8)
    } catch {}
  }
}

func createBusList(_ timeTable: TimeTable) -> ([BusListItem], [BusListItem]) {
  var fromKamenica: [BusListItem] = []
  var toKamenica: [BusListItem] = []
  let now = Date()
  let hour = Calendar.current.component(.hour, from: now)
  let minute = Calendar.current.component(.minute, from: now)
  let day = Calendar.current.component(.day, from: now)
  let month = Calendar.current.component(.month, from: now)
  let year = Calendar.current.component(.year, from: now)
  var components = DateComponents()
  components.year = year
  components.month = month
  components.day = day
  for line in timeTable.lines {
    for item in line.from {
      if include(now, hour, minute, line.day, item, line.line, true) {
        components.hour = item.h
        components.minute = item.m
        var date = Calendar.current.date(from: components)!
        if item.h < hour || (item.h == hour && item.m <= minute) {
          date = Calendar.current.date(byAdding: .day, value: 1, to: date)!
        }
        fromKamenica.append(BusListItem(date, line.line, item.t))
      }
    }
    for item in line.to {
      if include(now, hour, minute, line.day, item, line.line, false) {
        components.hour = item.h
        components.minute = item.m
        var date = Calendar.current.date(from: components)!
        if item.h < hour || (item.h == hour && item.m <= minute) {
          date = Calendar.current.date(byAdding: .day, value: 1, to: date)!
        }
        toKamenica.append(BusListItem(date, line.line, item.t))
      }
    }
  }
  fromKamenica.sort {
    $0.date < $1.date
  }
  toKamenica.sort {
    $0.date < $1.date
  }
  print(fromKamenica.count, toKamenica.count)
  return (fromKamenica, toKamenica)
}

func include(_ now: Date, _ hour: Int, _ minute: Int, _ dayType: String, _ item: TimeTableItem, _ line: Int, _ onlyKamenica: Bool) -> Bool {
  if onlyKamenica && ![68, 69, 71, 72, 73, 74].contains(line) {
    return false
  }
  if hour < 20 {
    return item.h >= hour && item.m >= minute && now.dayType == dayType
  } else {
    return (item.h >= hour && item.m >= minute && now.dayType == dayType) || (item.h <= 6 && item.m <= 59 && now.nextDayType == dayType)
  }
}

extension Date {
  var dayType: String {
    let dayNumber = Calendar.current.component(.weekday, from: self)
    switch dayNumber {
      case 1:
        return "N"
      case 2:
        return "R"
      case 3:
        return "R"
      case 4:
        return "R"
      case 5:
        return "R"
      case 6:
        return "R"
      case 7:
        return "S"
      default:
        return "X"
    }
  }
  var nextDayType: String {
    let dayNumber = Calendar.current.component(.weekday, from: self)
    switch dayNumber {
      case 1:
        return "R"
      case 2:
        return "R"
      case 3:
        return "R"
      case 4:
        return "R"
      case 5:
        return "R"
      case 6:
        return "S"
      case 7:
        return "N"
      default:
        return "X"
    }
  }
}
