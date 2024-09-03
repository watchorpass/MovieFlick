//
//  TipKit.swift
//  MovieFlick
//
//  Created by Alex  on 3/9/24.
//

import Foundation
import TipKit

struct SwipeTip: Tip {
    var title: Text {
        Text("Time to Swipe")
    }
    
    var message: Text? {
        Text("Swipe right for YES and left for NO")
    }
    
    var image: Image? {
        Image(systemName: "iphone")
    }
    
}
