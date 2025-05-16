//
//  MovieReposatoryImp.swift
//  BestMovies
//
//  Created by maged on 16/05/2025.
//

import Foundation
import Combine

final class MovieReposatoryImp: MovieRepoProtocol {
    
    var remoteRepo: MovieRemoteReposatory
    
    init(remoteRepo: MovieRemoteReposatory = MovieNetwork()) {
        self.remoteRepo = remoteRepo
    }
    
    func fetchMovies() -> AnyPublisher<[Movie], any Error> {
        remoteRepo.fetchMovies()
    }
}
