//
//  MovieReposatoryImp.swift
//  BestMovies
//
//  Created by maged on 16/05/2025.
//

// MARK: - MovieRepoImp.swift
import Combine

final class MovieRepoImp: MovieRepoProtocol {
    private let remoteRepo: MovieRemoteReposatory // api 
    private let favoriteManager: FavoriteMovieManager // core data
    
    init(remoteRepo: MovieRemoteReposatory = MovieNetwork(),
         favoriteManager: FavoriteMovieManager = FavoriteMovieManager()) {
        self.remoteRepo = remoteRepo
        self.favoriteManager = favoriteManager
    }
    
    func fetchMovies(for year: String) -> AnyPublisher<[Movie], NetworkError> {
        remoteRepo.fetchMovies(for: year)
            .map { [weak self] movies in
                guard let self = self else { return movies }
                let favorites = self.favoriteManager.fetchAll()
                let favoriteIds = Set(favorites.map { $0.id })
                return movies.map { movie in
                    var updated = movie
                    updated.isFavorite = favoriteIds.contains(movie.id)
                    return updated
                }
            }
            .eraseToAnyPublisher()
    }
    
    func toggleFavorite(_ movie: Movie) {
        if movie.isFavorite == true {
            favoriteManager.save(movie)
        } else {
            favoriteManager.delete(movieId: movie.id)
        }
    }
}
