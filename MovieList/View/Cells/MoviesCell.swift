//
//  MoviesCell.swift
//  MovieList
//
//  Created by Ashiq on 14/03/24.
//

import UIKit

class MoviesCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    
    func configure(with movie: Movie) {
        titleLabel.text = movie.title
        ratingLabel.text = "Rating: \(String(movie.voteAverage))"
        
        // Load and set the poster image
        if let posterPath = movie.posterPath {
            let posterURL = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
            posterImageView.loadImageFromURL(posterURL)
        } else {
            posterImageView.image = nil
        }
    }
}

extension UIImageView {
    func loadImageFromURL(_ url: URL?) {
        guard let url = url else {
            return
        }
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
