//
//  ViewController.swift
//  BestMovies
//
//  Created by maged on 15/05/2025.
//

import UIKit
import Combine

class MovieListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel = MovieListViewModel(movieUseCase: MovieUseCase())
    private var cancellables = Set<AnyCancellable>()
    weak var coordinator: MovieListTransitionsDelegate?
    private var selectedYear: String = "2024"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        bindViewModel()
        viewModel.fetchMovies(for: selectedYear)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Set the navigation title and prefer large titles
        navigationItem.title = "Best Movies \(selectedYear)"
        navigationItem.largeTitleDisplayMode = .always
        
        // Force the navigation bar to re-layout after popping from the detail screen
        DispatchQueue.main.async {
            self.navigationController?.navigationBar.prefersLargeTitles = true
            self.navigationController?.navigationBar.sizeToFit()
        }
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        let nib = UINib(nibName: "MovieListCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "MovieListCell")
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 250
    }
    
    private func bindViewModel() {
        viewModel.$movies
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
        
        viewModel.$errorMessage
            .compactMap { $0 }
            .sink { [weak self] message in
                self?.showAlert(message: message)
            }
            .store(in: &cancellables)
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension MovieListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListCell", for: indexPath) as? MovieListCell else {
            return UITableViewCell()
        }
        let movie = viewModel.movies[indexPath.row]
        cell.configure(with: movie)
        cell.onFavoriteTapped = { [weak self] in
            self?.viewModel.toggleFavorite(for: indexPath.row)
            self?.tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = viewModel.movies[indexPath.row]
        coordinator?.gotoMovieDetails(movie: movie)
        print("✅ didSelectRowAt Tapped from: Movie List ViewController")
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
}

// MARK: - MovieDetailsViewControllerDelegate
extension MovieListViewController: MovieDetailsViewControllerDelegate {
    func movieDetailsViewController(_ controller: MovieDetailsViewController, didUpdateFavoriteStatusFor movie: Movie) {
        viewModel.updateMovie(movie)
        tableView.reloadData()
    }
}
