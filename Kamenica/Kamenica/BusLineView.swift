import SwiftUI

struct BusLineView: View {

  @Binding var line: BusListItem
  
  var busTime: String {
    let dateFormat = DateFormatter()
    dateFormat.dateFormat = "HH:mm"
    return dateFormat.string(from: line.date)
  }

  var body: some View {
    HStack {
      Text("\(line.line)").font(Font.custom("Titillium Web", size: 30)).fontWeight(.bold).foregroundColor(.white).frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).background(Color(UIColor(rgb: 0x48668A)))
      Text("\(line.tag ?? "")").font(Font.custom("Titillium Web", size: 20)).fontWeight(.bold).foregroundColor(.gray).frame(width:45)
      Text("\(busTime)").font(Font.custom("Titillium Web", size: 20)).fontWeight(.bold)
      if line.alarm {
        Spacer()
        Image(systemName: "bell").foregroundColor(.red)
      }
    }
  }
}
