//
//  LoginViewController.swift
//  Login_WithServer/Users/seonminjae/Desktop/Login_WithServer/Login_WithServer/SceneDelegate.swift
//
//  Created by 선민재 on 2022/06/14.
//

import UIKit
import SnapKit
import Then
import Moya

class SignUpViewController: UIViewController {
    private let bounds = UIScreen.main.bounds
    
    private let authProvider = MoyaProvider<LoginServices>(plugins: [NetworkLoggerPlugin()])
    var userData: SignupModel?
    
    var essentialFieldList = [UITextField]()
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // TextField 비활성화
        return true
    }
    
    lazy var titleLabel = UILabel().then {
        $0.text = "회원가입"
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
    
    lazy var checkPwField = UITextField().then {
        $0.placeholder = "비밀번호를 다시 한 번 입력해주세요"
        $0.textAlignment = .center
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 2
        $0.layer.borderColor = UIColor.systemGray3.cgColor
    }
    
    lazy var signUpButton = UIButton().then {
        $0.setTitle("회원가입", for: .normal)
        $0.backgroundColor = .systemBlue.withAlphaComponent(0.8)
        $0.layer.cornerRadius = 10
        $0.semanticContentAttribute = .forceRightToLeft
        $0.addTarget(self, action: #selector(signUpAction), for: .touchUpInside)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addView()
        setLayout()
        view.backgroundColor = .white
        essentialFieldList = [idField, pwField, checkPwField]
    }
    private func addView() {
        [titleLabel, idField, pwField, signUpButton, checkPwField].forEach {
            view.addSubview($0)
        }
    }
    private func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(200)
        }
        idField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(310)
            $0.trailing.equalToSuperview().offset(-30)
            $0.size.equalTo(bounds.height * 0.06)
        }
        pwField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(370)
            $0.trailing.equalToSuperview().offset(-30)
            $0.size.equalTo(bounds.height * 0.06)
        }
        checkPwField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(430)
            $0.trailing.equalToSuperview().offset(-30)
            $0.size.equalTo(bounds.height * 0.06)
        }
        signUpButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.size.equalTo(bounds.height * 0.07)
            $0.trailing.equalToSuperview().offset(-30)
            $0.top.equalToSuperview().offset(600)
        }
    }
    
    @objc func signUpAction() {
        
        for field in essentialFieldList {
            if !isFilled(field) {
                signUpAlert(field)
            }
            guard let password = pwField.text, let passwordCheck = checkPwField.text, password == passwordCheck else {
                passwordAlert(title: "비밀번호가 일치하지 않습니다.")
                return
            }
        }
        signUp()
        self.navigationController?.popViewController(animated: true)
    }
    
    func signUpAlert(_ field: UITextField) {
        DispatchQueue.main.async {
            var title = ""
            switch field {
            case self.idField:
                title = "아이디를 입력해주세요."
            case self.pwField:
                title = "비밀번호를 입력해주세요."
            case self.checkPwField:
                title = "비밀번호를 확인해주세요."
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
    func passwordAlert(title:String) {
        DispatchQueue.main.async {
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
    
}


extension SignUpViewController {
    func signUp() {
        let param = SignupRequest.init(self.idField.text!, self.pwField.text!)
        print(param)
        authProvider.request(.signUp(param: param)) {response in
            switch response {
            case .success(let result):
                do {
                    self.userData = try result.map(SignupModel.self)
                } catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
