//
//  MovieDetailViewController.swift
//  MovieKita
//
//  Created by Rizal on 20/03/2021.
//  Copyright © 2021 Rizal. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var detailTableView: UITableView!
    
    private var viewModel = MovieViewModel()
    
    var movieId: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("selected movieId: ", movieId)
        loadDetailMovieData(id: movieId)
    }
    
    // MARK: - Call a fetch method and update the detailTableView
    private func loadDetailMovieData(id: Int) {
        viewModel.getMovieData(id: id) { [weak self] in
            self?.detailTableView.dataSource = self
            self?.detailTableView.reloadData()
        }
    }

}

// TableView setting
extension MovieDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsEachSection(section: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let detailCell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! MovieDetailTableViewCell

        let movie = viewModel.cellForRowAt(indexPath: indexPath)
        detailCell.setCellWithValues(movie)

        return detailCell
    }
}
