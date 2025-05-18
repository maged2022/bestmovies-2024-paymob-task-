//
//  MovieDetailsViewModel.swift
//  BestMovies
//
//  Created by maged on 18/05/2025.
//

import Foundation

// MARK: - Presentation Layer

// Presentation/MovieDetails/MovieDetailsViewModel.swift
protocol MovieDetailsViewModelProtocol {
    var titleText: String { get }
    var ratingText: String { get }
    var releaseDateText: String { get }
    var overviewText: String { get }
    var languageText: String { get }
    var posterURL: String { get }
    var isFavorite: Bool { get }
    
    func toggleFavorite()
}

final class MovieDetailsViewModel: MovieDetailsViewModelProtocol {
    private var movie: Movie
    private let toggleFavoriteUseCase: MovieDetailsProtocol
    var onFavoriteToggled: ((Movie) -> Void)?

    init(movie: Movie, toggleFavoriteUseCase: MovieDetailsProtocol) {
        self.movie = movie
        self.toggleFavoriteUseCase = toggleFavoriteUseCase
    }

    var titleText: String { movie.title }
    var ratingText: String { "⭐️ \(movie.voteAverage)/10" }
    var releaseDateText: String { "📅 \(movie.releaseDate)" }
    var overviewText: String { movie.overview }
    var languageText: String { "Language: \(movie.originalLanguage.uppercased())" }
    var posterURL: String { movie.posterPath ?? "" }
    var isFavorite: Bool { movie.isFavorite == true }

    func toggleFavorite() {
        toggleFavoriteUseCase.execute(movie: &movie)
        onFavoriteToggled?(movie)
    }
}
