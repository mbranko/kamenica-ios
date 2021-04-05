import SwiftUI

struct InfoView: View {
  
  @Binding var tableDate: Date
  
  var timeTableDate: String {
    let dateFormat = DateFormatter()
    dateFormat.dateFormat = "dd.MM.yyyy."
    return dateFormat.string(from: tableDate)
  }
  
  var body: some View {
    VStack {
      Text("Kamenica Info")
        .font(.system(.largeTitle, design: .rounded))
        .fontWeight(.black).padding()
      Text("Verzija 1.0").padding()
      Text("Red vožnje: \(timeTableDate)").padding()
    }
  }
}

struct InfoView_Previews: PreviewProvider {
  static var previews: some View {
    InfoView(tableDate: .constant(Date()))
  }
}
