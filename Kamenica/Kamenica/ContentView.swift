import SwiftUI

struct ContentView: View {
  
  @StateObject var appState: AppState = AppState()

  var body: some View {
    TabView {
      DeparturesView()
        .tabItem {
          Label("Iz Kamenice", systemImage: "bus")
        }
        .environmentObject(appState)
      ArrivalsView()
        .tabItem {
          Label("Za Kamenicu", systemImage: "bus.fill")
        }
        .environmentObject(appState)
      InfoView()
        .tabItem {
          Label("Info", systemImage: "info.circle")
        }
        .environmentObject(appState)
    }
    .onAppear(perform: initData)
    .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
      print("willEnterForeground")
      loadData(appState)
    }
  }
  
  func initData() {
    NotificationService.sharedInstance.authorizeNotification()
    NotificationService.sharedInstance.registerCategories()
    print("loading data")
    loadData(appState)
    print("data loaded")
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

