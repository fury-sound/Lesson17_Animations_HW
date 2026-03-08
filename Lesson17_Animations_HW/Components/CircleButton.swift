//
//  CircleButton.swift
//  Lesson17_Animations_HW
//
//  Created by Valery Zvonarev on 03.03.2026.
//

import UIKit

class CircleButton: UIButton {

    var imageName: ArrowName

    override var intrinsicContentSize: CGSize {
        CGSize(width: 50, height: 50)
    }

    init(frame: CGRect, _ imageName: ArrowName) {
        self.imageName = imageName
        super.init(frame: frame)
        setupViewProperties()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViewProperties() {
        self.setImage(UIImage(systemName: imageName.rawValue), for: .normal)
        self.setImage(UIImage(systemName: imageName.rawValue + ".fill"), for: .highlighted)
        self.backgroundColor = .white
        self.clipsToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 25
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
    }

    func setButtonColor(for state: UIControl.State) {
        if state == .highlighted {
            self.backgroundColor = .yellow // Цвет при нажатии
        } else {
            self.backgroundColor = .white // Обычный цвет
        }
    }

}
