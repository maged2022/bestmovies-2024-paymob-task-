//
//  FavoriteMovieManager.swift
//  BestMovies
//
//  Created by maged on 17/05/2025.
//

import Foundation
import CoreData

class FavoriteMovieManager {
    private let context = CoreDataStack.shared.context
    
    func save(_ movie: Movie) {
        let entity = FavoriteMovie(context: context)
        entity.id = Int64(movie.id)
        entity.title = movie.title
        entity.posterPath = movie.posterPath
        entity.voteAverage = movie.voteAverage
        entity.releaseDate = movie.releaseDate
        entity.overview = movie.overview
        entity.originalLanguage = movie.originalLanguage
        CoreDataStack.shared.saveContext()
    }
    
    func fetchAll() -> [Movie] {
        let request: NSFetchRequest<FavoriteMovie> = FavoriteMovie.fetchRequest()
        do {
            let results = try context.fetch(request)
            return results.map {
                Movie(id: Int($0.id),
                      title: $0.title ?? "",
                      posterPath: $0.posterPath,
                      voteAverage: $0.voteAverage,
                      releaseDate: $0.releaseDate ?? "",
                      overview: $0.overview ?? "",
                      originalLanguage: $0.originalLanguage ?? "",
                      isFavorite: true)
            }
        } catch {
            print("❌ Fetch failed: \(error)")
            return []
        }
    }
    
    func delete(movieId: Int) {
        let request: NSFetchRequest<FavoriteMovie> = FavoriteMovie.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", movieId)
        do {
            let results = try context.fetch(request)
            results.forEach { context.delete($0) }
            CoreDataStack.shared.saveContext()
        } catch {
            print("❌ Delete failed: \(error)")
        }
    }
    
    func isFavorite(_ id: Int) -> Bool {
        let request: NSFetchRequest<FavoriteMovie> = FavoriteMovie.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", id)
        do {
            return try context.count(for: request) > 0
        } catch {
            return false
        }
    }
}
