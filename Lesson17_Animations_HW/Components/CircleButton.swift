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
//        self.tintColor = .red
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 25
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
//        self.setBackgroundImage(.red, for: .highlighted)
//        self.setBackgroundImage(.green, for: .normal)
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .blue
        config.baseForegroundColor = .white
//        var highlightedColor = config
//        highlightedColor.baseBackgroundColor = .red


//        self.setTitleColor(.red, for: .normal)
//        self.setTitleColor(.blue, for: .highlighted)
    }

    func setButtonColor(for state: UIControl.State) {
        if state == .highlighted {
            self.backgroundColor = .yellow // Цвет при нажатии
        } else {
            self.backgroundColor = .white // Обычный цвет
        }
    }

}

//extension UIButton {
//    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
//        let image = UIImage(color)
//        setBackgroundImage(image, for: state)
//        self.backgroundColor = color
//    }
//}
