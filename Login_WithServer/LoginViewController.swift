//
//  LoginViewController.swift
//  Login_WithServer
//
//  Created by 선민재 on 2022/06/14.
//

import UIKit
import SnapKit
import Then
import Moya

class LoginViewController: UIViewController {
    private let bounds = UIScreen.main.bounds
    var essentialFieldList = [UITextField]()
    //var loginProvider = MoyaProvider<LoginServices>(plugins: [NetworkLoggerPlugin()])
    
    private let authProvider = MoyaProvider<LoginServices>(plugins: [NetworkLoggerPlugin()])
    var userData: SigninModel?
    
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
        $0.addTarget(self, action: #selector(LoginAction), for: .touchUpInside)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addView()
        setLayout()
        view.backgroundColor = .white
        essentialFieldList = [idField, pwField]
    }
    @objc func LoginAction() {
        
        for field in essentialFieldList {
            if !isFilled(field) {
                LoginAlert(field)
            }
            
        }
        signin()
    }
    
    func LoginAlert(_ field: UITextField) {
        DispatchQueue.main.async {
            var title = ""
            switch field {
            case self.idField:
                title = "아이디를 입력해주세요."
            case self.pwField:
                title = "비밀번호를 입력해주세요."
            default:
                title = "error"
            }
            let controller = UIAlertController(title: title, message: nil, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "닫기", style: .cancel) {(action) in
                
            }
            controller.addAction(cancelAction)
            self.present(controller, animated: true, completion: nil)
        }
    }
    func isFilled(_ textField: UITextField) -> Bool {
        guard let text = textField.text, !text.isEmpty else {
            return false
        }
        return true
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

extension LoginViewController {
    func success() {
        print("success")
        let successAlert = UIAlertController(title: "성공", message: "로그인에 성공하셨습니다.", preferredStyle: .alert)
        let successAction = UIAlertAction(title: "확인", style: .cancel) {(action) in
            self.navigationController?.popViewController(animated: true)
        }
        successAlert.addAction(successAction)
        self.present(successAlert, animated: true, completion: nil)
    }
    func faliure() {
        let faliureAlert = UIAlertController(title: "실패", message: "아이디 혹은 비밀번호를 다시 확인해주세요", preferredStyle: .alert)
        let faliureAction = UIAlertAction(title: "확인", style: .cancel) {(action) in
        }
        faliureAlert.addAction(faliureAction)
        self.present(faliureAlert, animated: true, completion: nil)
    }
    func signin() {
        let param = SigninRequest.init(self.idField.text!, self.pwField.text!)
        print(param)
        authProvider.request(.signIn(param: param)) {response in
            switch response {
            case .success(let result):
                do {
                    self.userData = try result.map(SigninModel.self)
                } catch(let err) {
                    print(err.localizedDescription)
                }
                let statusCode = result.statusCode
                switch statusCode {
                case 200..<300:
                    self.success()
                default:
                    self.faliure()
                    
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
