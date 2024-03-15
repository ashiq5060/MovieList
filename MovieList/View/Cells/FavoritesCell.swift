//
//  FavoritesCell.swift
//  MovieList
//
//  Created by Ashiq on 15/03/24.
//

import UIKit

class FavoritesCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    
    func configure(with movie: FavoriteMovie) {
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
