//
//  CollageThirdShape.swift
//  MillenniumSystemsTask
//
//  Created by Sherif Abd El-Moniem on 21/08/2023.
//

import Foundation
import SwiftUI


struct CollageThirdShape: View {
    @State private var selectedImages: [UIImage] = []
    @State private var isImagePickerPresented: Bool = false
    @State private var imageSelectionMode  : ImageSelectionEnum = ImageSelectionEnum.multy
    @State private var sectionColors: [Color] = [Color.red , Color.green , Color.blue]
    var body: some View {
        if selectedImages.count == 0 {
            Button(action:{ isImagePickerPresented.toggle() } , label: {
                Text("Select \"3\" Images")
                    .foregroundColor(.black)
                    .padding()
                    .font(.title).border(Color.black, width: 2)
            })
            
            
            .sheet(isPresented: $isImagePickerPresented) {
                ImageMultyPicker(selectedImages: $selectedImages , imageSelectionMode: $imageSelectionMode)
            }
        } else{
            GeometryReader { geometry in
                ForEach(0..<self.selectedImages.count, id: \.self) { index in
                    
                    PhotoView(image:self.selectedImages[index])
                    
                        .clipShape(  self.getShape(for: index))
                        .clipped()
                }
            }
        }
    }
    private func getShape(for index: Int) ->  Path {
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
    private func selectImage() {
        self.isImagePickerPresented = true
    }
    private func getColor(for x: CGFloat, in width: CGFloat) -> Color {
        let percentage = x / width
        let hue = Double(percentage)
        return Color(hue: hue, saturation: 0.8, brightness: 0.8)
    }
}
struct DraggableImageView_Previews: PreviewProvider {
    static var previews: some View {
        CollageThirdShape()
            .frame(height : 200)
            .padding()
    }
}
