//
//  FavoritesViewController.swift
//  MovieList
//
//  Created by Ashiq on 15/03/24.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    private var movies: [FavoriteMovie] = []
    @IBOutlet weak var favoriteCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        fetchFavoriteMovies()
    }
    
    private func fetchFavoriteMovies() {
        movies = CoreDataManager.shared.fetchFavoriteMovies()
        favoriteCollectionView.reloadData()
        
    }
    
    
    @IBAction func btnDismiss(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    
}

//MARK: Collection View Delegate and Data Source

extension FavoritesViewController : UICollectionViewDelegate ,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoritesCell", for: indexPath) as! FavoritesCell
        let movie = movies[indexPath.item]
        cell.configure(with: movie)
        return cell
    }
}

//MARK: UICollectionViewDelegateFlowLayout

extension FavoritesViewController : UICollectionViewDelegateFlowLayout {
    
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
