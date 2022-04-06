//
//  TestView.swift
//  PhotoTags
//
//  Created by Andres camilo Raigoza misas on 6/04/22.
//

import SwiftUI

struct TestView: View {
    @State var isDragging = false

        var drag: some Gesture {
            DragGesture()
                .onChanged { _ in self.isDragging = true }
                .onEnded { _ in self.isDragging = false }
        }

        var body: some View {
            Circle()
                .fill(self.isDragging ? Color.red : Color.blue)
                .frame(width: 100, height: 100, alignment: .center)
                .gesture(drag)
        }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
