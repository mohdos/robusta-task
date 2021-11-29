//
//  Extensions+UIView.swift
//  RobustaTask
//
//  Created by Mohammad Osama on 29/11/2021.
//

import UIKit

extension UIView
{
    func hideKeyboardOnTap(selector: Selector)
    {
        let tapGesture = UITapGestureRecognizer(target: self, action: selector)
        self.addGestureRecognizer(tapGesture)
    }
    func edgeTo(_ view: UIView, top: CGFloat = 0, bottom: CGFloat = 0, leading: CGFloat = 0, trailing: CGFloat = 0)
    {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.topAnchor, constant: top),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottom),
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leading),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: trailing)
        ])
    }
}
