//
//  CollageFirstShape.swift
//  MillenniumSystemsTask
//
//  Created by Sherif Abd El-Moniem on 21/08/2023.
//

import Foundation
import SwiftUI

struct CollageFirstShape: View {
    @State private var sectionImages: [UIImage?]
    
    @State private var showingImagePicker = false
    @State var currentIndex = 0
    
    init() {
        self._sectionImages = State(initialValue: Array(repeating: nil, count: 2))
    }
    
    var body: some View {
        GeometryReader { geometry in
            let numberOfSections = self.sectionImages.count
            
            ForEach(0..<numberOfSections, id: \.self) { index in
                ZStack{
                    
                    self.getShape(for: index)
                        .fill( index == 0 ? Color.red : Color.green)
                        .overlay(
                            Image(uiImage:  self.sectionImages[index] ?? UIImage())
                                .resizable()
                        )
                        .clipped()
                    
                    
                        .onTapGesture {
                            
                            self.selectImage(for: index)
                        }
                    
                }
                
                .onTapGesture {
                    
                    self.selectImage(for: index)
                    
                }
            }
        }.sheet(isPresented: $showingImagePicker) {
            ImagePicker(image:  self.$sectionImages[currentIndex])
        }
    }
    
    private func selectImage(for index: Int) {
        currentIndex = index
        self.showingImagePicker = true
        
    }
    
    private func getShape(for index: Int) -> Path {
        // Define shapes based on index or any desired logic
        switch index {
        case 0:
            return Path { path in
                path.move(to: .zero)
                path.addLine(to: CGPoint(x: 100, y: 0))
                path.addLine(to: CGPoint(x: 150, y: 250))
                path.addLine(to: CGPoint(x: 0, y: 250))
                path.addLine(to: .zero)
            }
        case 1:
            return Path { path in
                
                path.move(to:  CGPoint(x: 150, y: 250))
                path.addLine(to:  CGPoint(x: 250, y: 250))
                path.addLine(to:  CGPoint(x: 250, y: 0))
                path.addLine(to: CGPoint(x: 100, y: 0))
                path.closeSubpath()
            }
        default:
            return Path { path in
                path.closeSubpath()
                
            }
        }
    }
}


struct CollageFirstShape_Previews: PreviewProvider {
    static var previews: some View {
        CollageFirstShape()
            .frame(width : 200, height : 200 )
            .padding()
    }
}
