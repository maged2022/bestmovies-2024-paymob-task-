//
//  MovieRepoProtocol.swift
//  BestMovies
//
//  Created by maged on 16/05/2025.
//

// MARK: - MovieRepoProtocol.swift
import Combine

protocol MovieRepoProtocol {
    func fetchMovies(for year: String) -> AnyPublisher<[Movie], NetworkError>
    func toggleFavorite(_ movie: Movie)
}
