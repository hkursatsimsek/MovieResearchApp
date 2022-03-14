//
//  MovieDetail.swift
//  MovieResearchApp
//
//  Created by Kürşat Şimşek on 13.03.2022.
//

import Foundation

struct MovieDetail: Codable {
    let response: String
    let title: String
    let year: String
    let imdbID: String
    let type: String
    let poster: String
    let runtime: String
    let released: String
    let genre: String
    let director: String
    let actors: String
    let writer: String
    let plot: String
    let awards: String
    let language: String
    let metascore: String
    let imdbRating: String

    private enum CodingKeys: String, CodingKey {
        case response = "Response"
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
        case runtime = "Runtime"
        case released = "Released"
        case genre = "Genre"
        case director = "Director"
        case actors = "Actors"
        case writer = "Writer"
        case plot = "Plot"
        case awards = "Awards"
        case language = "Language"
        case metascore = "Metascore"
        case imdbRating
    }
}
