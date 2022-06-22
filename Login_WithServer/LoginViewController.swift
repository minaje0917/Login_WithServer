//
//  LoginViewController.swift
//  Login_WithServer
//
//  Created by 선민재 on 2022/06/14.
//

import UIKit
import SnapKit
import Then
import Alamofire

class LoginViewController: UIViewController {
    private let bounds = UIScreen.main.bounds
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // TextField 비활성화
        return true
    }
    
    lazy var titleLabel = UILabel().then {
        $0.text = "로그인"
        $0.textColor = .black
        $0.font = .boldSystemFont(ofSize: 25)
        
    }
    lazy var idField = UITextField().then {
        $0.placeholder = "아이디를 입력해주세요"
        $0.textAlignment = .center
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 2
        $0.layer.borderColor = UIColor.systemGray3.cgColor
    }
    
    lazy var pwField = UITextField().then {
        $0.placeholder = "비밀번호를 입력해주세요"
        $0.textAlignment = .center
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 2
        $0.layer.borderColor = UIColor.systemGray3.cgColor
    }
    lazy var loginButton = UIButton().then {
        $0.setTitle("로그인", for: .normal)
        $0.backgroundColor = .systemBlue.withAlphaComponent(0.8)
        $0.layer.cornerRadius = 10
        //$0.addTarget(self, action: #selector(LoginAction), for: .touchUpInside)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addView()
        setLayout()
        view.backgroundColor = .white
        
    }
    private func addView() {
        [titleLabel, idField, pwField, loginButton].forEach {
            view.addSubview($0)
        }
    }
    
    
    private func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(250)
        }
        idField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(400)
            $0.trailing.equalToSuperview().offset(-30)
            $0.size.equalTo(bounds.height * 0.06)
        }
        pwField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(460)
            $0.trailing.equalToSuperview().offset(-30)
            $0.size.equalTo(bounds.height * 0.06)
        }
        loginButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.size.equalTo(bounds.height * 0.07)
            $0.trailing.equalToSuperview().offset(-30)
            $0.top.equalToSuperview().offset(550)
        }
    }
    
}
