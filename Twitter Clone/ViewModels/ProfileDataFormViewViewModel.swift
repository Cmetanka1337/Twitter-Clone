//
//  ProfileDataFormViewViewModel.swift
//  Twitter Clone
//
//  Created by Всеволод Буртик on 16.01.2025.
//

import Foundation
import Combine

final class ProfileDataFormViewViewModel: ObservableObject {
    @Published var displayName: String?
    @Published var username: String?
    @Published var bio: String?
    @Published var avatarPath: String?
}
