//
//  Movie.swift
//  MovieKita
//
//  Created by Rizal on 18/03/2021.
//  Copyright © 2021 Rizal. All rights reserved.
//

import Foundation

struct MoviesData: Decodable {
    let movies: [MovieData]
    
    private enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}

struct MovieData: Decodable {
    let title: String?
    let releaseDate: String?
    let rate: Double?
    let posterImg: String?
    let synopsis: String?
    
    private enum CodingKeys: String, CodingKey {
        case title
        case synopsis = "overview"
        case releaseDate = "release_date"
        case rate = "vote_average"
        case posterImg = "poster_path"
    }
}
