//
//  Networking.swift
//  Kamenica
//
//  Created by Branko Milosavljevic on 5.4.21..
//

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
          createBusList(obj)
          view.timeTable = obj
          let forSave = try? String(data: JSONEncoder().encode(obj), encoding: .utf8)
          writeFile("bus-lines.json", forSave!)
        } catch let error {
          print(error)
        }
      }
    }.resume()
  } else {
    let jsonData = text.data(using: .utf8)!
    if let content = try? JSONDecoder().decode(TimeTable.self, from: jsonData) {
      createBusList(content)
      DispatchQueue.main.async {
        view.timeTable = content
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

func createBusList(_ timeTable: TimeTable) -> [BusListItem] {
  let retVal: [BusListItem] = []
  let today = Date()
  print(today.dayType)
  return retVal
}

extension Date {
  var dayType: String {
    let dayNumber = Calendar.current.component(.weekday, from: self)
    print(dayNumber)
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
}
