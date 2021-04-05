import SwiftUI

struct ContentView: View {
  
  @State var tableDate = Date()
  @State var busesFrom: [BusListItem] = []
  @State var busesTo: [BusListItem] = []

  var body: some View {
    TabView {
      DeparturesView(busesFrom: $busesFrom)
        .tabItem {
          Label("Iz Kamenice", systemImage: "bus")
        }
      ArrivalsView(busesTo: $busesTo)
        .tabItem {
          Label("Za Kamenicu", systemImage: "bus.fill")
        }
      InfoView(tableDate: $tableDate)
        .tabItem {
          Label("Info", systemImage: "info.circle")
        }
    }.onAppear(perform: initData)
  }
  
  func initData() {
    loadData(view: self)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

