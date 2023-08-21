//
//  CollageSecondShape.swift
//  MillenniumSystemsTask
//
//  Created by Sherif Abd El-Moniem on 21/08/2023.
//

import Foundation
import SwiftUI

struct CollageSecondShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: .zero)
        path.addLine(to: CGPoint(x: 150, y: 0))
        path.addLine(to: CGPoint(x: 150, y: 150))
        path.addLine(to: CGPoint(x: 0, y: 150))
        path.addLine(to: .zero)

        
        path.addLine(to: CGPoint(x: 80, y: 0))
        path.addLine(to: CGPoint(x: 80, y: 150))

    
        path.addLine(to: CGPoint(x: 80, y: 60))
        path.addLine(to: CGPoint(x: 150, y: 100))
      

        
        return path

    }
}
struct CollageSecondShape_Previews: PreviewProvider {
    static var previews: some View {
        CollageSecondShape()
            .stroke(Color.green  , lineWidth :2)
            .frame(height : 200)
            .padding()
    }
}
