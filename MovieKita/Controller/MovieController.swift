//
//  ViewController.swift
//  MovieKita
//
//  Created by Rizal on 18/03/2021.
//  Copyright © 2021 Rizal. All rights reserved.
//

import UIKit

class MovieViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var categoryHeaderLabel: UILabel!
    
    
    private var viewModel = MovieViewModel()
    private var movieData = [MovieData]()
    
    var pickerData:[String] = ["Top Rated", "Now Playing", "Popular", "Upcoming"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.picker.delegate = self
        self.picker.dataSource = self
        
        loadTopRatedMoviesData()
    }
    
    // MARK: - STILL PROBLEMATIC!
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "movieDetailSegue",
           let nextScene = segue.destination as? MovieDetailViewController ,
            let indexPath = self.tableView.indexPathForSelectedRow {
     
            guard self.movieData.count > indexPath.row else {
                   print("Index out of range")
                   return
               }
            let selectedMovie =  self.movieData[indexPath.row]
            print("selectedMovie", selectedMovie)
            print("movieData: ", self.movieData)
            nextScene.movieId = selectedMovie.id!
        }
    }
    
    @IBAction func unwindToMovieViewController(_ unwindSegue: UIStoryboardSegue) {
        // We can just leave this blank to unwind from MovieDetailViewController
        // Use data from the view controller which initiated the unwind segue
    }
    
    // Number of rows or number of components
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    // number of rows that we have to set
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }

    // set title in pickerView according to the elements
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    var selectedCategory:String = "Top Rated"
    {
        // property observers to watch changes of selectedCategory
        didSet
        {
            if selectedCategory == "Top Rated"
            {
                loadTopRatedMoviesData()
            }
            else if selectedCategory == "Popular"
            {
                loadPopularMoviesData()
            }
            else if selectedCategory == "Now Playing"
            {
                loadNowPlayingMoviesData()
            }
        }
    }
    
    // when an element is selected, store in a string
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectedCategory = pickerData[row]
        
        // make categoryHeaderLabel responsive
        if selectedCategory == "Top Rated" {
            categoryHeaderLabel.text = "Top Rated Movie"
        } else if selectedCategory == "Now Playing" {
            categoryHeaderLabel.text = "Now Playing"
        } else if selectedCategory == "Popular" {
            categoryHeaderLabel.text = "Popular Movies"
        } else {
            categoryHeaderLabel.text = "Upcoming Movies"
        }
    }

    // MARK: - Call a fetch method and update the tableView
    private func loadTopRatedMoviesData() {
        viewModel.getTopRatedMoviesData { [weak self] in
            self?.tableView.dataSource = self
            self?.tableView.reloadData()
            
        }
    }
    
    private func loadPopularMoviesData() {
        viewModel.getPopularMoviesData { [weak self] in
            self?.tableView.dataSource = self
            self?.tableView.reloadData()
        }
    }
    
    private func loadNowPlayingMoviesData() {
        viewModel.getNowPlayingMoviesData { [weak self] in
            self?.tableView.dataSource = self
            self?.tableView.reloadData()
        }
    }
}

// TableView setting
extension MovieViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsEachSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieTableViewCell
        
        let movie = viewModel.cellForRowAt(indexPath: indexPath)
        cell.setCellWithValues(movie)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        performSegue(withIdentifier: "MovieDetail", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

