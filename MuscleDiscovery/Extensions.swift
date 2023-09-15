//
//  Extensions.swift
//  MuscleDiscovery
//
//  Created by Thuc on 12/9/2023.
//

import Foundation
import SwiftUI

extension Double {
    var clean: String {
       return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}

extension View {
    public func gradientForeground(linearColor: LinearGradient) -> some View {
        self.overlay(
            linearColor
        )
            .mask(self)
    }
}

public extension Date {

    func round(precision: TimeInterval) -> Date {
        return round(precision: precision, rule: .toNearestOrAwayFromZero)
    }

    func ceil(precision: TimeInterval) -> Date {
        return round(precision: precision, rule: .up)
    }

    func floor(precision: TimeInterval) -> Date {
        return round(precision: precision, rule: .down)
    }

    private func round(precision: TimeInterval, rule: FloatingPointRoundingRule) -> Date {
        let minutes = (self.timeIntervalSinceReferenceDate / (precision*60)).rounded(rule) *  precision;
        return Date(timeIntervalSinceReferenceDate: minutes*60)
    }
}
