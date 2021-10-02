//
//  Constantes.swift
//  TesteMobile2you
//
//  Created by Willy Alvim on 02/10/21.
//

import Foundation
class Constants {
    static let movieUrl = "\(domain)/3/movie/550?api_key=\(apiKey)&language=en-US"
    
    private static let apiKey = "ae05045f371b7ddfa24ef45846a99295"
    
    private static let domain = "https://api.themoviedb.org"
    
    static let moviesSimilarsUrl = "\(domain)/3/movie/550/similar?api_key=\(apiKey)&language=en-US&page=1"
    
    static func imageUrl(with backdropPath: String) -> String {
        return "https://image.tmdb.org/t/p/original/\(backdropPath)"
    }
}
