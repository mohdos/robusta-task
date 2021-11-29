////
////  OwnerMapper.swift
////  RobustaTask
////
////  Created by Mohammad Osama on 29/11/2021.
////
//
//import Foundation
//
//
//class OwnerMapper
//{
//    static func ownerDecToCore(ownerDec: OwnerDec) -> Owner
//    {
//        let ownerCore = Owner()
//        ownerCore.url = ownerDec.url
//        ownerCore.id = Int64(ownerDec.id)
//        ownerCore.avatarUrl = ownerDec.avatarUrl
//        ownerCore.login = ownerDec.login
//        return ownerCore
//    }
//    
//    static func ownerCoreToDec(ownerCore: Owner) -> OwnerDec
//    {
//        let ownerDec = OwnerDec(id: Int(ownerCore.id), login: ownerCore.login ?? "", avatarUrl: ownerCore.avatarUrl ?? "", followersUrl: "", followingUrl: "", url: ownerCore.url ?? "", type: "User", siteAdmin: false, htmlUrl: "")
//        return ownerDec
//    }
//}
//
