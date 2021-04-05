import SwiftUI

struct ContentView: View {
  
  @State var timeTable: TimeTable = TimeTable()
  
  var body: some View {
    TabView {
      DeparturesView()
        .tabItem {
          Label("Iz Kamenice", systemImage: "bus")
        }
      ArrivalsView()
        .tabItem {
          Label("Za Kamenicu", systemImage: "bus.fill")
        }
      InfoView(timeTable: $timeTable)
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

