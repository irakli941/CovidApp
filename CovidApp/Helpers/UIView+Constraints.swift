//
//  UIView+Constraints.swift
//  CovidApp
//
//  Created by Irakli on 9/26/20.
//  Copyright © 2020 Irakli Shelia. All rights reserved.
//

import UIKit

public extension UIView {
    var safeTopAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.topAnchor
        }
        return self.topAnchor
    }
    
    var safeLeftAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.leftAnchor
        }
        return self.leftAnchor
    }
    
    var safeRightAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.rightAnchor
        }
        return self.rightAnchor
    }
    
    var safeBottomAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.bottomAnchor
        }
        return self.bottomAnchor
    }
    
    func left(toView view: UIView, constant value: CGFloat = 0) {
        self.leftAnchor.constraint(equalTo: view.safeLeftAnchor, constant: value).isActive = true
    }
    func relativeLeft(toView view: UIView, constant value: CGFloat) {
        self.leftAnchor.constraint(equalTo: view.safeRightAnchor, constant: value).isActive = true
    }
    func right(toView view: UIView, constant value: CGFloat = 0) {
        self.rightAnchor.constraint(equalTo: view.safeRightAnchor, constant: -value).isActive = true
    }
    func relativeRight(toView view: UIView, constant value: CGFloat) {
        self.rightAnchor.constraint(equalTo: view.safeLeftAnchor, constant: value).isActive = true
    }
    func top(toView view: UIView, constant value: CGFloat = 0) {
        self.topAnchor.constraint(equalTo: view.safeTopAnchor, constant: value).isActive = true
    }
    func bottom(toView view: UIView, constant value: CGFloat = 0) {
        self.bottomAnchor.constraint(equalTo: view.safeBottomAnchor, constant: -value).isActive = true
    }
    func relativeBottom(toView view: UIView, constant value: CGFloat = 0) {
        self.bottomAnchor.constraint(equalTo: view.safeTopAnchor, constant: -value).isActive = true
    }
    func relativeTop(toView view: UIView, constant value: CGFloat = 0) {
        self.topAnchor.constraint(equalTo: view.safeBottomAnchor, constant: value).isActive = true
    }
    func width(equalTo dimension: NSLayoutDimension) {
        self.widthAnchor.constraint(equalTo: dimension).isActive = true
    }
    func height(to dimension: NSLayoutDimension, multiplier: CGFloat = 0) {
        self.heightAnchor.constraint(equalTo: dimension, multiplier: multiplier).isActive = true
    }
    func height(equalTo constant: CGFloat) {
        self.heightAnchor.constraint(equalToConstant: constant).isActive = true
    }
    func width(equalTo constant: CGFloat) {
        self.widthAnchor.constraint(equalToConstant: constant).isActive = true
    }
    func width(lessThanOrEqualTo dimension: NSLayoutDimension, multiplier: CGFloat = 1) {
        self.widthAnchor.constraint(lessThanOrEqualTo: dimension, multiplier: multiplier).isActive = true
    }
    func width(lessThanOrEqualTo constant: CGFloat) {
        self.widthAnchor.constraint(lessThanOrEqualToConstant: constant).isActive = true
    }
    func centerVertically(to view: UIView) {
        self.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    func centerHorizontally(to view: UIView) {
        self.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}
