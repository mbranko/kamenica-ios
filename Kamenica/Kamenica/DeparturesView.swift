
import SwiftUI
import SwiftUIRefresh

struct DeparturesView: View {

  @EnvironmentObject var appState: AppState
  @State private var isShowing = false
  
  var body: some View {
    VStack {
      HStack{
        Spacer()
        Text("Kamenica ➠ grad").font(Font.custom("Titillium Web", size: 40)).fontWeight(.bold).foregroundColor(.white).padding(10).padding(.top, 30)
        Spacer()
      }.background(Color(UIColor(rgb: 0x48668A)))
      List(appState.busesFrom.indices, id: \.self) { index in
        BusLineView(line: $appState.busesFrom[index]).contextMenu {
          Button(action: {
            self.setAlarm(item: appState.busesFrom[index])
          }) {
            HStack {
              Text("Alarm 15 min")
              Image(systemName: "bell")
            }
          }
        }
      }
      .pullToRefresh(isShowing: $isShowing) {
        loadData(appState)
        isShowing = false
        print("refreshed data")
      }
    }.onReceive(NotificationCenter.default.publisher(for: NSNotification.Name.init("alarmoff")), perform: { obj in
      if let userInfo = obj.userInfo, let itemUuid = userInfo["itemUuid"] as? String {
        for i in 0...appState.busesFrom.count-1 {
          if appState.busesFrom[i].id.uuidString == itemUuid {
            DispatchQueue.main.async {
              appState.busesFrom[i].alarm.toggle()
            }
          }
        }
      }
    })
    .edgesIgnoringSafeArea(.top)
  }
  
  private func setAlarm(item busItem: BusListItem) {
    if let index = appState.busesFrom.firstIndex(where: {$0.id == busItem.id}) {
      appState.busesFrom[index].alarm.toggle()
      if appState.busesFrom[index].alarm {
        NotificationService.sharedInstance.requestTimerNotification(busItem)
      } else {
        NotificationService.sharedInstance.removePendingNotifications(busItem)
      }
    }
  }
}

struct DeparturesView_Previews: PreviewProvider {
  static var previews: some View {
    DeparturesView()
  }
}
