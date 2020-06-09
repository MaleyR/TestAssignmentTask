//
//  MessagesScrollView.swift
//  TestAssignmentTask
//
//  Created by Ruslan Maley on 09.06.2020.
//  Copyright © 2020 Ruslan Maley. All rights reserved.
//

import SwiftUI

struct MessagesScrollView<Content>: View where Content: View {
    var content: () -> Content
    
    @State private var contentHeight: CGFloat = .zero
    @State private var contentOffset: CGFloat = .zero
    
    var body: some View {
        GeometryReader { geometry in
            self.content(geometry: geometry)
        }
        .clipped()
    }
    
    private func content(geometry: GeometryProxy) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
            }
            content()
        }
        .modifier(ViewHeightKey())
        .onPreferenceChange(ViewHeightKey.self) {
            self.updateHeight(with: $0, outerHeight: geometry.size.height)
        }
        .frame(height: geometry.size.height, alignment: .bottom)
        .offset(y: contentOffset)
        .animation(.linear, value: Constants.showingAnimationTime)
    }
    
    private func updateHeight(with height: CGFloat, outerHeight: CGFloat) {
        let delta = self.contentHeight - height
        self.contentHeight = height
        
        if abs(self.contentOffset) > .zero {
            self.updateOffset(with: delta, outerHeight: outerHeight)
        }
    }
    
    private func updateOffset(with delta: CGFloat, outerHeight: CGFloat) {
        let offset = self.contentOffset + abs(delta)
        self.contentOffset = offset
    }
}

struct ViewHeightKey: PreferenceKey {
    static var defaultValue: CGFloat { 0 }
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = value + nextValue()
    }
}

extension ViewHeightKey: ViewModifier {
    func body(content: Content) -> some View {
        return content.background(GeometryReader { proxy in
            Color.clear.preference(key: Self.self, value: proxy.size.height)
        })
    }
}
