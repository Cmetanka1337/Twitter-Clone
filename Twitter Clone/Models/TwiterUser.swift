//
//  TwiterUser.swift
//  Twitter Clone
//
//  Created by Всеволод Буртик on 16.01.2025.
//

import Foundation
import FirebaseAuth

struct TwiterUser: Codable{
    let id: String
    var displayName: String = ""
    var username: String = ""
    var bio: String = ""
    var followersCount: Double = 0
    var followingCount: Double = 0
    var createdOn: Date = Date()
    var avatarPath: String = ""
    var isUserOnboarded: Bool = false
    
    init(from user: User) {
        self.id = user.uid
    }
}
