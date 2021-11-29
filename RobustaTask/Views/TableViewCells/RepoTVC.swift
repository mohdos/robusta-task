//
//  RepoTVC.swift
//  RobustaTask
//
//  Created by Mohammad Osama on 29/11/2021.
//

import UIKit

class RepoTVC: UITableViewCell {

    static let CELL_HEIGHT: CGFloat = 120
    var repo: Repository? = nil
    
    private lazy var bgdView: UIView = {
        let bview = UIView()
        bview.translatesAutoresizingMaskIntoConstraints = false
        bview.layer.cornerRadius = 8
        bview.backgroundColor = UIColor(white: 0.85, alpha: 1)
        return bview
    }()
    
    private lazy var nameLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.backgroundColor = .clear
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        return lbl
    }()
    
    private lazy var ownerNameLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.backgroundColor = .clear
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return lbl
    }()
    
    private lazy var creationDateLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.backgroundColor = .clear
        lbl.textColor = UIColor(white: 0.4, alpha: 1)
        lbl.font = UIFont.systemFont(ofSize: 15, weight: .regular)
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
    
    private lazy var repositoryImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "repositoryImage"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.masksToBounds = true
        iv.backgroundColor = .clear
        return iv
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
//        self.backgroundColor = .yellow
//        self.contentView.addSubview(bgdView)
        self.addSubview(bgdView)
        self.bgdView.addSubview(nameLbl)
        self.bgdView.addSubview(ownerNameLbl)
        self.bgdView.addSubview(ownerImageView)
        self.bgdView.addSubview(repositoryImageView)
        self.bgdView.addSubview(creationDateLbl)
        
        self.bgdView.edgeTo(self, top: 8, bottom: -8, leading: 8, trailing: -8)
        NSLayoutConstraint.activate([
            ownerImageView.leadingAnchor.constraint(equalTo: self.bgdView.leadingAnchor, constant: 8),
            ownerImageView.topAnchor.constraint(equalTo: self.bgdView.topAnchor, constant: 8),
            ownerImageView.widthAnchor.constraint(equalToConstant: 40),
            ownerImageView.heightAnchor.constraint(equalToConstant: 40),
            
            repositoryImageView.centerXAnchor.constraint(equalTo: self.ownerImageView.centerXAnchor, constant: 0),
            repositoryImageView.bottomAnchor.constraint(equalTo: self.bgdView.bottomAnchor, constant: -20),
            repositoryImageView.widthAnchor.constraint(equalToConstant: 25),
            repositoryImageView.heightAnchor.constraint(equalToConstant: 25),
            
            ownerNameLbl.centerYAnchor.constraint(equalTo: self.ownerImageView.centerYAnchor, constant: 0),
            ownerNameLbl.leadingAnchor.constraint(equalTo: ownerImageView.trailingAnchor, constant: 8),
            
            nameLbl.centerYAnchor.constraint(equalTo: self.repositoryImageView.centerYAnchor, constant: -8),
            nameLbl.leadingAnchor.constraint(equalTo: ownerNameLbl.leadingAnchor, constant: 0),
            
            creationDateLbl.topAnchor.constraint(equalTo: self.nameLbl.bottomAnchor, constant: 8),
            creationDateLbl.leadingAnchor.constraint(equalTo: nameLbl.leadingAnchor, constant: 0)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func preprocessRepository(_ repository: Repository, _ completion: @escaping (Repository) -> Void)
    {
        if (repository.createdAt == nil || repository.createdAt!.isEmpty) {
            Api.shared.getRepositoryDetails(repository: repository) { repo in
//                repo.update()
                completion(repo)
            }
            return
        }
        else
        {
            completion(repository)
        }
    }
    
    func configure(_ repository: Repository, completion: ((Repository) -> Void)?)
    {
        preprocessRepository(repository) { repo in
            self.ownerImageView.loadImageUsingCacheWithUrlString(repo.ownerAvatarUrl ?? "https://i.picsum.photos/id/283/200/200.jpg?hmac=Qyx_FaWqQPrmQrGhQNKh2t2FUuwTiMNTS1VCkc86YrM", completion: nil)
            self.nameLbl.text = repo.name
            self.ownerNameLbl.text = repo.ownerLogin
            self.creationDateLbl.text = repo.createdAt
            completion?(repo)
        }
    }

}


