//
//  SearchViewController.swift
//  Weather
//
//  Created by Дарина Самохина on 24.03.2025.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var delegate: SearchViewControllerDelegate?
    private var searchResults: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    @IBAction func downButtonDidPressed() {
        dismiss(animated: true)
    }
}

//MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        LocalSearchManager.shared.search(text: searchText) { [weak self] results in
            self?.searchResults = results.map {
                !$0.subtitle.isEmpty ?
                "\($0.title), \($0.subtitle)"
                : "\($0.title)"
            }
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}

//MARK: - UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let searchResult = searchResults[indexPath.row]
        content.text = searchResult
        content.textProperties.color = .white
        cell.contentConfiguration = content
        return cell
    }
}

//MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let searchResult = searchResults[indexPath.row]
        delegate?.displayLocationValue(from: searchResult)
        dismiss(animated: true)
    }
}
