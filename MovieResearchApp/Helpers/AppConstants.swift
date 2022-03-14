//
//  AppConstants.swift
//  MovieResearchApp
//
//  Created by Kürşat Şimşek on 14.03.2022.
//

import Foundation
import UIKit

class AppConstants {
    static let shared: AppConstants = AppConstants()
    private init() {}
    
    /// Holds device width
    var deviceWidth = 0
    /// Holds device height
    var deviceHeight = 0

    /// The temporary image I use for hero transition
    var imageForHero: UIImage?
}
