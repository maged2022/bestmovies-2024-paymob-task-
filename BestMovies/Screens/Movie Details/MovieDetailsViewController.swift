//
//  MovieDetailsViewController.swift
//  BestMovies
//
//  Created by maged on 15/05/2025.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var movie: Movie?
    var onFavoriteChanged: ((Bool) -> Void)?
    
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
        posterImageView.image = UIImage(named: movie.posterName)
        titleLabel.text = movie.title
        ratingLabel.text = "⭐️ \(movie.voteAverage)/10"
        releaseDateLabel.text = "📅 \(movie.releaseDate)"
        overviewLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
        languageLabel.text = "Language: 🇺🇸 English" // لو جالك من API عدله هنا
        updateFavoriteButton()
    }
    
    private func updateFavoriteButton() {
        guard let movie = movie else { return }
        let imageName = movie.isFavorite ? "heart.fill" : "heart"
        favoriteButton.setImage(UIImage(systemName: imageName), for: .normal)
        favoriteButton.tintColor = movie.isFavorite ? .systemRed : .gray
    }
    
    @IBAction func favoriteTapped(_ sender: UIButton) {
        guard var movie = movie else { return }
        movie.isFavorite.toggle()
        self.movie = movie
        updateFavoriteButton()
        onFavoriteChanged?(movie.isFavorite)
    }
}
