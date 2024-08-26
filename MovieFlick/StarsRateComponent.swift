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
    
    var integerPart: Int {
        Int(fiveStarsValue)
    }
    
    var fractionalPart: Double {
        fiveStarsValue - Double(integerPart)
    }
    
    var numbersArray: [Double] {
        var result = Array(repeating: 1.0, count: integerPart)
        if result.count < 5 {
            result.append(fractionalPart)
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
                    let offset = adjustedOffset(floatPart: value)
                    Image(systemName: "star.fill")
                        .resizable()
                        .frame(width: starSize, height: starSize)
                        .foregroundColor(.clear)
                        .background() {
                            Rectangle()
                                .foregroundColor(starsColor)
                                .offset(x: -starSize * offset )
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
    
    func adjustedOffset(floatPart: Double) -> Double {
        switch floatPart {
        case 0.999 ... 1.0: return 0.0
        case 0.85 ... 0.99: return 0.25
        case 0.75 ... 0.84: return 0.33
        case 0.65 ... 0.74: return 0.4
        case 0.55 ... 0.64: return 0.455
        case 0.45 ... 0.54: return 0.5
        case 0.35 ... 0.44: return 0.545
        case 0.25 ... 0.34: return 0.585
        case 0.15 ... 0.24: return 0.66
        case 0.05 ... 0.14: return 0.74
        default: return 1.0
        }
    }
}

#Preview {
    StarsRateComponent(rate: 8.322, starSize: 20)
}
