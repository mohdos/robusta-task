//
//  Image+TextView.swift
//  RobustaTask
//
//  Created by Mohammad Osama on 29/11/2021.
//

import UIKit
class ImageTextView: UIView
{
    internal lazy var textLbl: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.backgroundColor = .clear
        lbl.textColor = UIColor(white: 0.4, alpha: 1)
        lbl.font = UIFont.systemFont(ofSize: 19, weight: .bold)
        lbl.textAlignment = .left
        return lbl
    }()
    
    internal lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 5
        iv.layer.masksToBounds = true
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = .clear
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, image: UIImage?, text: String?) {
        self.init(frame: frame)
        self.backgroundColor = .clear
        
        self.imageView.image = image
        self.textLbl.text = text
        
        self.addSubview(imageView)
        self.addSubview(textLbl)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 6),
            imageView.widthAnchor.constraint(equalToConstant: 20),
            imageView.heightAnchor.constraint(equalToConstant: 20),
            
            textLbl.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            textLbl.centerXAnchor.constraint(equalTo: self.imageView.centerXAnchor, constant: 0),
        ])
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setAttributedText(attributedString: NSAttributedString)
    {
        self.textLbl.attributedText = attributedString
    }
}
