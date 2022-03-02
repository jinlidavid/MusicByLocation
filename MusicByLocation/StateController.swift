//
//  StateController.swift
//  MusicByLocation
//
//  Created by David Jin Li on 01/03/2022.
//

import Foundation

class StateController: ObservableObject {
    var lastKnownLocation: String = "" {
        didSet {
            getArtists(search: lastKnownLocation)
        }
    }
    @Published var artistsByLocation: String = ""
    let locationHandler: LocationHandler = LocationHandler()
    
    func findMusic(){
        locationHandler.requestLocation()
    }
    
    func requestAccessToLocationData() {
        locationHandler.stateController = self
        locationHandler.requestAuthorisation()
    }
    
    func getArtists(search: String) {
        guard let url = URL(string: "https://itunes.apple.com/search?term=\(search)&entity=musicArtist").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                if let response = self.parseJson(json: data) {
                    let names = response.results.map {
                        return $0.name
                    }
                    DispatchQueue.main.async {
                        self.artistsByLocation = names.joined(separator: ", ")
                    }
                }
            }
        }.resume()
    }
    
    func parseJson(json: Data) -> ArtistResponse? {
        let decoder = JSONDecoder()
        do {
            let artistResponse = try decoder.decode(ArtistResponse.self, from: json)
            return artistResponse

        } catch {
            print("Error decoding JSON")
            return nil
        }
    }
}
