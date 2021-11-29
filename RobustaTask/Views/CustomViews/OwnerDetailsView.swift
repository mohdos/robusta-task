//
//  OwnerDetailsView.swift
//  RobustaTask
//
//  Created by Mohammad Osama on 29/11/2021.
//

import Foundation
import UIKit

class OwnerDetailsView: UIView
{
    private lazy var ownerNameLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.backgroundColor = .clear
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return lbl
    }()
    
    private lazy var ownerImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 20
        iv.layer.masksToBounds = true
        iv.backgroundColor = .clear
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, ownerImageUrl: String?, ownerName: String?) {
        self.init(frame: frame)
        
        self.addSubview(ownerImageView)
        self.addSubview(ownerNameLbl)
        
        if ownerImageUrl != nil {
            self.ownerImageView.loadImageUsingCacheWithUrlString(ownerImageUrl!, completion: nil)
        }
        self.ownerNameLbl.text = ownerName
        NSLayoutConstraint.activate([
            ownerImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            ownerImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
            ownerImageView.widthAnchor.constraint(equalToConstant: 40),
            ownerImageView.heightAnchor.constraint(equalToConstant: 40),
            
            ownerNameLbl.centerYAnchor.constraint(equalTo: self.ownerImageView.centerYAnchor, constant: 0),
            ownerNameLbl.leadingAnchor.constraint(equalTo: ownerImageView.trailingAnchor, constant: 8),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(ownerImageUrl: String?, ownerName: String?)
    {
        if ownerImageUrl != nil {
            self.ownerImageView.loadImageUsingCacheWithUrlString(ownerImageUrl!, completion: nil)
        }
        self.ownerNameLbl.text = ownerName
    }
}
