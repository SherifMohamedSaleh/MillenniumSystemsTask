//
//  FilterModel.swift
//  MillenniumSystemsTask
//
//  Created by Sherif Abd El-Moniem on 21/08/2023.
//

import Foundation
import SwiftUI

public struct FilterModel : Identifiable {
    public var id :UUID?
    var name : String = ""
    var value : CIFilter?
    
    public init( name: String , value : CIFilter = CIFilter.sepiaTone()) {
        self.name = name
        self.value = value
    }
}
