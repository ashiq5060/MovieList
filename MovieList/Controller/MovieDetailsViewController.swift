//
//  MovieDetailsViewController.swift
//  MovieList
//
//  Created by Ashiq on 14/03/24.
//

import UIKit
import CoreData

class MovieDetailsViewController: UIViewController {
    
    var movie : Movie?
    var isFavorite = false
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var TxtViewOverview: UITextView!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblReleaseDate: UILabel!
    @IBOutlet weak var btnFavorite: UIButton!
    @IBOutlet weak var imgPoster: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        configureUI()
        checkFavoriteStatus()
    }
    
    private func checkFavoriteStatus() {
        guard let movie = movie else {
            return
        }
        
        let favoriteMovies = CoreDataManager.shared.fetchFavoriteMovies()
        isFavorite = favoriteMovies.contains(where: { $0.id == Int64(movie.id) })
        updateFavoriteButtonUI()
    }
    
    private func updateFavoriteButtonUI() {
        let config = UIImage.SymbolConfiguration(weight: .regular)
        let heartImage = UIImage(systemName: isFavorite ? "heart.fill" : "heart", withConfiguration: config)
        btnFavorite.setImage(heartImage, for: .normal)
        btnFavorite.tintColor = isFavorite ? .red : .gray
    }
    
    
    private func configureUI() {
        guard let movie = movie else {
            return
        }
        
        lblTitle.text = movie.title
        TxtViewOverview.text = movie.overview
        lblReleaseDate.text = "Release Date: \(movie.releaseDate)"
        lblRating.text = "Rating: \(String(movie.voteAverage))"
        
        if let posterPath = movie.posterPath {
            let posterURL = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
            imgPoster.loadImageFromURL(posterURL)
        } else {
            imgPoster.image = nil
        }
    }
    
    @IBAction func btnDismiss(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btnActionFavorite(_ sender: UIButton) {
        isFavorite.toggle()
        updateFavoriteButtonUI()
        
        if isFavorite {
            saveFavoriteMovie()
        } else {
            removeFavoriteMovie()
        }
    }
    
    private func saveFavoriteMovie() {
        guard let movie = movie else {
            return
        }
        
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let favoriteMovie = FavoriteMovie(context: context)
        favoriteMovie.id = Int64(movie.id)
        favoriteMovie.title = movie.title
        favoriteMovie.overview = movie.overview
        favoriteMovie.releaseDate = movie.releaseDate
        favoriteMovie.voteAverage = movie.voteAverage
        favoriteMovie.posterPath = movie.posterPath
        
        CoreDataManager.shared.saveContext()
    }
    
    private func removeFavoriteMovie() {
        guard let movie = movie else {
            return
        }
        
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<FavoriteMovie> = FavoriteMovie.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", movie.id)
        
        do {
            let results = try context.fetch(fetchRequest)
            if let favoriteMovie = results.first {
                context.delete(favoriteMovie)
                CoreDataManager.shared.saveContext()
            }
        } catch {
            print("Failed to remove favorite movie: \(error)")
        }
    }
}


