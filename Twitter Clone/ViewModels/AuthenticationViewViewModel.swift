//
//  RegisterViewViewModel.swift
//  Twitter Clone
//
//  Created by Всеволод Буртик on 15.01.2025.
//

import Foundation
import Combine
import FirebaseAuth

final class AuthenticationViewViewModel: ObservableObject {
    @Published var email: String?
    @Published var password: String?
    @Published var isAuthenticationFormValid: Bool = false
    @Published var user: User?
    @Published var error: String?
    private var subscriptions: Set<AnyCancellable> = []
    
    func validateAuthenticationForm() {
        guard let email, let password else { 
            isAuthenticationFormValid = false
            return
        }
        isAuthenticationFormValid = isValidEmail(email) && password.count >= 8
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func createUser() {
        guard let email,
              let password else { return }
        
        AuthManager.shared.registerUser(with: email, password: password)
            .handleEvents(receiveOutput: { [weak self] user in
                
                self?.user = user
            })
            .sink { [weak self] completion in
                
                if case .failure(let error) = completion {
                    self?.error = error.localizedDescription
                }
                
        } receiveValue: { [weak self] user in
            
            self?.createRecord(for: user)
        }.store(in: &subscriptions)
    }
    
    func createRecord(for user: User) {
        DatabaseManager.shared.collectionUsers(add: user).sink { [weak self] completion in
            
            if case .failure(let error) = completion {
                self?.error = error.localizedDescription
            }
            
        } receiveValue: { state in
            print("Adding user to DB: \(state)")
        }.store(in: &subscriptions)

    }
    
    func loginUser() {
        guard let email,
              let password else { return }
        AuthManager.shared.loginUser(with: email, password: password)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.error = error.localizedDescription
                }
        } receiveValue: { [weak self] user in
            self?.user = user
        }.store(in: &subscriptions)

    }
}
