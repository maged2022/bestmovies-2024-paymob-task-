//
//  MovieDetailsViewController.swift
//  BestMovies
//
//  Created by maged on 15/05/2025.
//

import UIKit

protocol MovieDetailsViewControllerDelegate: AnyObject {
    func movieDetailsViewController(_ controller: MovieDetailsViewController, didUpdateFavoriteStatusFor movie: Movie)
}

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var movie: Movie?
    weak var delegate: MovieDetailsViewControllerDelegate?
    
    private let favoriteManager = FavoriteMovieManager() // Core Data manager
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = "Movie Details"
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func setupUI() {
        guard let movie = movie else { return }
        titleLabel.text = movie.title
        ratingLabel.text = "⭐️ \(movie.voteAverage)/10"
        releaseDateLabel.text = "📅 \(movie.releaseDate)"
        overviewLabel.text = movie.overview
        languageLabel.text = "Language: \(movie.originalLanguage.uppercased())"
        updateFavoriteIcon(isFavorite: movie.isFavorite == true)
        
        if let posterPath = movie.posterPath,
           let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)") {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                if let data = data {
                    DispatchQueue.main.async {
                        self.posterImageView.image = UIImage(data: data)
                    }
                }
            }.resume()
        }
    }
    
    private func updateFavoriteIcon(isFavorite: Bool) {
        let imageName = isFavorite ? "heart.fill" : "heart"
        favoriteButton.setImage(UIImage(systemName: imageName), for: .normal)
        favoriteButton.tintColor = isFavorite ? .systemRed : .gray
    }
    
    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        guard var movie = movie else { return }
        movie.isFavorite?.toggle()
        
        if movie.isFavorite == true {
            favoriteManager.save(movie)
        } else {
            favoriteManager.delete(movieId: movie.id)
        }
        
        updateFavoriteIcon(isFavorite: movie.isFavorite == true)
        self.movie = movie
        delegate?.movieDetailsViewController(self, didUpdateFavoriteStatusFor: movie)
    }
}
