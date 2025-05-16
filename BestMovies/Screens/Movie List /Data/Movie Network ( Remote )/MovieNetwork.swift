//
//  MovieRemoteReposatory.swift
//  BestMovies
//
//  Created by maged on 16/05/2025.
//

import Foundation
import Combine

protocol MovieRemoteReposatory {
    func fetchMovies() -> AnyPublisher<[Movie], NetworkError>
}

final class MovieNetwork: MovieRemoteReposatory {
    
    private let networkManager: NetworkService
    
    init(networkManager: NetworkService = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func fetchMovies() -> AnyPublisher<[Movie], NetworkError> {
        let endpoint = MovieEndpoint.discoverMovies(year: "2024") // we can pass this year in the function
        
        return networkManager
            .request(MovieResponse.self, endpoint: endpoint)
            .map { $0.results }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
