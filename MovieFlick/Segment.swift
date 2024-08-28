//
//  Segment.swift
//  MovieFlick
//
//  Created by Alex  on 28/8/24.
//

import Foundation
import SwiftUI


struct Segment: Shape {
    var startAngle: Angle
    var endAngle: Angle
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        var path = Path()
        path.move(to: center)
        path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        path.closeSubpath()
        return path
    }
}
