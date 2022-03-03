//
//  StateController.swift
//  MusicByLocation
//
//  Created by David Jin Li on 01/03/2022.
//

import Foundation

class StateController: ObservableObject {
    let locationHandler: LocationHandler = LocationHandler()
    let iTunesAdaptor = ITunesAdaptor()
    @Published var artistsByLocation: [Artist] = []
    
    var lastKnownLocation: String = "" {
        didSet {
            iTunesAdaptor.getArtists(search: lastKnownLocation, completion: updateArtistsByLocation)
        }
    }
   
    func findMusic(){
        locationHandler.requestLocation()
    }
    
    func requestAccessToLocationData() {
        locationHandler.stateController = self
        locationHandler.requestAuthorisation()
    }
    
    func updateArtistsByLocation(artists: [Artist]?) {
        //let names = artists?.map { return $0.name }
        DispatchQueue.main.async {
            if let artists = artists {
                self.artistsByLocation = artists
            }
        }
    }
}
