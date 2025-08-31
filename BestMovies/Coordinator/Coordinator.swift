//
//  Coordinator.swift
//  BestMovies
//
//  Created by maged on 17/05/2025.
//

import Foundation
// commit number 5
protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get }
    func start()
}
