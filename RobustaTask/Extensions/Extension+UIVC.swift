//
//  Extension+UIVC.swift
//  RobustaTask
//
//  Created by Mohammad Osama on 29/11/2021.
//

import UIKit
extension UIViewController
{
    func presentVC(vc: UIViewController, isModalInPresentation: Bool = false, modalPresentationStyle: UIModalPresentationStyle = .fullScreen, modalTransitionStyle: UIModalTransitionStyle)
    {
        let vc = vc
        if #available(iOS 13.0, *) {
            vc.isModalInPresentation = isModalInPresentation
        } else {
            // Fallback on earlier versions
        }
        vc.modalPresentationStyle = modalPresentationStyle
        vc.modalTransitionStyle = modalTransitionStyle
        
        self.present(vc, animated: true, completion: nil)
    }
}
