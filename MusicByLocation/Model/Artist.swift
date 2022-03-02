//
//  Artist.swift
//  MusicByLocation
//
//  Created by David Jin Li on 01/03/2022.
//

import Foundation

struct Artist: Codable {
    var name: String
    
    private enum CodingKeys: String, CodingKey {
        case name = "artistName"
    }
}
