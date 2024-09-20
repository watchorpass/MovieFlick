import SwiftUI

struct ContentView: View {
    @State private var resetKey = UUID()
    @State private var currentIndex = 0
    let items = ["Vista 1", "Vista 2", "Vista 3"] // Tu array de elementos
    
    var body: some View {
        VStack {
            // Mostrar la vista correspondiente al índice actual
            Text(items[currentIndex])
                .font(.largeTitle)
                .padding()
            
            Spacer()
            
            Button(action: {
                if currentIndex < items.count - 1 {
                    currentIndex += 1 // Avanza al siguiente índice
                }
            }) {
                Text("Siguiente")
                    .font(.title)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .disabled(currentIndex == items.count - 1) // Desactiva el botón en la última vista
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
