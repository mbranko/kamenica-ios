import SwiftUI

struct BusLineView: View {
  var body: some View {
    HStack {
      VStack {
        Text("71").font(.system(.title, design: .rounded)).fontWeight(.bold).foregroundColor(.white).padding(8)
      }.background(Color.blue)
      Text("12:50").fontWeight(.bold)
      
    }
  }
}
