//
//  CollageThirdShape.swift
//  MillenniumSystemsTask
//
//  Created by Sherif Abd El-Moniem on 21/08/2023.
//

import Foundation
import SwiftUI

struct CollageThirdShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: .zero)
        path.addLine(to: CGPoint(x: 150, y: 0))
        path.addLine(to: CGPoint(x: 150, y: 150))
        path.addLine(to: CGPoint(x: 0, y: 150))
        path.addLine(to: .zero)

        
        path.addLine(to: CGPoint(x: 0, y: 60))
        path.addLine(to: CGPoint(x: 150, y: 60))

    
        path.addLine(to: CGPoint(x: 100, y: 60))
        path.addLine(to: CGPoint(x: 50, y: 150))
      

        
        return path

    }
}
struct CollageThirdShape_Previews: PreviewProvider {
    static var previews: some View {
        CollageThirdShape()
            .stroke(Color.green  , lineWidth :2)
            .frame(height : 200)
            .padding()
    }
}
