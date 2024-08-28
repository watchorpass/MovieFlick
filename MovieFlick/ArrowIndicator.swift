//
//  ArrowIndicator.swift
//  MovieFlick
//
//  Created by Alex  on 28/8/24.
//

import Foundation
import SwiftUI

struct ArrowIndicator: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        
        path.move(to: CGPoint(x: width, y: height / 2))
        path.addLine(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 0, y: height))
        path.closeSubpath()
        
        return path
    }
}
