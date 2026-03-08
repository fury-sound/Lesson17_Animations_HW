//
//  MainViewModel.swift
//  Lesson17_Animations_HW
//
//  Created by Valery Zvonarev on 03.03.2026.
//

import UIKit

final class MainViewModel {
    var mainViewBounds: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
    let circleViewRadius: CGFloat = 25
    weak var delegate: MainViewModelDelegate?
//    private var reachingBorderFlag: Bool = false {
//        didSet {
//            if reachingBorderFlag == true {
//                print("reachingBorderFlag == true")
//                delegate?.setBorder()
//            } else {
//                print("reachingBorderFlag == false")
//                delegate?.unsetBorder()
//            }
//        }
//    }
    private var reachXBorder: Bool = false
    private var reachYBorder: Bool = false

    func moveCircle(direction: ArrowName, xValueConstant: CGFloat, yValueConstant: CGFloat) {
        let halfHeight = mainViewBounds.height / 2
        let halfWidth = mainViewBounds.width / 2
        let minX = -halfWidth + circleViewRadius
        let maxX = halfWidth - circleViewRadius
        let minY = -halfHeight + circleViewRadius
        let maxY = halfHeight - circleViewRadius
        switch direction {
            case .up:
                let newY = yValueConstant - 50
                reachYBorder = (minY > newY) ? true : false
                //                reachingBorderFlag = (minY > newY) ? true : false
                delegate?.updateY(yValue: max(minY, newY))
            case .down:
                let newY = yValueConstant + 50
                reachYBorder = (maxY < newY) ? true : false
                //                reachingBorderFlag = (maxY < newY) ? true : false
                delegate?.updateY(yValue: min(maxY, newY))
            case .left:
                let newX = xValueConstant - 50
                reachXBorder = (minX > newX) ? true : false
                //                reachingBorderFlag = (minX > newX) ? true : false
                delegate?.updateX(xValue: max(minX, newX))
            case .right:
                let newX = xValueConstant + 50
                reachXBorder = (maxX < newX) ? true : false
                //                reachingBorderFlag = (maxX < newX) ? true : false
                delegate?.updateX(xValue: min(maxX, newX))
        }
        reachXBorder || reachYBorder ? delegate?.setBorder() : delegate?.unsetBorder()
//        if reachXBorder || reachYBorder {
//            delegate?.setBorder()
//        } else {
//            delegate?.unsetBorder()
//        }

    }
}
