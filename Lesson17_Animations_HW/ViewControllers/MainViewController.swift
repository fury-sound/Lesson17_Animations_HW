//
//  MainViewController.swift
//  Lesson17_Animations_HW
//
//  Created by Valery Zvonarev on 02.03.2026.
//

import UIKit

protocol MainViewModelDelegate: AnyObject {
//    func moveCircle(direction: ArrowName)
//    var xCenter: NSLayoutConstraint? { get }
//    var yCenter: NSLayoutConstraint? { get }
    func updateX(xValue: CGFloat)
    func updateY(yValue: CGFloat)
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
//    private let circleViewRadius: CGFloat = 25

    // MARK: - Subviews
    private lazy var buttonUp: CircleButton = {
        let button = CircleButton(frame: .zero, .up)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()

    private lazy var buttonDown: CircleButton = {
        let button = CircleButton(frame: .zero, .down)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()

    private lazy var buttonLeft: CircleButton = {
        let button = CircleButton(frame: .zero, .left)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()

    private lazy var buttonRight: CircleButton = {
        let button = CircleButton(frame: .zero, .right)
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
//        let circleSize = CGSize(width: 50, height: 50)
        circle.translatesAutoresizingMaskIntoConstraints = false
//        circle.frame.size = circleSize
        circle.layer.cornerRadius = mainVM.circleViewRadius
        circle.backgroundColor = .red
        return circle
    }()


    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
            mainStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ])
    }

//    private func moving(direction: ArrowName) {
//        let mainViewBounds = mainView.bounds
//        let halfHeight = mainView.bounds.height / 2
//        let halfWidth = mainView.bounds.width / 2
//        guard let xCenter, let yCenter else { return }
//        let minX = -halfWidth + circleViewRadius
//        let maxX = halfWidth - circleViewRadius
//        let minY = -halfHeight + circleViewRadius
//        let maxY = halfHeight - circleViewRadius
//        switch direction {
//            case .up:
//                let newY = yCenter.constant - 50
//                yCenter.constant = max(minY, newY)
//            case .down:
//                let newY = yCenter.constant + 50
//                yCenter.constant = min(maxY, newY)
//            case .left:
//                let newX = xCenter.constant - 50
//                xCenter.constant = max(minX, newX)
//            case .right:
//                let newX = xCenter.constant + 50
//                xCenter.constant = min(maxX, newX)
//        }

//        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut]) {
//            self.mainView.layoutIfNeeded()
//        }
//    }

    @objc private func didTapButton(_ sender: CircleButton) {
        mainVM.mainViewBounds = mainView.bounds
        guard let xCenter, let yCenter else { return }
        mainVM.moveCircle(direction: sender.imageName, xValueConstant: xCenter.constant, yValueConstant: yCenter.constant)
//        moving(direction: sender.imageName)
//        xCenter  = mainVM.xCenter
//        yCenter = mainVM.yCenter
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
}

#Preview {
    MainViewController()
}


