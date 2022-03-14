//
//  MovieSearchViewController.swift
//  MovieResearchApp
//
//  Created by Kürşat Şimşek on 7.03.2022.
//

import UIKit
import Moya

class MovieSearchVC: BaseViewController {
    
    //MARK: Outlets
    @IBOutlet weak var movieSearchBar: UISearchBar!
    @IBOutlet weak var movieSearchTableView: UITableView!
    
    //MARK: Parameters
    var moviesArray = [Movie]()
    let movieProvider = MoyaProvider<API>()
    let searchTxt = ""
    var pageIndex = 1
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibMovie = UINib(nibName: "MovieTableViewCell", bundle: nil)
        movieSearchTableView.register(nibMovie, forCellReuseIdentifier: "MovieTableViewCellID")
        
//        searchMovie(searchText: "matrix")
    }
}

//MARK: Methods
extension MovieSearchVC {
    /// Resets movie search and make the list ready for another.
    private func resetMovieSearch() {
        pageIndex = 1
        moviesArray.removeAll()
        moviesArray = [Movie]()
    }
    
    /// Search trigger.
    @objc func search() {
        if searchTxt.trimmingCharacters(in: .whitespaces).count != 0 {
            searchMovie(searchText: searchTxt)
        }
    }
    
    /// Request movies with a given search text.
    func searchMovie(searchText: String) {
        if pageIndex == 1 {
            Loading.show()
        }
        
        NetworkManager.provider().request(
            .searchMovie(searchText, pageIndex)) { [weak self] response in
            Loading.hide()
            guard let strongSelf = self else { return }
            switch response {
            case .success(let moviesResponse):
                if moviesResponse.statusCode == 200 {
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(Movies.self, from: moviesResponse.data)
                        if result.response == "False" {
                            strongSelf.movieSearchTableView.reloadData()
                            if strongSelf.pageIndex == 1, strongSelf.searchTxt != "" {
                                let alertController = UIAlertController(title: "Warning", message: "No result found.", preferredStyle: UIAlertController.Style.alert)
                                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                                strongSelf.present(alertController, animated: true, completion: nil)
                            }
                            return
                        }
                        
                        guard let movies = result.movies else { return }
                        if strongSelf.pageIndex == 1 {
                            strongSelf.moviesArray = movies
                        } else {
                            strongSelf.moviesArray.append(contentsOf: movies)
                        }
                        strongSelf.movieSearchTableView.reloadData()
                    } catch {
                        print(error.localizedDescription)
                    }
                } else {
                    print("Error: \(moviesResponse.statusCode)")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    /// Request movie with a given by id.
    private func getMovie(by id: String, _ indexPath: IndexPath) {
        Loading.show()
        NetworkManager.provider().request(.getMovie(id)) { response in
            Loading.hide()
            switch response {
            case .success(let movieResponse):
                if movieResponse.statusCode == 200 {
                    do {
                        let decoder = JSONDecoder()
                        let movie = try decoder.decode(MovieDetail.self, from: movieResponse.data)
                        if let dest = UIStoryboard(name: "MovieDetail", bundle: nil)
                           .instantiateViewController(withIdentifier: "moviedetailstrid") as? MovieDetailVC {
                            dest.movie = movie
                            dest.modalPresentationStyle = .overCurrentContext
                            dest.modalTransitionStyle = .crossDissolve
                            self.navigationController?.pushViewController(dest, animated: true)
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                } else {
                    print("Error: \(movieResponse.statusCode)")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: - Table View Datasource Delegate
extension MovieSearchVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesArray.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCellID", for: indexPath) as! MovieTableViewCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        if moviesArray.count > indexPath.row {
            let movie = moviesArray[indexPath.row]
            cell.setCell(movie: movie)
        }
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! MovieTableViewCell
        if moviesArray.count > indexPath.row {
            let movieImdbId = moviesArray[indexPath.row].imdbID
            getMovie(by: movieImdbId, indexPath)
        }
    }
    
    
}

// MARK: - Searchbar Delegate
extension MovieSearchVC: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 2 {
            self.searchMovie(searchText: searchText)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
}
