//
//  Delay.swift
//  MovieResearchApp
//
//  Created by Kürşat Şimşek on 7.03.2022.
//

import Foundation

class Delay {
    class func setDelay(_ seconds: Double, fn: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + DispatchTimeInterval.milliseconds(Int(seconds * 1000.0)), execute: fn)
    }
}
