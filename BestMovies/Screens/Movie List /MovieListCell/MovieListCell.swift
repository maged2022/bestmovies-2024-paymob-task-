//
//  MovieListCell.swift
//  BestMovies
//
//  Created by maged on 15/05/2025.
//

struct Movie {
    let id: Int
    let title: String
    let posterName: String
    let voteAverage: Double
    let releaseDate: String
    var isFavorite: Bool
}
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
        posterImageView.image = UIImage(named: movie.posterName)
        titleLabel.text = movie.title
        ratingLabel.text = "⭐️ \(movie.voteAverage)/10"
        releaseDateLabel.text = "📅 \(movie.releaseDate)"
        isFavorite = movie.isFavorite
        updateFavoriteIcon()
    }
    
    @objc private func favoriteTapped() {
        isFavorite.toggle()
        updateFavoriteIcon()
        onFavoriteTapped?()
    }
    
    private func updateFavoriteIcon() {
        let imageName = isFavorite ? "heart.fill" : "heart"
        favoriteButton.setImage(UIImage(systemName: imageName), for: .normal)
        favoriteButton.tintColor = isFavorite ? .systemRed : .gray
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
