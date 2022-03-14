//
//  Movie.swift
//  MovieResearchApp
//
//  Created by Kürşat Şimşek on 8.03.2022.
//

import Foundation

struct Movie: Codable {
    let imdbID: String
    let title: String
    let year: String
    let type: String
    let poster: String

    private enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }
}
