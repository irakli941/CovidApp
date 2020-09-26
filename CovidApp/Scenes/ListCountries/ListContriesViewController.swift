//
//  ListContriesViewController.swift
//  CovidApp
//
//  Created by Irakli on 9/26/20.
//  Copyright © 2020 Irakli Shelia. All rights reserved.
//

import UIKit

class ListCountriesViewController: UIViewController {
    
    var presenter: ListCountriesPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
}


extension ListCountriesViewController: ListCountriesView {
    func refreshCountriesView() {
        
    }
}
