
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
    }
  }
  
  private func setAlarm(item busItem: BusListItem) {
    if let index = self.busesFrom.firstIndex(where: {$0.id == busItem.id}) {
      self.busesFrom[index].alarm.toggle()
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
