//
//  ListCountriesPresenter.swift
//  CovidApp
//
//  Created by Irakli on 9/26/20.
//  Copyright © 2020 Irakli Shelia. All rights reserved.
//

import Foundation

protocol ListCountriesView: class {
    func refreshCountriesView()
}

protocol ListCountriesPresenter {
    var numberOfCountries: Int { get }
    var router: ListCountriesRouter { get }
    func viewDidLoad()
    func didSelect(row: Int)
}


class ListCountriesPresenterImpl: ListCountriesPresenter {
    private weak var view: ListCountriesView?
    private let displayCountriesListUseCase: DisplayCountriesListUseCase
    internal let router: ListCountriesRouter //FIXME private
    
    private var countries = [Country]()
    
    var numberOfCountries: Int {
        return countries.count
    }
    
    init(view: ListCountriesView,
         displayCountriesListUseCase: DisplayCountriesListUseCase,
         router: ListCountriesRouter) {
        self.view = view
        self.displayCountriesListUseCase = displayCountriesListUseCase
        self.router = router
    }
    
    func viewDidLoad() {
        
    }
    
    func didSelect(row: Int) {
        
    }
    
    
}
