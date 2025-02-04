//
//  UIDevice+Extension.swift
//  MovieFlick
//
//  Created by Alberto Alegre Bravo on 27/8/24.
//

import SwiftUI

extension UIDevice {
    static var width: CGFloat {
        UIApplication
            .shared
            .connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap(\.windows)
            .first { $0.isKeyWindow }?
            .screen
            .bounds
            .width ?? 0
    }
    
    static var bottomInsetSize: CGFloat {
        UIApplication
            .shared
            .connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap(\.windows)
            .first { $0.isKeyWindow }?
            .safeAreaInsets
            .bottom ?? 0
    }
    
    static var height: CGFloat {
        UIApplication
            .shared
            .connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap(\.windows)
            .first { $0.isKeyWindow }?
            .screen
            .bounds
            .height ?? 0
    }
}
