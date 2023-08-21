//
//  TextBox.swift
//  MillenniumSystemsTask
//
//  Created by Sherif Abd El-Moniem on 21/08/2023.
//

import SwiftUI
import PencilKit

struct TextBox: Identifiable {

    var id = UUID().uuidString
    var text: String = ""
    // For dragging the view over the screen
    var offset: CGSize = .zero
    var lastOffset: CGSize = .zero
    // text attributes
    var textColor: Color = .white
    var textSize : Double = 30
    // identify that text is edited or added
    var isAdded: Bool = false
}
