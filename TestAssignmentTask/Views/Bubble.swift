//
//  Bubble.swift
//  TestAssignmentTask
//
//  Created by Ruslan Maley on 05.06.2020.
//  Copyright © 2020 Ruslan Maley. All rights reserved.
//

import SwiftUI

struct Bubble: View {
    var message: Message
    var shouldMoveUp: Bool = true
    
    @State var opacity: Double = 1
    
    private var chatBubble: some View {
        Rectangle()
            .foregroundColor(Color(red: 253 / 255, green: 253 / 255, blue: 254 / 255))
            .cornerRadius(5, corners: [.topLeft, .topRight, .bottomRight])
    }
    
    private func chatTriangle(size: CGSize) -> some View {
        Path { path in
            path.move(to: CGPoint(x: size.width, y: size.height))
            path.addLine(to: CGPoint(x: 2, y: size.height))
            path.addRelativeArc(
                center: CGPoint(x: 2, y: size.height - 2),
                radius: 2,
                startAngle: Angle(degrees: 45),
                delta: Angle(degrees: 105)
            )
            path.addLine(to: CGPoint(x: size.width, y: 0))
            path.closeSubpath()
        }
        .fill(Color(red: 253 / 255, green: 253 / 255, blue: 254 / 255))
        .frame(width: 11, height: 18)
    }
    
    var textView: some View {
        Text(message.text)
            .padding(10)
            .foregroundColor(.black)
            .background(chatBubble)
    }
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            chatTriangle(size: CGSize(width: 11, height: 18))
            textView
            Spacer()
        }
        .clipped()
        .shadow(color: .black, radius: 4, x: 1, y: 1)
        .padding(.bottom, 30)
        .padding(.leading, 20)
        .padding(.top, 0)
        .fixedSize(horizontal: false, vertical: true)
        .frame(maxWidth: UIScreen.main.bounds.width * 0.75)
        .background(Color.clear)
        .opacity(self.opacity)
        .transition(self.shouldMoveUp ? .move(edge: .bottom) : .identity)
        .animation(.linear(duration: Constants.showingAnimationTime))
        .onAppear() {
            self.opacity = 0

            let animation = Animation.linear(duration: Constants.showingAnimationTime)
            
            return withAnimation(animation) {
                self.opacity = 1
            }
        }
    }
}

struct Bubble_Previews: PreviewProvider {
    static var previews: some View {
        Bubble(message: Message(id: 0, text: "Some test text\nSome text\nNew text"))
            .previewLayout(.fixed(width: 200, height: 150))
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
