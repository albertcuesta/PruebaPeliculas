//
//  tablecell.swift
//  PruebaPeliculas
//
//  Created by Albert on 28/5/21.
//

import UIKit

class tablecell : UITableViewCell {
    
    @IBOutlet weak var tituloPelicula: UILabel!
    @IBOutlet weak var imagenPelicula: UIImageView!
    @IBOutlet weak var descripcionPelicula: UILabel!
    @IBOutlet weak var votacionPelicula: UILabel!
    private var urlString: String = ""

    // Setup movies values
    func setCellWithValuesOf(_ movie:Movie) {
        updateUI(title: movie.title,rating: movie.rate, overview: movie.overview, poster: movie.posterImage)
    }
    
    // Update the UI Views
    private func updateUI(title: String?,rating: Double?, overview: String?, poster: String?) {
        
        self.tituloPelicula.text = title
        guard let rate = rating else {return}
        self.votacionPelicula.text = String(rate)
        self.descripcionPelicula.text = overview
        
        guard let posterString = poster else {return}
        urlString = "https://image.tmdb.org/t/p/w300" + posterString
        
        guard let posterImageURL = URL(string: urlString) else {
            self.imagenPelicula.image = UIImage(named: "noImageAvailable")
            return
        }
        
        // Before we download the image we clear out the old one
        self.imagenPelicula.image = nil
        
        getImageDataFrom(url: posterImageURL)
        
    }
    
    // MARK: - Get image data
    private func getImageDataFrom(url: URL) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            // Handle Error
            if let error = error {
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                // Handle Empty Data
                print("Empty Data")
                return
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    self.imagenPelicula.image = image
                }
            }
        }.resume()
    }
    
}
