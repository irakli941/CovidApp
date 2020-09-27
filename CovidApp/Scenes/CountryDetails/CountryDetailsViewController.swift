//
//  CountryDetailsViewController.swift
//  CovidApp
//
//  Created by Irakli on 9/26/20.
//  Copyright © 2020 Irakli Shelia. All rights reserved.
//

import UIKit

class CountryDetailsViewController: UIViewController {
    var configurator: CountryDetailsConfigurator!
    var presenter: CountryDetailsPresenter!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(for: self)
        presenter.viewDidLoad()
    }
}


extension CountryDetailsViewController: CountryDetailsView {
    
}
