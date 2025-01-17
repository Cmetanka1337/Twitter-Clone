//
//  HomeViewViewModel.swift
//  Twitter Clone
//
//  Created by Всеволод Буртик on 16.01.2025.
//

import Foundation
import Combine
import FirebaseAuth

final class HomeViewViewModel: ObservableObject {
    
    @Published var user: TwiterUser?
    @Published var error: String?
    
    private var subscriptions: Set<AnyCancellable> = []
    
    
    func retrieveUser() {
        guard let id = Auth.auth().currentUser?.uid else { return }
        DatabaseManager.shared.collectionUsers(retrieve: id)
            .sink { [weak self] completion in
                
                if case .failure(let error) = completion {
                    self?.error = error.localizedDescription
                }
                
            } receiveValue: { [weak self] user in
                self?.user = user
            }
            .store(in: &subscriptions)
    }
    
}
