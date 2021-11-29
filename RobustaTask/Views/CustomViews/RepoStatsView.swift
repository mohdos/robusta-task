//
//  RepoStatsView.swift
//  RobustaTask
//
//  Created by Mohammad Osama on 29/11/2021.
//

import UIKit

class RepoStatsView: UIView
{
    private lazy var forksView: ImageTextView = {
        let fView = ImageTextView(frame: .zero, image: UIImage(named: "forkImage"), text: nil)
        fView.translatesAutoresizingMaskIntoConstraints = false
        return fView
    }()
    
    private lazy var sizeView: ImageTextView = {
        let fView = ImageTextView(frame: .zero, image: UIImage(named: "repositoryImage"), text: nil)
        fView.translatesAutoresizingMaskIntoConstraints = false
        return fView
    }()
    
    private lazy var createdAtView: ImageTextView = {
        let fView = ImageTextView(frame: .zero, image: nil, text: nil)
        fView.translatesAutoresizingMaskIntoConstraints = false
        return fView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(forksView)
        self.addSubview(sizeView)
        self.addSubview(createdAtView)
        
        NSLayoutConstraint.activate([
            forksView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            forksView.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
            forksView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4),
            forksView.widthAnchor.constraint(equalToConstant: 30),
            
            sizeView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
            sizeView.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
            sizeView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4),
            sizeView.widthAnchor.constraint(equalToConstant: 30),
            
            createdAtView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -35),
            createdAtView.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
            createdAtView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4),
            createdAtView.widthAnchor.constraint(equalToConstant: 30),
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(numForks: Int, createdAt: String, size: Int)
    {
        let sizeMB = String.init(format: "%.1f", Float(size)/Float(1000))
        let createdAtPretty = createdAt.parseISODateString()
        
        let sizeAttributed = NSMutableAttributedString()
        sizeAttributed.append(NSAttributedString(string: sizeMB, attributes: [.foregroundColor: UIColor.black, .font: UIFont.systemFont(ofSize: 19, weight: .bold)]))
        sizeAttributed.append(NSAttributedString(string: "MB", attributes: [.foregroundColor: UIColor(white: 0.15, alpha: 1), .font: UIFont.systemFont(ofSize: 14, weight: .regular)]))
        
        let forksAttributed = NSMutableAttributedString()
        sizeAttributed.append(NSAttributedString(string: "\(numForks)", attributes: [.foregroundColor: UIColor.black, .font: UIFont.systemFont(ofSize: 19, weight: .bold)]))
        sizeAttributed.append(NSAttributedString(string: "forks", attributes: [.foregroundColor: UIColor(white: 0.15, alpha: 1), .font: UIFont.systemFont(ofSize: 14, weight: .regular)]))
        
        let createdAtAttributed = NSMutableAttributedString()
        sizeAttributed.append(NSAttributedString(string: "\(createdAtPretty)", attributes: [.foregroundColor: UIColor.black, .font: UIFont.systemFont(ofSize: 18, weight: .bold)]))
        
//        self.createdAtView.setAttributedText(attributedString: createdAtAttributed)
//        self.forksView.setAttributedText(attributedString: forksAttributed)
//        self.sizeView.setAttributedText(attributedString: sizeAttributed)
        self.forksView.textLbl.text = "\(numForks)"
        self.createdAtView.textLbl.text = createdAtPretty
        self.sizeView.textLbl.text = sizeMB + " MB"
    }
}


