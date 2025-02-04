import Foundation
import TipKit

struct SwipeTip: Tip {
    var title: Text {
        Text("Time to Swipe!")
    }
    
    var message: Text? {
        Text("Swipe right for YES and left for NO.")
    }
    
    var image: Image? {
        Image(systemName: "square.stack.fill")
    }
    
}

struct GenreTip: Tip {
    var title: Text {
        Text("Choose your favorites genres.")
    }
    
    var message: Text? {
        Text("You can select more than one.")
    }
    
    var image: Image? {
        Image(systemName: "movieclapper.fill")
    }
    
}

struct ChooseOneTip: Tip {
    var title: Text {
        Text("Get a random movie!")
    }
    
    var message: Text? {
        Text("Can not decide? No problem we will do it for you.")
    }
    
    var image: Image? {
        Image(systemName: "wand.and.stars.inverse")
    }
    
}
