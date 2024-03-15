//
//  MovieService.swift
//  MovieList
//
//  Created by Ashiq on 15/03/24.
//

import Foundation

class MovieService {
    private let baseURL = "https://api.themoviedb.org/3"
    private let apiKey = "361fd448c8d8c55d235f774cc7fbd1e2" // TMDb API key
    var allMovies: [Movie] = []
    
    func fetchPopularMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        let url = URL(string: "\(baseURL)/movie/popular?api_key=\(apiKey)")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "com.example.app", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }
            
            do {
                let moviesResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
                self.allMovies = moviesResponse.results // Store fetched movies in allMovies
                completion(.success(moviesResponse.results))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
