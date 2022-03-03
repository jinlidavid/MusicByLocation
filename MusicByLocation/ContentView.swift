//
//  ContentView.swift
//  MusicByLocation
//
//  Created by David Jin Li on 28/02/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var state = StateController()
    
    var body: some View {
        NavigationView {
            VStack {
                List(state.artistsByLocation, id: \.self) { element in
                    LazyVStack {
                        Link("\(element.name)",destination: URL(string: "\(element.url)")!)
                        Text("Genre: \(element.genre ?? "Error")")
                    }
                }
                Button("Find Music", action: {
                    state.findMusic()
                })
            } .onAppear(perform: {
                state.requestAccessToLocationData()
            }).navigationTitle("Music By Location")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
