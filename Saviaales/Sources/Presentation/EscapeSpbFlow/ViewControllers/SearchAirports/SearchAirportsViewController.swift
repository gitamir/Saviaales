//
//  SearchAirportsViewController.swift
//  Saviaales
//
//  Created by Amir Nuriev on 24.10.2020.
//  Copyright © 2020 Amir Nuriev. All rights reserved.
//

import UIKit

class SearchAirportsViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    struct Input {
        let lastUsedIATA: String?
        let searchAirports: (_ searchText: String, _ completion: @escaping (Result<[Airport], NetworkError>) -> Void) -> Void
    }

    struct Output {
        let selectAirport: (Airport) -> Void
    }

    var input: Input!
    var output: Output!

    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var searchBar: UISearchBar!
    @IBOutlet private var nothingFoundView: UIView!
    @IBOutlet private var nothingFoundLabel: UILabel!
    private let keyboardBehavior: KeyboardBehavior = .init()
    private let debouncer: Debouncer = .init(timeInterval: 0.3, queue: .main)
    private var airports: [Airport] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        keyboardBehavior.subscribe()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        keyboardBehavior.unsubscribe()
    }

    private func setupUI() {
        title = "search_title".localized
        view.backgroundColor = Style.Color.themeBlue
        searchBar.tintColor = Style.Color.themeBlue
        searchBar.placeholder = "search_placeholder".localized
        nothingFoundLabel.font = Style.Font.searchAirportInfoHeaderText
        nothingFoundLabel.text = "search_nothing_found".localized
        nothingFoundView.isHidden = true
        AirportSearchTableViewCell.registerNib(in: tableView)
        tableView.separatorStyle = .singleLine
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 102
        searchBar.text = input.lastUsedIATA
        searchText(input.lastUsedIATA)
        keyboardBehavior.animations = { [weak self] frame, _, _ in
            guard let self = self else { return }

            self.tableView.contentInset.bottom = frame.size.height
            self.view.layoutIfNeeded()
        }
    }

    private func updateUI() {
        nothingFoundView.isHidden = !airports.isEmpty
        tableView.reloadData()
    }

    private func searchTextDebounced(_ text: String?) {
        debouncer.debounce { [weak self] in
            self?.searchText(text)
        }
    }

    private func searchText(_ text: String?) {
        input.searchAirports(text ?? "") { [weak self] result in
            guard let self = self else { return }

            switch result {
                case .success(let airports):
                    self.airports = airports
                case .failure(let error):
                    self.airports = []
                    self.showAlert(withTitle: nil, message: error.localizedDescription, completion: nil)
            }
            self.updateUI()
        }
    }

    // MARK: - UISearchBarDelegate

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchTextDebounced(searchText)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        searchBar.setShowsCancelButton(false, animated: true)
    }


    // MARK: - UITableViewDelegate, UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        airports.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = AirportSearchTableViewCell.dequeue(from: tableView, for: indexPath)
        cell.update(with: airports[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        output.selectAirport(airports[indexPath.row])
    }
}
