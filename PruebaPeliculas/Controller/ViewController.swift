//
//  ViewController.swift
//  PruebaPeliculas
//
//  Created by Albert on 28/5/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var table: UITableView!
    private var viewModel = MovieViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPopularMoviesData()
        // Do any additional setup after loading the view.
    }
    
    private func loadPopularMoviesData() {
        viewModel.fetchPopularMoviesData { [weak self] in
            self?.table.delegate = self
            self?.table.dataSource = self
            self?.table.reloadData()

        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! tablecell
        table.rowHeight = 148

        let movie = viewModel.cellForRowAt(indexPath: indexPath)
       
        cell.setCellWithValuesOf(movie)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = DetalleTablaView()
        let movie = viewModel.cellForRowAt(indexPath: indexPath)
        vc.setWithValuesOf(movie)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

