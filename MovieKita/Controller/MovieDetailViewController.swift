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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Call a fetch method and update the detailTableView
    private func loadDetailMovieData() {
        viewModel.getMovieData(id: 527774) { [weak self] in
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
        let cell = detailTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieDetailTableViewCell
        
        let movie = viewModel.cellForRowAt(indexPath: indexPath)
        cell.setCellWithValues(movie)
        
        return cell
    }
}
