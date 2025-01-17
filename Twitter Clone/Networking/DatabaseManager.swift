//
//  DatabaseManager.swift
//  Twitter Clone
//
//  Created by Всеволод Буртик on 16.01.2025.
//

import Foundation
import Firebase
import Combine
import FirebaseFirestoreCombineSwift
import FirebaseAuth
//import FirebaseFirestoreSwift

final class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    let db = Firestore.firestore()
    let usersPath: String = "users"
    
    
    func collectionUsers(add user: User) -> AnyPublisher<Bool, Error> {
        let twitterUser = TwiterUser(from: user)
        return db.collection(usersPath).document(twitterUser.id).setData(from: twitterUser)
            .map{ return true }.eraseToAnyPublisher()
    }
    
    func collectionUsers(retrieve id: String) -> AnyPublisher<TwiterUser, Error> {
        db.collection(usersPath).document(id).getDocument()
            .tryMap { try $0.data(as: TwiterUser.self) }
            .eraseToAnyPublisher()
    }
}
