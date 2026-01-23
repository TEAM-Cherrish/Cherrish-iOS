//
//  CherryLevel.swift
//  Cherrish-iOS
//
//  Created by 이나연 on 1/23/26.
//

import Foundation
import SwiftUI

enum CherryLevel: Int {
    case level0 = 0
    case level1
    case level2
    case level3
    case level4

    var levelNumber: Int {
        if self == .level0 {
            return 1
        }
        else {
            return rawValue
        }
    }

    static func from(progressRate: Double) -> CherryLevel {
        switch progressRate {
        case 0:
            return .level0
        case 0.0..<25.0:
            return .level1
        case 25.0..<50.0:
            return .level2
        case 50.0..<75.0:
            return .level3
        case 75.0...100.0:
            return .level4
        default:
            return .level1
        }
    }

    var name: String {
        switch self {
        case .level0, .level1: return "몽롱체리"
        case .level2: return "뽀득체리"
        case .level3: return "팡팡체리"
        case .level4: return "꾸꾸체리"
        }
    }

    var cherryImage: Image {
        switch self {
        case .level0, .level1: return Image(.cherry1)
        case .level2: return Image(.cherry2)
        case .level3: return Image(.cherry3)
        case .level4: return Image(.cherry4)
        }
    }
    
    
    var progressImage: Image {
        Image("challenge_gaugebar_\(rawValue)")
    }
}
