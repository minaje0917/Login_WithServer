//
//  ViewController.swift
//  Login_WithServer
//
//  Created by 선민재 on 2022/06/11.
//

import UIKit
import Then
import SnapKit

class ViewController: UIViewController, UITextFieldDelegate {
    private let bounds = UIScreen.main.bounds
    
    lazy var titleLabel = UILabel().then {
        $0.text = "로그인을 해주세요"
        $0.textColor = .black
        $0.font = .boldSystemFont(ofSize: 25)
    }

    lazy var signUpButton = UIButton().then {
        $0.setTitle("회원가입", for: .normal)
        $0.backgroundColor = .black.withAlphaComponent(0.8)
        $0.layer.cornerRadius = 10
    }
    
    lazy var signInButton = UIButton().then {
        $0.setTitle("로그인", for: .normal)
        $0.backgroundColor = .black.withAlphaComponent(0.8)
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(LoginAction), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addView()
        setLayout()
    }
    
    private func addView() {
        [signUpButton, signInButton, titleLabel].forEach {
            view.addSubview($0)
        }
    }
    
    @objc func LoginAction() {
        let lvc = LoginViewController()
        lvc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(lvc, animated: true)
        
    }

    private func setLayout() {
        signUpButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.size.equalTo(bounds.height * 0.07)
            $0.trailing.equalToSuperview().offset(-30)
            $0.top.equalToSuperview().offset(500)
            }
        signInButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.size.equalTo(bounds.height * 0.07)
            $0.trailing.equalToSuperview().offset(-30)
            $0.top.equalToSuperview().offset(570)
            }
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(250)
        }
    }
    

}

