//
//  MovieUseCase.swift
//  BestMovies
//
//  Created by maged on 16/05/2025.
//

import Foundation
import Combine

final class MovieUseCase: MovieRepoProtocol {
    
    var repoImplmentation: MovieRepoProtocol
    
    init(repoImplmentation: MovieRepoProtocol = MovieReposatoryImp()) {
        self.repoImplmentation = repoImplmentation
    }
    
    func fetchMovies() -> AnyPublisher<[Movie], any Error> {
        repoImplmentation.fetchMovies()
    }
}
