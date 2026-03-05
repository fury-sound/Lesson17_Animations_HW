//
//  MainViewModel.swift
//  Lesson17_Animations_HW
//
//  Created by Valery Zvonarev on 03.03.2026.
//

import UIKit

final class MainViewModel {
    var mainViewBounds: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
//    var xCenter: NSLayoutConstraint?
//    var yCenter: NSLayoutConstraint?
    let circleViewRadius: CGFloat = 25
    weak var delegate: MainViewModelDelegate?

    func moveCircle(direction: ArrowName, xValueConstant: CGFloat, yValueConstant: CGFloat) {
        print("direction:", direction)
//        print("mainViewBounds", mainViewBounds)
//        guard let mainViewBounds else {return}
//        guard let mainViewBounds, let xCenter = delegate?.xCenter, let yCenter = delegate?.yCenter else {return}
//        print("mainViewBounds", mainViewBounds)
        let halfHeight = mainViewBounds.height / 2
        let halfWidth = mainViewBounds.width / 2
//        guard let xCenter = delegate?.xCenter, let yCenter = delegate?.yCenter else { return }
        let minX = -halfWidth + circleViewRadius
        let maxX = halfWidth - circleViewRadius
        let minY = -halfHeight + circleViewRadius
        let maxY = halfHeight - circleViewRadius
        switch direction {
            case .up:
//                let newY = yCenter.constant - 50
//                delegate?.yCenter?.constant = max(minY, newY)
                let newY = yValueConstant - 50
                delegate?.updateY(yValue: max(minY, newY))
            case .down:
//                let newY = yCenter.constant + 50
//                delegate?.yCenter?.constant = min(maxY, newY)
                let newY = yValueConstant + 50
                delegate?.updateY(yValue: min(maxY, newY))
            case .left:
//                let newX = xCenter.constant - 50
//                delegate?.xCenter?.constant = max(minX, newX)
                let newX = xValueConstant - 50
                delegate?.updateX(xValue: max(minX, newX))
            case .right:
//                let newX = xCenter.constant + 50
//                delegate?.xCenter?.constant = min(maxX, newX)
                let newX = xValueConstant + 50
                delegate?.updateX(xValue: min(maxX, newX))
        }
    }

    

}
