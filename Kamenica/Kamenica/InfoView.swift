//
//  InfoView.swift
//  Kamenica
//
//  Created by Branko Milosavljevic on 4.4.21..
//

import SwiftUI

struct InfoView: View {
    var body: some View {
        VStack {
            Text("Kamenica Info")
                .font(.system(.largeTitle, design: .rounded))
                .fontWeight(.black)
            Text("Verzija 1.0")
            Text("Red vožnje: 01.04.2021.")
        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
