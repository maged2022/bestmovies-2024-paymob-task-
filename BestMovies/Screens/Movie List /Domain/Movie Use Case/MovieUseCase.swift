//
//  MovieUseCase.swift
//  BestMovies
//
//  Created by maged on 16/05/2025.
//

// MARK: - MovieUseCase.swift
import Foundation
import Combine

protocol MovieUseCaseProtocol {
    func fetchMovies(for year: String) -> AnyPublisher<[Movie], NetworkError>
    func toggleFavorite(_ movie: Movie)
}

final class MovieUseCase: MovieUseCaseProtocol {
    private let repository: MovieRepoProtocol
    
    init(repository: MovieRepoProtocol = MovieRepoImp()) {
        self.repository = repository
    }
    
    func fetchMovies(for year: String) -> AnyPublisher<[Movie], NetworkError> {
           repository.fetchMovies(for: year)
    }
    
    func toggleFavorite(_ movie: Movie) {
        repository.toggleFavorite(movie)
    }
}
