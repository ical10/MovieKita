//
//  ApiService.swift
//  MovieKita
//
//  Created by Rizal on 18/03/2021.
//  Copyright © 2021 Rizal. All rights reserved.
//

import Foundation

class MovieApi {
    
    private var dataTask: URLSessionDataTask?
    
    func fetchTopRatedMoviesData(completion: @escaping (Result<MoviesData, Error>) -> Void) {
        
        let topRatedMoviesURL =
        "https://api.themoviedb.org/3/movie/top_rated?api_key=b80057427a3fc4cac650805ce9860939&page=1&language=en-US"
        
        guard let url = URL(string: topRatedMoviesURL) else {
            return
        }
        
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // Error handling
            if let error = error {
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                // Empty response handling
                print("response empty")
                return
            }
            
            print("Response stat code: \(response.statusCode)")
            
            guard let data = data else {
                // empty data handling
                print("Empty data")
                return
            }
            
            do {
                // data parsing
                let decoder = JSONDecoder()
                let dataFromJSON = try decoder.decode(MoviesData.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(dataFromJSON))
                }
            } catch let error {
                completion (.failure(error))
            }
        }
        dataTask?.resume()
    }
    
    func fetchPopularMoviesData(completion: @escaping (Result<MoviesData, Error>) -> Void) {
        
        let popularMoviesURL =
        "https://api.themoviedb.org/3/movie/popular?api_key=b80057427a3fc4cac650805ce9860939&page=1&language=en-US"
        
        guard let url = URL(string: popularMoviesURL) else {
            return
        }
        
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // Error handling
            if let error = error {
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                // Empty response handling
                print("response empty")
                return
            }
            
            print("Response stat code: \(response.statusCode)")
            
            guard let data = data else {
                // empty data handling
                print("Empty data")
                return
            }
            
            do {
                // data parsing
                let decoder = JSONDecoder()
                let dataFromJSON = try decoder.decode(MoviesData.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(dataFromJSON))
                }
            } catch let error {
                completion (.failure(error))
            }
        }
        dataTask?.resume()
    }
    
    func fetchNowPlayingMoviesData(completion: @escaping (Result<MoviesData, Error>) -> Void) {
        
        let nowPlayingMoviesURL =
        "https://api.themoviedb.org/3/movie/now_playing?api_key=b80057427a3fc4cac650805ce9860939&page=1&language=en-US"
        
        guard let url = URL(string: nowPlayingMoviesURL) else {
            return
        }
        
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // Error handling
            if let error = error {
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                // Empty response handling
                print("response empty")
                return
            }
            
            print("Response stat code: \(response.statusCode)")
            
            guard let data = data else {
                // empty data handling
                print("Empty data")
                return
            }
            
            do {
                // data parsing
                let decoder = JSONDecoder()
                let dataFromJSON = try decoder.decode(MoviesData.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(dataFromJSON))
                }
            } catch let error {
                completion (.failure(error))
            }
        }
        dataTask?.resume()
    }
    
    func fetchMovieData(id: Int, completion: @escaping (Result<MovieData, Error>) -> Void) {
        
        let movieURL =
        "https://api.themoviedb.org/3/movie/\(id)?api_key=b80057427a3fc4cac650805ce9860939&append_to_response=videos,credits"
        
        guard let url = URL(string: movieURL) else {
            return
        }
        
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // Error handling
            if let error = error {
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                // Empty response handling
                print("response empty")
                return
            }
            
            print("Response stat code: \(response.statusCode)")
            
            guard let data = data else {
                // empty data handling
                print("Empty data")
                return
            }
            
            do {
                // data parsing
                let decoder = JSONDecoder()
                let dataFromJSON = try decoder.decode(MovieData.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(dataFromJSON))
                }
            } catch let error {
                completion (.failure(error))
            }
        }
        dataTask?.resume()
    }
}
