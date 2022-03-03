//
//  Artist.swift
//  MusicByLocation
//
//  Created by David Jin Li on 01/03/2022.
//

import Foundation

struct Artist: Codable, Hashable {
    var name: String
    var url: String
    var genre: String?
    
    private enum CodingKeys: String, CodingKey {
        case name = "artistName"
        case url = "artistLinkUrl"
        case genre = "primaryGenreName"
    }
}
