//
//  CollageSecondShape.swift
//  MillenniumSystemsTask
//
//  Created by Sherif Abd El-Moniem on 21/08/2023.
//

import Foundation
import SwiftUI



struct CollageSecondShape: View {
    @State private var sectionColors: [Color] = [Color.red , Color.green , Color.blue]

    @State private var showingImagePicker = false

    var body: some View {
        GeometryReader { geometry in
            let numberOfSections = self.sectionColors.count
            
            ForEach(0..<numberOfSections, id: \.self) { index in
       
                self.getShape(for: index)
                    .fill(self.sectionColors[index])
                    .onTapGesture {
                        let color = self.getColor(for: Double.random(in: 1...100), in: Double.random(in: 1...1000))
                        self.sectionColors[index] = color
                    }
            }
        }
    }
    
    private func getColor(for x: CGFloat, in width: CGFloat) -> Color {
        let percentage = x / width
        let hue = Double(percentage)
        return Color(hue: hue, saturation: 0.9, brightness: 0.8)
    }
    
    private func getShape(for index: Int) -> Path {
        // Define shapes based on index or any desired logic

        switch index {
        case 0:
            return Path { path in
                path.move(to: .zero)
                path.addLine(to: CGPoint(x: 100, y: 0))
                path.addLine(to: CGPoint(x: 100, y: 200))
                path.addLine(to: CGPoint(x: 0, y: 200))
                path.addLine(to: .zero)
            }
        case 1:
            return Path { path in
 
                path.move(to:  CGPoint(x: 100, y: 200))
                path.addLine(to:  CGPoint(x: 200, y: 200))
                path.addLine(to:  CGPoint(x: 200, y: 80))
                path.addLine(to: CGPoint(x: 100, y: 120))
                path.closeSubpath()
                

            }
        case 2:
            return Path { path in
 
                path.move(to:  CGPoint(x: 100, y: 0))
                path.addLine(to:  CGPoint(x: 200, y: 0))
                path.addLine(to:  CGPoint(x: 200, y: 90))
                path.addLine(to: CGPoint(x: 100, y: 120))
                path.closeSubpath()
            }
        default:
            return Path { path in
                path.closeSubpath()
                
            }
        }
    }
}


struct CollageSecondShape_Previews: PreviewProvider {
    static var previews: some View {
        CollageSecondShape()
            .frame(width : 200 ,height : 200)
            .padding()
    }
}


