//
//  ContentView.swift
//  MillenniumSystemsTask
//
//  Created by Sherif Abd El-Moniem on 21/08/2023.
//

import SwiftUI
enum DrawingMode: String, CaseIterable, Identifiable {
    case image, path
    var id: Self { self }
}


struct ContentView: View {

    @State private var mode: DrawingMode = .image

    var body: some View {
        VStack{

            Picker("Mode", selection: $mode) {
                Text("image").tag(DrawingMode.image)
                Text("path").tag(DrawingMode.path)

            }
            .pickerStyle(.segmented)


            if(mode == .image){
                ImageFilter()
            }else if(mode == .path){
                CollageBezierPathScreen()
            }
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

