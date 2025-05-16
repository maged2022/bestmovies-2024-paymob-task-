//
//  MovieReposatoryImp.swift
//  BestMovies
//
//  Created by maged on 16/05/2025.
//

import Foundation
import Combine

final class MovieRepoImp: MovieRepoProtocol {
    
    var remoteRepo: MovieRemoteReposatory
    
    init(remoteRepo: MovieRemoteReposatory = MovieNetwork()) {
        self.remoteRepo = remoteRepo
    }
    
    func fetchMovies() -> AnyPublisher<[Movie], NetworkError> {
        remoteRepo.fetchMovies()
    }
}
