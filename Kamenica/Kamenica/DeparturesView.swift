
import SwiftUI

struct DeparturesView: View {
  
  @Binding var busesFrom: [BusListItem]
  
  var body: some View {
    VStack {
      Text("Kamenica ➠ grad").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).fontWeight(.heavy)
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
//    }
    }.onReceive(NotificationCenter.default.publisher(for: NSNotification.Name.init("alarmoff")), perform: { obj in
      if let userInfo = obj.userInfo, let itemUuid = userInfo["itemUuid"] as? String {
        for var item in busesFrom {
          print(item.id.uuidString == itemUuid)
          if item.id.uuidString == itemUuid {
            item.alarm.toggle()
          }
        }
      }
    })
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
