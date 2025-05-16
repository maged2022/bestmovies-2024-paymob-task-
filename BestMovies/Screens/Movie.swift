//
//  Movie.swift
//  BestMovies
//
//  Created by maged on 16/05/2025.
//

import Foundation

struct Movie: Decodable {
    let id: Int
    let title: String
    let posterPath: String?
    let voteAverage: Double
    let releaseDate: String
    let overview: String
    let originalLanguage: String
    var isFavorite: Bool? = false
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
        case originalLanguage = "original_language"
    }
}

struct MovieResponse: Decodable {
    let results: [Movie]
}
