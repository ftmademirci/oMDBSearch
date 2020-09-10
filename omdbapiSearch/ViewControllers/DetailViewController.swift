//
//  DetailViewController.swift
//  omdbapi
//
//  Created by Fatma Demirci on 8.09.2020.
//  Copyright © 2020 fatma.demirci. All rights reserved.
//

import UIKit
import FirebaseAnalytics
import Hero

class DetailViewController: BaseViewController {
        
    var viewModel: DetailViewModel!
    
    @IBOutlet var movie_poster_image: UIImageView!
    @IBOutlet var movie_title: UILabel!
    @IBOutlet var movie_genre: UILabel!
    @IBOutlet var movie_imdb_rating: UILabel!
    @IBOutlet var movie_director: UILabel!
    @IBOutlet var movie_actors: UILabel!
    @IBOutlet var movie_plot: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setBasicData()
        
        self.getData()
        
        Analytics.logEvent("movie_detail", parameters: [
        "title": self.viewModel.movie!.Title! as NSObject,
        "imdb_id": self.viewModel.movie!.imdbID! as NSObject
        ])
    }
    
    func setBasicData() {
        let postersURL = self.viewModel.movie?.Poster?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        self.movie_poster_image.sd_setImage(with: URL(string: postersURL!))
        
        self.movie_title.text = self.viewModel.movie?.Title
    }
    
    func getData() {
        if let imdbID = self.viewModel.movie?.imdbID {
            viewModel.getDetail(imdbID: imdbID, success: {
                self.movie_genre.text = self.viewModel.movie?.Genre
                self.movie_imdb_rating.text = "IMDb \(self.viewModel.movie?.imdbRating ?? "" )"
                self.movie_director.text = "Director: \(self.viewModel.movie?.Director ?? "")"
                self.movie_actors.text = "Actors: \(self.viewModel.movie?.Actors ?? "")"
                self.movie_plot.text = self.viewModel.movie?.Plot
            }) { (error) in
                
            }
        }
    }
    

}
