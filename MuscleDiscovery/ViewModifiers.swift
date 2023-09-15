//
//  ViewModifiers.swift
//  MuscleDiscovery
//
//  Created by Thuc on 12/9/2023.
//

import SwiftUI

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct Shadown3DModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: Color("BlackTransparent"), radius: 7)
    }
}
