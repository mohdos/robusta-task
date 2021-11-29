////
////  RepositoryMapper.swift
////  RobustaTask
////
////  Created by Mohammad Osama on 29/11/2021.
////
//
//import Foundation
//
//
//class RepositoryMapper
//{
//    static func repositoryDecToCore(repoDec: RepositoryDec) -> Repository
//    {
//        let repoCore = Repository()
//        repoCore.url = repoDec.url
//        repoCore.name = repoDec.name
//        repoCore.fullName = repoDec.fullName
//        repoCore.createdAt = repoDec.createdAt
//        repoCore.id = Int64(repoDec.id)
//        repoCore.repoDescription = repoDec.description
//        return repoCore
//    }
//    
//    
//    static func repositoryCoreToDec(repoCore: Repository) -> RepositoryDec
//    {
//        let repoDec = RepositoryDec(owner: OwnerMapper.ownerCoreToDec(ownerCore: repoCore.owner!), id: Int(repoCore.id), nodeId: "", name: repoCore.name ?? "", fullName: repoCore.fullName ?? "", private: false, description: repoCore.repoDescription ?? "", htmlUrl: "", url: repoCore.url ?? "", fork: true, createdAt: nil)
//        return repoDec
//    }
//}
//
