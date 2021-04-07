
import SwiftUI

struct DeparturesView: View {
  
  @Binding var busesFrom: [BusListItem]
  
  var body: some View {
    VStack {
      HStack{
        Spacer()
        Text("Kamenica ➠ grad").font(Font.custom("Titillium Web", size: 40)).fontWeight(.bold).foregroundColor(.white).padding(10).padding(.top, 30)
        Spacer()
      }.background(Color(UIColor(rgb: 0x48668A)))
      List(busesFrom.indices, id: \.self) { index in
        BusLineView(line: $busesFrom[index]).contextMenu {
          Button(action: {
            self.setAlarm(item: busesFrom[index])
          }) {
            HStack {
              Text("Alarm 15 min")
              Image(systemName: "bell")
            }
          }
        }
      }
    }.onReceive(NotificationCenter.default.publisher(for: NSNotification.Name.init("alarmoff")), perform: { obj in
      if let userInfo = obj.userInfo, let itemUuid = userInfo["itemUuid"] as? String {
        for i in 0...busesFrom.count-1 {
          if busesFrom[i].id.uuidString == itemUuid {
            DispatchQueue.main.async {
              busesFrom[i].alarm.toggle()
            }
          }
        }
      }
    })
    .edgesIgnoringSafeArea(.top)
  }
  
  private func setAlarm(item busItem: BusListItem) {
    if let index = self.busesFrom.firstIndex(where: {$0.id == busItem.id}) {
      self.busesFrom[index].alarm.toggle()
      if self.busesFrom[index].alarm {
        NotificationService.sharedInstance.requestTimerNotification(busItem)
      } else {
        NotificationService.sharedInstance.removePendingNotifications(busItem)
      }
    }
  }
}

struct DeparturesView_Previews: PreviewProvider {
  static var previews: some View {
    DeparturesView(busesFrom: .constant([
      BusListItem(Date(), 71, nil),
      BusListItem(Date(), 72, nil),
      BusListItem(Date(), 73, nil),
      BusListItem(Date(), 74, nil),
    ]))
  }
}
