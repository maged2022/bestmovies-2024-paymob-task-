//
//  ImageLoader.swift
//  BestMovies
//
//  Created by maged on 17/05/2025.
//

import UIKit

class ImageLoader {
    static let shared = ImageLoader()
    
    // You can switch this to another loader easily
    private let loader: ImageLoaderProtocol = KingfisherImageLoader()
    
    private init() {}
    
    func loadImage(from urlString: String?, into imageView: UIImageView, placeholder: UIImage? = UIImage(systemName: "photo")) {
        loader.loadImage(from: urlString, into: imageView, placeholder: placeholder)
    }
}
