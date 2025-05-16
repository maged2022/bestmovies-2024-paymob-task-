//
//  MovieDetailsViewController.swift
//  BestMovies
//
//  Created by maged on 15/05/2025.
//


// MARK: - 6. MovieDetailsViewController.swift

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
        
        if let posterPath = movie.posterPath {
            let fullURL = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
            if let url = fullURL {
                URLSession.shared.dataTask(with: url) { data, _, _ in
                    if let data = data {
                        DispatchQueue.main.async {
                            self.posterImageView.image = UIImage(data: data)
                        }
                    }
                }.resume()
            }
        }
    }
}
