//
//  LoginViewController.swift
//  Login_WithServer
//
//  Created by 선민재 on 2022/06/14.
//

import UIKit
import SnapKit
import Then

class LoginViewController: UIViewController {

    lazy var titleLabel = UILabel().then {
        $0.text = "로그인"
        $0.textColor = .black
        $0.font = .boldSystemFont(ofSize: 25)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addView()
        setLayout()
        view.backgroundColor = .white
        
    }
    private func addView() {
        [titleLabel].forEach {
            view.addSubview($0)
        }
    }
    private func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(250)
        }
    }
    
}
