//
//  FloatingPoint+Extension.swift
//  CircularProgressView
//
//  Created by Bartosz Dolewski on 23/04/2019.
//  Copyright © 2019 Bartosz Dolewski. All rights reserved.
//


import Foundation

internal extension FloatingPoint {
    func clamped(to range: ClosedRange<Self>) -> Self {
        max(min(self, range.upperBound), range.lowerBound)
    }
}
