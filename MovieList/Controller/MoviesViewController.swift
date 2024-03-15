//
//  MoviesViewController.swift
//  MovieList
//
//  Created by Ashiq on 14/03/24.
//

import UIKit

class MoviesViewController: UIViewController {
    
    private let movieService = MovieService()
    private var movies: [Movie] = []
    
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private let activityIndicatorView: UIActivityIndicatorView = {
            let activityIndicator = UIActivityIndicatorView(style: .large)
            activityIndicator.translatesAutoresizingMaskIntoConstraints = false
            return activityIndicator
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        setupActivityIndicatorView()
        fetchPopularMovies()
        
    }
    
    private func setupActivityIndicatorView() {
            view.addSubview(activityIndicatorView)
            
            NSLayoutConstraint.activate([
                activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        }
    
    private func fetchPopularMovies() {
        startActivityIndicator()
        movieService.fetchPopularMovies { [weak self] result in
            
            self?.stopActivityIndicator()
            switch result {
            case .success(let movies):
                self?.movies = movies
                print(movies)
                DispatchQueue.main.async {
                    self?.moviesCollectionView.reloadData()
                }
            case .failure(let error):
                print("Error fetching popular movies: \(error.localizedDescription)")
            }
        }
    }
    
    private func startActivityIndicator() {
            activityIndicatorView.startAnimating()
        }
        
        private func stopActivityIndicator() {
            DispatchQueue.main.async {
                self.activityIndicatorView.stopAnimating()
            }
            
        }
    
    @IBAction func btnFavoriteAction(_ sender: Any) {
        let FavoriteVC = storyboard?.instantiateViewController(withIdentifier: "favorites") as! FavoritesViewController
        navigationController?.pushViewController(FavoriteVC, animated: true)
        
    }
    
    
}

//MARK: Collection View Delegate and Data Source

extension MoviesViewController : UICollectionViewDelegate ,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoviesCell", for: indexPath) as! MoviesCell
        
        let movie = movies[indexPath.item]
        cell.configure(with: movie)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedMovie = movies[indexPath.item]
        let movieDetailsVC = storyboard?.instantiateViewController(withIdentifier: "MovieDetails") as! MovieDetailsViewController
        movieDetailsVC.movie = selectedMovie
        navigationController?.pushViewController(movieDetailsVC, animated: true)
    }
    
    
}

//MARK: UICollectionViewDelegateFlowLayout

extension MoviesViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = (collectionView.frame.width - 30 ) / 2
        let cellHeight = cellWidth * 1.5
        
        return CGSize(width: cellWidth , height: cellHeight)
        
    }
}

//MARK: Search Bar delegate

extension MoviesViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            searchBar.setShowsCancelButton(true, animated: true)
        }

        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
            searchBar.text = ""
            movies = Array(movieService.allMovies)
            moviesCollectionView.reloadData()
        }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            movies = Array(movieService.allMovies)
        } else {
            movies = movieService.allMovies.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        }
        
        moviesCollectionView.reloadData()
    }
}
