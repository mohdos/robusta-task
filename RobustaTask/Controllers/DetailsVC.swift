//
//  DetailsVC.swift
//  RobustaTask
//
//  Created by Mohammad Osama on 29/11/2021.
//

import UIKit

class DetailsVC: UIViewController {

    var repository: Repository
    
    private lazy var repoBgdView: UIView = {
        let sview = UIView()
        sview.translatesAutoresizingMaskIntoConstraints = false
        sview.backgroundColor = UIColor(white: 0.85, alpha: 1)
        sview.layer.cornerRadius = 8
        return sview
    }()
    
    private lazy var repoStatsView: RepoStatsView = {
        let rview = RepoStatsView(frame: .zero)
        rview.translatesAutoresizingMaskIntoConstraints = false
        rview.backgroundColor = .clear
        return rview
    }()
    
    private lazy var repoLinkBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = UIColor(red: 0, green: 122/255, blue: 1, alpha: 1)
        btn.setTitle("View repository", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 7
        btn.addTarget(self, action: #selector(didTapViewRepo(_:)), for: .touchUpInside)
        return btn
    }()
    
    private lazy var ownerView: UIView = {
        let sview = UIView()
        sview.translatesAutoresizingMaskIntoConstraints = false
        sview.backgroundColor = UIColor(white: 0.85, alpha: 1)
        sview.layer.cornerRadius = 8
        return sview
    }()
    
    private lazy var ownerDetailsView: OwnerDetailsView = {
        let sview = OwnerDetailsView(frame: .zero, ownerImageUrl: nil, ownerName: nil)
        sview.translatesAutoresizingMaskIntoConstraints = false
        sview.backgroundColor = .clear
        return sview
    }()
    
    private lazy var descriptionText: UITextView = {
        let tv = UITextView()
        tv.layer.borderWidth = 0
        tv.isEditable = false
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.tintColor = .clear
        tv.backgroundColor = UIColor(white: 0.85, alpha: 1)
        tv.textColor = .black
        tv.layer.cornerRadius = 8
        tv.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        tv.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return tv
    }()
    
    
    
    init(repo: Repository)
    {
        self.repository = repo
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = .white
        self.title = repo.name
        
        self.view.addSubview(self.repoBgdView)
        self.repoBgdView.addSubview(self.repoStatsView)
        self.repoBgdView.addSubview(self.repoLinkBtn)
        self.view.addSubview(self.ownerView)
        self.ownerView.addSubview(self.ownerDetailsView)
        self.view.addSubview(self.descriptionText)
        
        self.ownerDetailsView.edgeTo(ownerView)
        
        NSLayoutConstraint.activate([
            self.repoBgdView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8),
            self.repoBgdView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8),
            self.repoBgdView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            self.repoBgdView.heightAnchor.constraint(equalToConstant: 170),
            
            self.repoStatsView.leadingAnchor.constraint(equalTo: self.repoBgdView.leadingAnchor, constant: 8),
            self.repoStatsView.trailingAnchor.constraint(equalTo: self.repoBgdView.trailingAnchor, constant: -8),
            self.repoStatsView.topAnchor.constraint(equalTo: self.repoBgdView.topAnchor, constant: 8),
            self.repoStatsView.heightAnchor.constraint(equalToConstant: 100),
            
            self.repoLinkBtn.centerXAnchor.constraint(equalTo: self.repoBgdView.centerXAnchor, constant: 0),
            self.repoLinkBtn.heightAnchor.constraint(equalToConstant: 40),
            self.repoLinkBtn.widthAnchor.constraint(equalToConstant: 200),
            self.repoLinkBtn.bottomAnchor.constraint(equalTo: self.repoBgdView.bottomAnchor, constant: -8),
            
            
            self.ownerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8),
            self.ownerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8),
            self.ownerView.topAnchor.constraint(equalTo: self.repoBgdView.bottomAnchor, constant: 20),
            self.ownerView.heightAnchor.constraint(equalToConstant: 80),
            
            self.descriptionText.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8),
            self.descriptionText.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8),
            self.descriptionText.topAnchor.constraint(equalTo: self.ownerView.bottomAnchor, constant: 20),
            self.descriptionText.heightAnchor.constraint(equalToConstant: 80),
        ])
        
        self.repoStatsView.configure(numForks: Int(repo.forksCount), createdAt: repo.createdAt ?? "2021-10-09T10:00:00Z", size: Int(repo.size))
        self.ownerDetailsView.configure(ownerImageUrl: repo.ownerAvatarUrl, ownerName: repo.ownerLogin)
        
        self.descriptionText.text = repo.repoDescription ?? "No description"
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @objc func didTapViewRepo(_ sender: UIButton)
    {
        guard let urlString = self.repository.htmlUrl, let url = URL(string: urlString) else {
            return
        }
        url.openInBrowser()
    }

}
