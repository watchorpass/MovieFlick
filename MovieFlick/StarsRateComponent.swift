//
//  StarsRateComponent.swift
//  MovieFlick
//
//  Created by Fran Malo on 12/8/24.
//

import SwiftUI

struct StarsRateComponent: View {
    let rate: Double
    var starSize: CGFloat = 20.0
    var starsColor: Color = .yellow
    
    var fiveStarsValue: Double {
        guard rate > 0.0 && rate < 10.0 else { return 0.0 }
        return rate / 2
    }
    
    var parteEntera: Int {
        Int(fiveStarsValue)
    }
    
    var parteDecimal: Double {
        fiveStarsValue - Double(parteEntera)
    }
    
    var numbersArray: [Double] {
        var result = Array(repeating: 1.0, count: parteEntera)
        if result.count < 5 {
            result.append(parteDecimal)
        }
        while result.count < 5 {
            result.append(0)
        }
        return result
    }
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(numbersArray, id: \.self) { value in
                if value > 0.0 && value < 1.0 {
                    var dCorregido: Double {
                        switch value {
                        case 0.999 ... 1.0: 0
                        case 0.85 ... 0.99: 0.25
                        case 0.75 ... 0.84: 0.33
                        case 0.65 ... 0.74: 0.4
                        case 0.55 ... 0.64: 0.455
                        case 0.45 ... 0.54: 0.5
                        case 0.35 ... 0.44: 0.545
                        case 0.25 ... 0.34: 0.585
                        case 0.15 ... 0.24: 0.66
                        case 0.05 ... 0.14: 0.74
                        default: 1
                        }
                    }
                    Image(systemName: "star.fill")
                        .resizable()
                        .frame(width: starSize, height: starSize)
                        .foregroundColor(.clear)
                        .background() {
                            Rectangle()
                                .foregroundColor(starsColor)
                                .offset(x: -starSize  * dCorregido )
                                .mask(Image(systemName: "star.fill")
                                    .resizable()
                                    .frame(width: starSize, height: starSize))
                            
                        }
                        .overlay {
                            Image(systemName: "star")
                                .resizable()
                                .frame(width: starSize, height: starSize)
                                .foregroundColor(.secondary.opacity(0.4))
                        }
                } else if value == 1.0 {
                    Image(systemName: "star.fill")
                        .resizable()
                        .frame(width: starSize, height: starSize)
                        .foregroundColor(starsColor)
                        .overlay {
                            Image(systemName: "star")
                                .resizable()
                                .frame(width: starSize, height: starSize)
                                .foregroundColor(.secondary.opacity(0.4))
                        }
                } else {
                    Image(systemName: "star")
                        .resizable()
                        .frame(width: starSize, height: starSize)
                        .foregroundColor(.secondary.opacity(0.4))
                                    }
            }
        }
    }
}

#Preview {
    StarsRateComponent(rate: 7.1111111111340, starSize: 20)
}
