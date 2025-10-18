//
//  Model.swift
//  Game Stream
//
//  Created by David Giron on 10/10/25.
//

import Foundation

//Se puede codificar y decodificar
struct Results: Codable{
    var results: [Game]
}

struct Games: Codable{
    var games: [Game]
}

struct Game: Codable, Hashable{
    var title: String
    var studio: String
    var contentRaiting: String
    var publicationYear: String
    var description: String
    var platforms: [String]
    var tags: [String]
    var videosUrls: VideoURL
    var galleryImages: [String]
}

struct VideoURL: Codable, Hashable {
    var mobile: String
    var tablet: String
}
