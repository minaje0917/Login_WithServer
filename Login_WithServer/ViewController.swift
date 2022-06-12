//
//  ViewController.swift
//  Login_WithServer
//
//  Created by 선민재 on 2022/06/11.
//

import UIKit
import Then
import SnapKit

class ViewController: UIViewController {
    private let bounds = UIScreen.main.bounds

    lazy var startButton = UIButton().then {
        $0.setTitle("시작하기", for: .normal)
        $0.backgroundColor = .black.withAlphaComponent(0.8)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setLayout()
    }
    
    private func addView() {
        [startButton].forEach {
            view.addSubview($0)
        }
    }

    private func setLayout() {
        startButton.snp.makeConstraints {
            $0.size.equalTo(bounds.height * 0.1)
        }
    }
    

}

