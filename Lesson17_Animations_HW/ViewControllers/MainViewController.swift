//
//  MainViewController.swift
//  Lesson17_Animations_HW
//
//  Created by Valery Zvonarev on 02.03.2026.
//

import UIKit

protocol MainViewModelDelegate: AnyObject {
    func updateX(xValue: CGFloat)
    func updateY(yValue: CGFloat)
    func setBorder()
    func unsetBorder()
}

enum ArrowName: String {
    case up = "arrowshape.up"
    case down = "arrowshape.down"
    case left = "arrowshape.left"
    case right = "arrowshape.right"
}

final class MainViewController: UIViewController {

    // MARK: - Properties
    private let mainVM = MainViewModel()
    private var xCenter: NSLayoutConstraint?
    private var yCenter: NSLayoutConstraint?

    // MARK: - Subviews
    private lazy var buttonUp: CircleButton = {
        let button = CircleButton(frame: .zero, .up)
        button.addTarget(self, action: #selector(didButtonTouchDown), for: .touchDown)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()

    private lazy var buttonDown: CircleButton = {
        let button = CircleButton(frame: .zero, .down)
        button.addTarget(self, action: #selector(didButtonTouchDown), for: .touchDown)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()

    private lazy var buttonLeft: CircleButton = {
        let button = CircleButton(frame: .zero, .left)
        button.addTarget(self, action: #selector(didButtonTouchDown), for: .touchDown)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()

    private lazy var buttonRight: CircleButton = {
        let button = CircleButton(frame: .zero, .right)
        button.addTarget(self, action: #selector(didButtonTouchDown), for: .touchDown)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()

    private lazy var mainView: UIView = {
        let mainView = UIView()
        mainView.backgroundColor = .white
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.clipsToBounds = true
        return mainView
    }()

    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [buttonUp, middleStackView, buttonDown])
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var middleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [buttonLeft, buttonRight])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = mainVM.circleViewRadius * 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var circleView: UIView = {
        let circle = UIView()
        circle.translatesAutoresizingMaskIntoConstraints = false
        circle.layer.cornerRadius = mainVM.circleViewRadius
        circle.backgroundColor = .red
        return circle
    }()

    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewProperties()
        setupSubviews()
        setupConstraints()
    }

    // MARK: - Layout
    private func setupViewProperties(){
        view.backgroundColor = .systemGray3
        mainVM.delegate = self
    }

    private func setupSubviews(){
        mainView.addSubview(circleView)
        view.addSubview(mainView)
        view.addSubview(mainStackView)
    }

    private func setupConstraints(){
        xCenter = circleView.centerXAnchor.constraint(equalTo: mainView.centerXAnchor, constant: 0)
        yCenter = circleView.centerYAnchor.constraint(equalTo: mainView.centerYAnchor, constant: 0)
        guard let xCenter, let yCenter else { return }

        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainView.bottomAnchor.constraint(equalTo: mainStackView.topAnchor, constant: -10),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            xCenter,
            yCenter,
            circleView.heightAnchor.constraint(equalToConstant: 50),
            circleView.widthAnchor.constraint(equalToConstant: 50),
            mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    @objc private func didButtonTouchDown(_ sender: CircleButton) {
        sender.setButtonColor(for: .highlighted)
    }

    @objc private func didTapButton(_ sender: CircleButton) {
        mainVM.mainViewBounds = mainView.bounds
        sender.setButtonColor(for: .normal)
        guard let xCenter, let yCenter else { return }
        mainVM.moveCircle(direction: sender.imageName, xValueConstant: xCenter.constant, yValueConstant: yCenter.constant)

        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut]) {
            self.mainView.layoutIfNeeded()
        }
    }
}

extension MainViewController: MainViewModelDelegate {
    func updateX(xValue: CGFloat) {
        xCenter?.constant = xValue
    }

    func updateY(yValue: CGFloat) {
        yCenter?.constant = yValue
    }

    func setBorder() {
        let groupAnimation = CAAnimationGroup()
        groupAnimation.duration = 0.7
        groupAnimation.autoreverses = true
        groupAnimation.repeatCount = .infinity

        let colorAnimation = CABasicAnimation(keyPath: "borderColor")
        colorAnimation.fromValue = UIColor.systemOrange.withAlphaComponent(0.2).cgColor
        colorAnimation.toValue = UIColor.systemOrange.withAlphaComponent(1.0).cgColor

        let widthAnimation = CABasicAnimation(keyPath: "borderWidth")
        widthAnimation.fromValue = 1.0
        widthAnimation.toValue = 5

        groupAnimation.animations = [colorAnimation, widthAnimation]

        mainView.layer.add(groupAnimation, forKey: "pulsingBorder")
    }

    func unsetBorder() {
        mainView.layer.removeAllAnimations()
    }
}

#Preview {
    MainViewController()
}


