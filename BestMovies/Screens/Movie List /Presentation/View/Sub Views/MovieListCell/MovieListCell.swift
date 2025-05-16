//
//  MovieListCell.swift
//  BestMovies
//
//  Created by maged on 15/05/2025.
//

import UIKit

class MovieListCell: UITableViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    private var isFavorite = false
    var onFavoriteTapped: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        favoriteButton.addTarget(self, action: #selector(favoriteTapped), for: .touchUpInside)
        posterImageView.layer.cornerRadius = 8
        posterImageView.clipsToBounds = true
    }
    
    func configure(with movie: Movie) {
        titleLabel.text = movie.title
        ratingLabel.text = "⭐️ \(movie.voteAverage)/10"
        releaseDateLabel.text = "📅 \(movie.releaseDate)"
        isFavorite = movie.isFavorite ?? false
        updateFavoriteIcon()
        
        if let posterPath = movie.posterPath {
            let fullURL = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
            if let url = fullURL {
                // Use URLSession or Kingfisher/SDWebImage for better performance
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
    
    @objc private func favoriteTapped() {
        isFavorite.toggle()
        updateFavoriteIcon()
        onFavoriteTapped?()
        print("✅ favorite button Tapped from: MovieListCell")
    }
    
    private func updateFavoriteIcon() {
        let imageName = isFavorite ? "heart.fill" : "heart"
        favoriteButton.setImage(UIImage(systemName: imageName), for: .normal)
        favoriteButton.tintColor = isFavorite ? .systemRed : .gray
    }
}
