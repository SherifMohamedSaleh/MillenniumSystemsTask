//
//  CollageBezierPathScreen.swift
//  MillenniumSystemsTask
//
//  Created by Sherif Abd El-Moniem on 21/08/2023.
//

import Foundation
import SwiftUI

struct CollageBezierPathScreen: View {
    var body: some View {
        
        ZStack {
            AngularGradient(gradient: Gradient(colors: [.cyan , .purple, .purple , .cyan]), center: .topLeading).ignoresSafeArea()
            VStack(alignment: .center, content: {
                Spacer(minLength: 50)
                
                CollageFirstShape()
                    .frame(width: 200, height: 200)
                
                Spacer(minLength: 50)
                CollageSecondShape()
                    .stroke(Color.green  , lineWidth :2)
                    .padding([.leading , .trailing ] ,  (UIScreen.main.bounds.size.width - 200) * 0.5)
                
                Spacer(minLength: 20)
                
                CollageThirdShape()
                    .stroke(Color.green  , lineWidth :2)
                    .padding([.leading , .trailing ] ,  (UIScreen.main.bounds.size.width - 200) * 0.5)
                
            })
            
        }
    }
}
struct CollageBezierPathScreen_Previews: PreviewProvider {
    static var previews: some View {
        CollageBezierPathScreen()
            .padding()
    }
}

