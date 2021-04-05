import SwiftUI

struct ArrivalsView: View {

  @Binding var busesTo: [BusListItem]
  
  var body: some View {
    VStack {
      Text("grad ➠ Kamenica").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).fontWeight(.heavy)
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
    }
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
