//
//  Model.swift
//  PruebaPeliculas
//
//  Created by Albert on 28/5/21.
//

import Foundation

struct MoviesData: Decodable {
    let movies: [Movie]
    
    private enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}

struct Movie: Decodable {
    
    let title: String?
    let rate: Double?
    let posterImage: String?
    let overview: String?
    
    
    private enum CodingKeys: String, CodingKey {
        case title, overview
        case rate = "vote_average"
        case posterImage = "poster_path"
    }
}

