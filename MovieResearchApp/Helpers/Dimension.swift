//
//  Dimension.swift
//  MovieResearchApp
//
//  Created by Kürşat Şimşek on 14.03.2022.
//

import Foundation
import UIKit

class Dimension {
    class func setDeviceBounds(_ width: Int, height: Int) {
        AppConstants.shared.deviceWidth = width
        AppConstants.shared.deviceHeight = height
    }

    /**
     Gets device width
     
     - Returns: CGFLoat
     */
    class func getWidth() -> CGFloat {
        return CGFloat(AppConstants.shared.deviceWidth)
    }

    /**
     Gets device height
     
     - Returns: CGFLoat
     */
    class func getHeight() -> CGFloat {
        return CGFloat(AppConstants.shared.deviceHeight)
    }
}
