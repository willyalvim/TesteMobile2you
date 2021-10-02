//
//  MovieTableViewCell.swift
//  TesteMobile2you
//
//  Created by Willy Alvim on 29/09/21.
//

import UIKit
import SDWebImage


final class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var posterImageView: UIImageView!
    @IBOutlet weak private var yearLabel: UILabel!
    @IBOutlet weak private var genresLabel: UILabel!
    
    
    func setUp(movie: Movie) {
        titleLabel.text =  movie.title
        yearLabel.text = formatDate(from: movie.releaseDate)
        genresLabel.text = movie.genres?.compactMap({ $0.name }).joined(separator: ", ")
        posterImageView.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/original/\(movie.backdropPath)")!, completed: nil)
    }
    
    private func formatDate(from date: String) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-dd-mm"
            dateFormatter.locale = Locale.init(identifier: "pt-br")
            let releaseDate = dateFormatter.date(from: date)!
            
            let formatter1 = DateFormatter()
            formatter1.dateFormat = "yyyy"
            return formatter1.string(from: releaseDate)
        }
}


