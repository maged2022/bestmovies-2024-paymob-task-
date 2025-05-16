//
//  MovieRemoteReposatory.swift
//  BestMovies
//
//  Created by maged on 16/05/2025.
//

import Foundation
import Combine

protocol MovieRemoteReposatory {
    func fetchMovies() -> AnyPublisher<[Movie], Error>
}

final class MovieNetwork: MovieRemoteReposatory {
    
    private let apiKey = "20d6df7ea9cab199efce363288508c17" // Replace with your TMDB API Key
    private let baseURL = "https://api.themoviedb.org/3/discover/movie"
    
    func fetchMovies() -> AnyPublisher<[Movie], Error> {
        guard var components = URLComponents(string: baseURL) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        components.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "primary_release_year", value: "2024"),
            URLQueryItem(name: "sort_by", value: "popularity.desc")
        ]
        
        guard let url = components.url else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: MovieResponse.self, decoder: JSONDecoder())
            .map { $0.results }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
