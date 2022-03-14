//
//  MovieSearchViewController.swift
//  MovieResearchApp
//
//  Created by Kürşat Şimşek on 7.03.2022.
//

import UIKit
import Moya

class MovieSearchVC: BaseViewController {
    
    @IBOutlet weak var movieSearchBar: UISearchBar!
    @IBOutlet weak var movieSearchTableView: UITableView!
    var moviesArray = [Movie]()
    let movieProvider = MoyaProvider<API>()
    let searchTxt = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibMovie = UINib(nibName: "MovieTableViewCell", bundle: nil)
        movieSearchTableView.register(nibMovie, forCellReuseIdentifier: "MovieTableViewCellID")
        
        searchMovie(searchText: "matrix")
    }
}

// Methods
extension MovieSearchVC {
    func searchMovie(searchText: String) {
        NetworkManager.provider().request(.searchMovie("matrix")) { response in
            switch response {
            case .success(let movieResponse):
                if movieResponse.statusCode == 200 {
                    do {
                        let decoder = JSONDecoder()
                        let movie = try decoder.decode(Movies.self, from: movieResponse.data)
                        if movie.response != "False" {
                            guard let movies = movie.movies else { return }
                            self.moviesArray = movies
                            self.movieSearchTableView.reloadData()
                        } else {
                            // alert
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            
            }
        }
    }
}


extension MovieSearchVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCellID", for: indexPath) as! MovieTableViewCell
        let movie = moviesArray[indexPath.row]
       
        cell.setCell(movie: movie)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! MovieTableViewCell
        // getMovie buradan tetiklenecek.
    }
    
    
}


extension MovieSearchVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 2 {
            self.searchMovie(searchText: searchText)
        }
    }
}
