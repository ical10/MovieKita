//
//  MovieView.swift
//  MovieKita
//
//  Created by Rizal on 19/03/2021.
//  Copyright © 2021 Rizal. All rights reserved.
//

import Foundation

class MovieViewModel {
    private var movieApi = MovieApi()
    private var topRatedMovies = [Movie]()
    
    func getTopRatedMoviesData(completion: @escaping () -> ()) {
        
        movieApi.fetchTopRatedMoviesData { [weak self] (result) in
            
            switch result {
            case .success (let list):
                self?.topRatedMovies = list.movies
                completion()
            case .failure(let error):
                print("Error while processing JSON data: \(error)")
            }
            
        }
        
    }
    
    func numberOfRowsEachSection (section: Int) -> Int {
        if topRatedMovies.count != 0 {
            return topRatedMovies.count
        }
        return 0
    }
    
    func cellForRowAt (indexPath: IndexPath) -> Movie {
        return topRatedMovies[indexPath.row]
    }
}
