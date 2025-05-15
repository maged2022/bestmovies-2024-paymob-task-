//
//  ViewController.swift
//  BestMovies
//
//  Created by maged on 15/05/2025.
//

import UIKit

import UIKit

class MovieListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var movies: [Movie] = [
        Movie(id: 1, title: "Dune: Part Two", posterName: "poster-1", voteAverage: 8.5, releaseDate: "2024-03-01", isFavorite: false),
        Movie(id: 2, title: "Oppenheimer", posterName: "poster-2", voteAverage: 9.0, releaseDate: "2024-01-20", isFavorite: false),
        Movie(id: 3, title: "Barbie", posterName: "poster-3", voteAverage: 3.8, releaseDate: "2024-07-21", isFavorite: false),
        Movie(id: 4, title: "Troy", posterName: "poster-4", voteAverage: 9.8, releaseDate: "2022-04-21", isFavorite: false),
        Movie(id: 5, title: "Barbie", posterName: "poster-5", voteAverage: 7.8, releaseDate: "2025-07-21", isFavorite: false),
        Movie(id: 3, title: "Barbie", posterName: "poster-3", voteAverage: 3.8, releaseDate: "2024-07-21", isFavorite: false),
        Movie(id: 4, title: "Troy", posterName: "poster-4", voteAverage: 9.8, releaseDate: "2022-04-21", isFavorite: false),
        Movie(id: 5, title: "Barbie", posterName: "poster-5", voteAverage: 7.8, releaseDate: "2025-07-21", isFavorite: false),
        Movie(id: 3, title: "Barbie", posterName: "poster-3", voteAverage: 3.8, releaseDate: "2024-07-21", isFavorite: false),
        Movie(id: 4, title: "Troy", posterName: "poster-4", voteAverage: 9.8, releaseDate: "2022-04-21", isFavorite: false),
        Movie(id: 5, title: "Barbie", posterName: "poster-5", voteAverage: 7.8, releaseDate: "2025-07-21", isFavorite: false),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        let nib = UINib(nibName: "MovieListCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "MovieListCell")
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 250
    }
}

// MARK: -UITableViewDataSource ,UITableViewDelegate
extension MovieListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListCell", for: indexPath) as? MovieListCell else {
            return UITableViewCell()
        }
        let movie = movies[indexPath.row]
        cell.configure(with: movie)
        cell.onFavoriteTapped = { [weak self] in
            self?.movies[indexPath.row].isFavorite.toggle()
            self?.tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160 // أو أي ارتفاع يناسبك
    }
}
