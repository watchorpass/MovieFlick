//
//  chooseWheel.swift
//  MovieFlick
//
//  Created by Alex  on 28/8/24.
//

import SwiftUI

struct ChooseWheel: View {
    @Environment(MovieFlickViewModel.self) var vm
    @State var radius: CGFloat = 0
    @StateObject var wheelVM = ChooseWheelViewModel()
    var body: some View {
        VStack {
            GeometryReader { geo in
                ZStack {
                    ForEach(0..<wheelVM.segmentCount, id: \.self) { index in
                        ZStack {
                            Segment(startAngle: self.angleForSegment(index), endAngle: self.angleForSegment(index + 1))
                                .foregroundStyle(wheelVM.colors[index % wheelVM.colors.count])
                                .onAppear {
                                    let midX = geo.frame(in: .local).midX + 40
                                    let midY = geo.frame(in: .local).midY + 40
                                    radius = min(midX, midY)
                                }
//                            Text(wheelVM.names[index])
//                                .foregroundStyle(.white)
//                                .font(.headline)
                            Image(.interestellar)
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 80)
                                .rotationEffect(angleForSegment(index + 1) - Angle(degrees: 10))
                                .offset(
                                    CGSize(
                                        width: { () -> Double in
                                            let mean: Angle = (angleForSegment(index) + angleForSegment(index + 1)) / 2
                                            return radius * 0.5 * cos(mean.radians)
                                            
                                        }(), height: { () -> Double in
                                            let mean: Angle = (angleForSegment(index) + angleForSegment(index + 1)) / 2
                                            return radius * 0.5 * sin(mean.radians)
                                        }()
                                    )
                                )
                           
                        }
                        .frame(width: 300, height: 300)
                        .rotationEffect(.degrees(wheelVM.rotation))
                    }
                    Circle()
                        .foregroundStyle(.white)
                        .frame(width: 50, height: 50)
                    
                    ArrowIndicator()
                        .foregroundStyle(.gray)
                        .frame(width: 30, height: 30)
                        .rotationEffect(.degrees(180))
                        .offset(x: 150)
                        .shadow(color: .gray, radius: 4, x: 2, y: 2)
                }
                .onTapGesture {
                    wheelVM.spinRoulette()
                }
            }
            .frame(width: 300)
            VStack (spacing: 12) {
                HStack {
                    TextField("Enter name", text: $wheelVM.newColorName)
                        .padding(.leading).frame(height: 55)
                        .background(.thinMaterial, in: .rect(cornerRadius: 12))
                    Button {
                        wheelVM.addNewItem()
                    } label: {
                        Text("add")
                            .bold()
                            .frame(width: 80, height: 55)
                            .background(.thinMaterial, in: .rect(cornerRadius: 12))
                        
                    }
                }
                Spacer()
                if wheelVM.names.filter({$0 != ""}).isEmpty == false {
                    List {
                        ForEach(wheelVM.names, id: \.self) { name in
                            Text(name)
                        }
                        .onDelete(perform: { indexSet in
                            wheelVM.deleteItem(at: indexSet)
                        })
                    }
                }
            }
            AppButton(title: "Add result movies") {
                wheelVM.addResultFilms(moviesResult: vm.resultMovies)
            }
            AppButton(title: "Restart") {
                vm.viewState = .startView
            }

        }
        .appBackground()
        .padding(.horizontal, 12)
        .sheet(isPresented: $wheelVM.showAlert, content: {
            Text("The winning is \(wheelVM.winningName).")
            Image(.interestellar)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 200)
        })

    }
    
    func angleForSegment(_ index: Int) -> Angle {
        Angle(degrees: Double(index) / Double(wheelVM.names.count) * 360)
    }
    
    func textAngleSegment(_ index: Int) -> Angle {
        let segmentAngle = 360.0 / Double(wheelVM.names.count)
        return Angle(degrees: -Double(index) * segmentAngle - segmentAngle / 2)
    }
}

#Preview {
    ChooseWheel()
        .environment(MovieFlickViewModel())
}
