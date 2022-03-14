//
//  MovieTableViewCell.swift
//  MovieResearchApp
//
//  Created by Kürşat Şimşek on 8.03.2022.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieType: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(movie:Movie) {
        movieTitle.text = movie.title
        movieType.text = movie.type
        // image cagırılacak
    }

}
