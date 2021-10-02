//
//  MoviesList.swift
//  TesteMobile2you
//
//  Created by Willy Alvim on 29/09/21.
//

import Foundation

struct Movie: Codable {
    var title: String
    var releaseDate: String
    var backdropPath: String
    var posterPath: String
    var isAdult: Bool
    var id: Int
    var genres: [Genre]?
    var popularity: Double
    var voteCount: Int
    
    
    enum CodingKeys: String, CodingKey {
        case title
        case releaseDate = "release_date"
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case isAdult = "adult"
        case id
        case genres
        case popularity
        case voteCount = "vote_count"
        
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        isAdult = try container.decode(Bool.self, forKey: .isAdult)
        backdropPath = try container.decode(String.self, forKey: .backdropPath)
        genres = try? container.decode([Genre].self, forKey: .genres)
        id = try container.decode(Int.self, forKey: .id)
        posterPath = try container.decode(String.self, forKey: .posterPath)
        releaseDate = try container.decode(String.self, forKey: .releaseDate)
        title = try container.decode(String.self, forKey: .title)
        popularity = try container.decode(Double.self, forKey: .popularity)
        voteCount = try container.decode(Int.self, forKey: .voteCount)
    }
}


struct ResultArray: Codable {
    let page: Int
    let results: [Movie]
    let totalPages, totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        page = try container.decode(Int.self, forKey: .page)
        results = try container.decode([Movie].self, forKey: .results)
        totalPages = try container.decode(Int.self, forKey: .totalPages)
        totalResults = try container.decode(Int.self, forKey: .totalResults)
    }
    
}
