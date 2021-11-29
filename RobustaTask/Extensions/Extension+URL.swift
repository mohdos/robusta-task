//
//  Extension+URL.swift
//  RobustaTask
//
//  Created by Mohammad Osama on 29/11/2021.
//

import UIKit

extension URL
{
    func openInBrowser()
    {
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(self, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(self)
        }
    }
}
