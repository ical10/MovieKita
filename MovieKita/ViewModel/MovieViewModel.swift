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
    private var moviesData = [MovieData]()
//    private var movieData = [MovieData]()
    
    func getTopRatedMoviesData(completion: @escaping () -> ()) {
        
        movieApi.fetchTopRatedMoviesData { [weak self] (result) in
            
            switch result {
            case .success (let list):
                self?.moviesData = list.movies
                completion()
            case .failure(let error):
                print("Error while processing JSON data: \(error)")
            }
        }
    }
    
    func getPopularMoviesData(completion: @escaping () -> ()) {
        
        movieApi.fetchPopularMoviesData { [weak self] (result) in
            
            switch result {
            case .success (let list):
                self?.moviesData = list.movies
                completion()
            case .failure(let error):
                print("Error while processing JSON data: \(error)")
            }
        }
    }
    
    func getNowPlayingMoviesData(completion: @escaping () -> ()) {
        
        movieApi.fetchNowPlayingMoviesData { [weak self] (result) in
            
            switch result {
            case .success (let list):
                self?.moviesData = list.movies
                completion()
            case .failure(let error):
                print("Error while processing JSON data: \(error)")
            }
        }
    }
    
    func getMovieData(id: Int, completion: @escaping () -> ()) {
        
        movieApi.fetchMovieData(id: id) { [weak self] (result) in
            
            switch result {
            case .success (let list):
//                print("this is the list: ", list.posterImg!)
                self?.moviesData = [list]
//                print(">>>", self?.moviesData)
                completion()
            case .failure(let error):
                print("Error while processing JSON data: \(error)")
            }
        }
    }
    
    func numberOfRowsEachSection (section: Int) -> Int {
        if moviesData.count != 0 {
            return moviesData.count
        }
        return 0
    }
    
    func cellForRowAt (indexPath: IndexPath) -> MovieData {
        return moviesData[indexPath.row]
    }
}
