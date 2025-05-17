//
//  KingfisherImageLoader.swift
//  BestMovies
//
//  Created by maged on 17/05/2025.
//

import UIKit
import Kingfisher

class KingfisherImageLoader: ImageLoaderProtocol {
    func loadImage(from urlString: String?, into imageView: UIImageView, placeholder: UIImage?) {
        guard let urlString = urlString,
              let url = URL(string: "https://image.tmdb.org/t/p/w500\(urlString)") else {
            DispatchQueue.main.async {
                imageView.image = placeholder
            }
            return
        }
        
        let options: KingfisherOptionsInfo = [
            .transition(.fade(0.25)),
            .cacheOriginalImage
        ]
        
        DispatchQueue.main.async {
            imageView.kf.indicatorType = .activity
            imageView.kf.setImage(with: url, placeholder: placeholder, options: options)
        }
    }
}
