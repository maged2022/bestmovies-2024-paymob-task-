//
//  ImageLoaderProtocol.swift
//  BestMovies
//
//  Created by maged on 17/05/2025.
//

import UIKit

protocol ImageLoaderProtocol {
    func loadImage(from urlString: String?, into imageView: UIImageView, placeholder: UIImage?)
}
