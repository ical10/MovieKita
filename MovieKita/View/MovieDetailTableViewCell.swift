//
//  MovieDetailTableViewCell.swift
//  MovieKita
//
//  Created by Rizal on 21/03/2021.
//  Copyright © 2021 Rizal. All rights reserved.
//

import UIKit

class MovieDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieReleaseDate: UILabel!
    @IBOutlet weak var movieSynopsis: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var movieFavorite: UIImageView!
    
    private var stringURL: String = ""
    
    // Set movies values into cells
    func setCellWithValues(_ movie:MovieData) {
        updateUI(title: movie.title, releaseDate: movie.releaseDate, rating: movie.rate, synopsis: movie.synopsis, posterImg: movie.posterImg)
    }
    
    // UI Views update
    private func updateUI (title: String?, releaseDate: String?, rating: Double?, synopsis: String?, posterImg: String?) {
        
        self.movieTitle.text = title
        self.movieReleaseDate.text = dateFormatterFunc(releaseDate)
        
        guard let rate = rating else {return}
        self.movieRating.text = String(rate)
        
        self.movieSynopsis.text = synopsis
        
        guard let posterStringURL = posterImg else {return}
        stringURL = "https://image.tmdb.org/t/p/w300" + posterStringURL
        
        guard let posterImgURL = URL(string: stringURL) else {
            self.moviePoster.image = UIImage(named: "noImg")
            return
        }
        // Clear previous image before fetching new image data
        self.moviePoster.image = nil
        
        fetchImageDataFrom(url: posterImgURL)
    }
    
    private func fetchImageDataFrom(url: URL) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
//            Error handling
            if let error = error {
                print("Datatask error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("Data is empty")
                return
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    print("the data: ", data)
                    self.moviePoster.image = image
                }
            }
        }.resume()
    }
    
    // Date formatter
    func dateFormatterFunc(_ date: String?) -> String {
        var formattedDate = ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let rawDate = date {
            if let newDate = dateFormatter.date(from: rawDate) {
                dateFormatter.dateFormat = "dd MM yyyy"
                formattedDate = dateFormatter.string(from: newDate)
            }
        }
        return formattedDate
    }
}
