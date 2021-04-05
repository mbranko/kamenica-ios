//
//  ContentView.swift
//  Kamenica
//
//  Created by Branko Milosavljevic on 4.4.21..
//

import SwiftUI

struct ContentView: View {
    
    @State var busLines = [BusLine]()
    
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
            InfoView()
                .tabItem {
                    Label("Info", systemImage: "info.circle")
                }
        }.onAppear(perform: loadData)
    }
    
    func loadData() {
        guard let url = URL(string: "https://kamenica.info/media/bus-lines.json") else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let response = try? JSONDecoder().decode([BusLine].self, from: data) {
                    DispatchQueue.main.async {
                        self.busLines = response
                    }
                    return
                }
            }
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

