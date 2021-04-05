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
      Text("\(line.line)").font(.system(.title, design: .rounded)).fontWeight(.bold).foregroundColor(.white).frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).background(Color.blue)
      Text("\(line.tag ?? "")").fontWeight(.bold).foregroundColor(.gray).frame(width:40)
      Text("\(busTime)").fontWeight(.bold)
      if line.alarm {
        Spacer()
        Image(systemName: "bell").foregroundColor(.red)
      }
    }
  }
}
