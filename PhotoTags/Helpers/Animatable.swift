//
//  Animatable.swift
//  PhotoTags
//
//  Created by Andres camilo Raigoza misas on 4/04/22.
//

import Foundation
import SwiftUI

struct AnimatingMapHeight: ViewModifier, Animatable {
    
    var maxHeight: CGFloat
    
    var animatableData: CGFloat {
        get { maxHeight }
        set { maxHeight = newValue }
    }
    
    func body(content: Content) -> some View {
        content.frame(maxHeight: maxHeight)
    }
}
