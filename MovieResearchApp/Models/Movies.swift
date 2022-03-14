//
//  Movies.swift
//  MovieResearchApp
//
//  Created by Kürşat Şimşek on 13.03.2022.
//

import Foundation

struct Movies: Codable {
    let movies: [Movie]?
    let totalResults: String?
    let response: String
    let error: String?

    private enum CodingKeys: String, CodingKey {
        case movies = "Search"
        case totalResults
        case response = "Response"
        case error = "Error"
    }
}
