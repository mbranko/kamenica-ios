import SwiftUI
import SwiftUIRefresh

struct ArrivalsView: View {

  @EnvironmentObject var appState: AppState
  @State private var isShowing = false

  var body: some View {
    VStack {
      HStack {
        Spacer()
        Text("grad ➠ Kamenica").font(Font.custom("Titillium Web", size: 40)).fontWeight(.bold).foregroundColor(Color(UIColor(rgb: 0x48668A))).padding(10).padding(.top, 30)
        Spacer()
      }
      List(appState.busesTo.indices, id: \.self) { index in
        BusLineView(line: $appState.busesTo[index]).contextMenu {
          Button(action: {
            self.setAlarm(item: appState.busesTo[index])
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
        for i in 0...appState.busesTo.count-1 {
          if appState.busesTo[i].id.uuidString == itemUuid {
            DispatchQueue.main.async {
              appState.busesTo[i].alarm.toggle()
            }
          }
        }
      }
    })
    .edgesIgnoringSafeArea(.top)
  }

  private func setAlarm(item busItem: BusListItem) {
    if let index = appState.busesTo.firstIndex(where: {$0.id == busItem.id}) {
      appState.busesTo[index].alarm.toggle()
    }
  }
}

struct ArrivalsView_Previews: PreviewProvider {
  static var previews: some View {
    ArrivalsView()
  }
}
