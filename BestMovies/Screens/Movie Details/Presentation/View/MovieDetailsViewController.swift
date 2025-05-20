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
    
    var viewModel: MovieDetailsViewModelProtocol!
    weak var delegate: MovieDetailsViewControllerDelegate?
    weak var coordinator: MovieDetailsTransitionsDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = "Details"
        setupUI()
        setupBackButton()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func bindViewModel() {
        if let vm = viewModel as? MovieDetailsViewModel {
            vm.onFavoriteToggled = { [weak self] updatedMovie in
                guard let self = self else { return }
                self.delegate?.movieDetailsViewController(self, didUpdateFavoriteStatusFor: updatedMovie)
                self.updateFavoriteIcon(isFavorite: updatedMovie.isFavorite == true)
            }
        }
    }
    
    private func setupUI() {
        titleLabel.text = viewModel.titleText
        ratingLabel.text = viewModel.ratingText
        releaseDateLabel.text = viewModel.releaseDateText
        overviewLabel.text = viewModel.overviewText
        languageLabel.text = viewModel.languageText
        updateFavoriteIcon(isFavorite: viewModel.isFavorite)
        ImageLoader.shared.loadImage(from: viewModel.posterURL, into: posterImageView)
    }
    
    private func updateFavoriteIcon(isFavorite: Bool) {
        let imageName = isFavorite ? "heart.fill" : "heart"
        favoriteButton.setImage(UIImage(systemName: imageName), for: .normal)
        favoriteButton.tintColor = isFavorite ? .systemRed : .gray
    }
    
    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        viewModel.toggleFavorite()
    }
    
    private func setupBackButton() {
        let backImage = UIImage(systemName: "chevron.backward")?.withConfiguration(
            UIImage.SymbolConfiguration(pointSize: 18, weight: .medium)
        )
        let backButton = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(backButtonTapped))
        backButton.tintColor = .darkText
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc private func backButtonTapped() {
        coordinator?.backToMovieList()
    }
}

