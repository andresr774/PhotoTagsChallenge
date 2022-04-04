//
//  View.swift
//  PhotoTags
//
//  Created by Andres camilo Raigoza misas on 4/04/22.
//

import Foundation
import SwiftUI

extension View {
    func animateHeigt(maxHeight: CGFloat) -> some View {
        modifier(AnimatingMapHeight(maxHeight: maxHeight))
    }
}
