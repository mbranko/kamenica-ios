//
//  ArrivalsView.swift
//  Kamenica
//
//  Created by Branko Milosavljevic on 4.4.21..
//

import SwiftUI

struct ArrivalsView: View {
  var body: some View {
    VStack {
      Text("Polasci za Kamenicu").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).fontWeight(.heavy)
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

struct ArrivalsView_Previews: PreviewProvider {
  static var previews: some View {
    ArrivalsView()
  }
}
