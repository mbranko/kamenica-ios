
import SwiftUI

struct DeparturesView: View {
  var body: some View {
    VStack {
      Text("Polasci iz Kamenice").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).fontWeight(.heavy)
      List {
        BusLineView()
        BusLineView()
        BusLineView()
        BusLineView()
        BusLineView()
        BusLineView()
      }
    }
  }
}

struct DeparturesView_Previews: PreviewProvider {
  static var previews: some View {
    DeparturesView()
  }
}
