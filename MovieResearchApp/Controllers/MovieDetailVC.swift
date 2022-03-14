//
//  MovieDetailVC.swift
//  MovieResearchApp
//
//  Created by Kürşat Şimşek on 14.03.2022.
//

import UIKit

class MovieDetailVC: UIViewController {
    //MARK: Parameters
    var movie: MovieDetail?
    var heroId: String!
    
    //MARK: Outlets
    @IBOutlet weak var moviePoster: ImageviewDownloader!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieIMDBRating: UILabel!
    @IBOutlet weak var movieTime: UILabel!
    @IBOutlet weak var movieDirector: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setUI()
    }

}

extension MovieDetailVC {
    func setUI() {
        if let movie = movie {
            moviePoster.getImage(urlString: movie.poster, placeholder: UIImage(named: "posterPlaceholder"))
            movieTitle.text = "\(movie.title) (\(movie.year))"
            movieIMDBRating.text = movie.imdbRating
            movieTime.text = movie.runtime
            movieDirector.text = "\(movie.director)"
        }
    }
}
