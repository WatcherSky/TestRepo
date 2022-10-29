//
//  Section.swift
//  TestApp
//
//  Created by Владимир on 26.06.2022.
//

import Foundation
import UIKit

enum Section {
    case menu(_ count: Int, _ height: CGFloat, _ headerHeight: CGFloat?)
    case grid(_ count: Int, _ height: CGFloat, _ headerHeight: CGFloat)
    case table(_ count: Int?, _ height: CGFloat, _ headerHeight: CGFloat?)
}
