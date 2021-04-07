import SwiftUI

struct ArrivalsView: View {

  @Binding var busesTo: [BusListItem]
  
  var body: some View {
    VStack {
      HStack {
        Spacer()
        Text("grad ➠ Kamenica").font(Font.custom("Titillium Web", size: 40)).fontWeight(.bold).foregroundColor(Color(UIColor(rgb: 0x48668A))).padding(10).padding(.top, 30)
        Spacer()
      }
      List(busesTo.indices, id: \.self) { index in
        BusLineView(line: $busesTo[index]).contextMenu {
          Button(action: {
            self.setAlarm(item: busesTo[index])
          }) {
            HStack {
              Text("Alarm 15 min  ")
              Image(systemName: "bell")
            }
          }
        }
      }
    }.onReceive(NotificationCenter.default.publisher(for: NSNotification.Name.init("alarmoff")), perform: { obj in
      if let userInfo = obj.userInfo, let itemUuid = userInfo["itemUuid"] as? String {
        for i in 0...busesTo.count-1 {
          if busesTo[i].id.uuidString == itemUuid {
            DispatchQueue.main.async {
              busesTo[i].alarm.toggle()
            }
          }
        }
      }
    })
    .edgesIgnoringSafeArea(.top)
  }

  private func setAlarm(item busItem: BusListItem) {
    if let index = self.busesTo.firstIndex(where: {$0.id == busItem.id}) {
      self.busesTo[index].alarm.toggle()
    }
  }
}

struct ArrivalsView_Previews: PreviewProvider {
  static var previews: some View {
    ArrivalsView(busesTo: .constant([
      BusListItem(Date(), 71, nil),
      BusListItem(Date(), 72, nil),
      BusListItem(Date(), 73, nil),
      BusListItem(Date(), 74, nil),
    ]))
  }
}
