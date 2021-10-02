//
//  ViewController.swift
//  TesteMobile2you
//
//  Created by Willy Alvim on 29/09/21.
//

import UIKit
import SDWebImage
import Alamofire

final class ViewController: UIViewController {
    
    private var movies = [Movie]()
    private var currentMovie: Movie!{
        didSet{
            updateUI()
        }
    }
    
    @IBOutlet weak private var moviesTableView: UITableView!
    @IBOutlet weak private var coverImageView: UIImageView!
    @IBOutlet weak private var likedButton: UIButton!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var likedNumbers: UILabel!
    @IBOutlet weak private var popularityLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moviesTableView.dataSource = self
        moviesTableView.delegate = self
        getData{movieJson in
            self.currentMovie = movieJson
        }
        getSimilarMovies()
        
        let maskLayer = CAGradientLayer(layer: coverImageView.layer)
        maskLayer.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        maskLayer.startPoint = CGPoint(x: 0, y: 0)
        maskLayer.endPoint = CGPoint(x: 0, y: 1)
        maskLayer.frame = coverImageView.bounds
        coverImageView.layer.mask = maskLayer
    }
    
    @IBAction private func tappedButton(_ sender: UIButton) {
        if likedButton.tag == 0 {
            likedButton.setImage(UIImage(named: "unlikedHeart"), for: .normal)
            likedButton.tag = 1
            
        } else {
            likedButton.setImage(UIImage(named: "likedHeart"), for: .normal)
            likedButton.tag = 0
        }
    }
    
    
    
    func updateUI() {
        coverImageView.sd_setImage(with: URL(string: Constants.imageUrl(with: currentMovie.backdropPath))!, completed: nil)
        titleLabel.text = currentMovie.title
        likedNumbers.text = "\(currentMovie.voteCount) likes"
        popularityLabel.text = "\(currentMovie.popularity) views"
    }
    
    
    
}

// MARK: UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
}
// MARK: UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieTableViewCell
        
        cell.setUp(movie: movies[indexPath.row])
        
        
        return cell
    }
    
}
// MARK: API
extension ViewController {
    func getSimilarMovies() {
        AF.request(Constants.moviesSimilarsUrl).responseData { response in
            switch response.result {
            case .success(let data):
                let resultArray = try? JSONDecoder().decode(ResultArray.self, from: data)
                self.movies = resultArray?.results ?? []
                DispatchQueue.main.async {
                    self.moviesTableView.reloadData()
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                
            }
        }
    }
    
    func getData(onsuccess:@escaping (Movie?)-> Void) {
        AF.request(Constants.movieUrl).responseData { response in
            switch response.result {
            case .success(let data):
                let movieJson = try? JSONDecoder().decode(Movie.self, from: data)
                onsuccess(movieJson)
                
                
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                
            }
        }
    }
}
