import SwiftUI

struct InfoView: View {
  
  @EnvironmentObject var appState: AppState
  
  var timeTableDate: String {
    let dateFormat = DateFormatter()
    dateFormat.dateFormat = "dd.MM.yyyy."
    return dateFormat.string(from: appState.timeTableDate)
  }
  
  var body: some View {
    VStack {
      Text("Kamenica Info")
        .font(Font.custom("Titillium Web", size: 40))
        .fontWeight(.bold).foregroundColor(Color(UIColor(rgb: 0x48668A))).padding()
      Text("Red vožnje: \(timeTableDate)").font(Font.custom("Titillium Web", size: 20)).padding()
    }
  }
}

struct InfoView_Previews: PreviewProvider {
  static var previews: some View {
    InfoView()
  }
}
