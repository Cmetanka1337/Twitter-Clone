//
//  UIIMage+Extension.swift
//  Twitter Clone
//
//  Created by Всеволод Буртик on 12.01.2025.
//

import UIKit

extension UIImage {
    func resized(to size: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        
        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
