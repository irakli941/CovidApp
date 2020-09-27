//
//  CountryDetailsPresenter.swift
//  CovidApp
//
//  Created by Irakli on 9/26/20.
//  Copyright © 2020 Irakli Shelia. All rights reserved.
//

import Foundation

protocol CountryDetailsView: class {
    func refreshDetailsView()
}

protocol CountryDetailsPresenter {
    func viewDidLoad()
    var numberOfStats: Int { get }
    func configure(cell: CountryDetailCellView,
                   forRow row: Int)
}

class CountryDetailsPresenterImpl: CountryDetailsPresenter {
    
    let parameters: CountryDetailParameters
    private weak var view: CountryDetailsView?
    var numberOfStats: Int { return stats.count }
    
    private var stats:[(String, String)] = [] { didSet { view?.refreshDetailsView() } }
    
    init(parameters: CountryDetailParameters,
         view: CountryDetailsView) {
        self.parameters = parameters
        self.view = view
    }
    
    func viewDidLoad() {
        updateStats(for: parameters.country)
    }
    
    private func updateStats(for country: Country) {
        self.stats = country.displayableProperties()
    }
    
    func configure(cell: CountryDetailCellView, forRow row: Int) {
        let stat = stats[row]
        let viewModel = CountryDetailCellViewModel(stat: stat.0, quantity: stat.1)
        cell.configure(with: viewModel)
    }
}
