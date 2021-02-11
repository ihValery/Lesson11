//
//  signUpViewController.swift
//  Lesson10PersonalityQuiz
//
//  Created by Валерий Игнатьев on 04.02.2021.
//

import UIKit

class signUpViewController: UIViewController {
    
    @IBOutlet weak var emailOrPassIncorrect: UILabel!
   
    @IBOutlet weak var emailTFsecond: UITextField!
    @IBOutlet weak var passTFsecond: UITextField!
    @IBOutlet weak var passTFsecondTwo: UITextField!
    
    @IBOutlet weak var progressViewPassword: UIProgressView!
    @IBOutlet weak var registrationButtonAction: UIButton!
    
    var userModel: UserModel = UserModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showLoginVC()
        setMyDesign()
        
        // Do any additional setup after loading the view.
    }

    @IBAction func emailTFdidBegin() {
        emailOrPassIncorrect.isHidden = true
    }
    
    @IBAction func emailTFdidEnd(_ sender: UITextField) {
        if !isValidEmail(emailTFsecond.text ?? "") {
            emailOrPassIncorrect.text     = "Email is not correct"
            emailOrPassIncorrect.isHidden = false
        }
    }
    
    @IBAction func passTFChangedSU(_ sender: UITextField) {
        isValidPassword()
    }
    @IBAction func passTFChangedSUTwo(_ sender: UITextField) {
        if passTFsecond.text == passTFsecondTwo.text {
            signInBttnActivna(bool: true)
            emailOrPassIncorrect.isHidden = true
        } else {
            emailOrPassIncorrect.text     = "Password don't match"
            emailOrPassIncorrect.isHidden = false
        }
    }
    
    @IBAction func registrationButtonAction(_ sender: UIButton) {
        if let verificationSB = storyboard?.instantiateViewController(identifier: "verificationSB") as? verificationVC {
            userModel.email = emailTFsecond.text
            userModel.pass  = passTFsecondTwo.text
            saveCredantional()
            navigationController?.pushViewController(verificationSB, animated: true)
            //self.showDetailViewController(verificationSB, sender: nil)  //модальное окно
        }
    }
    
    @IBAction func SignInActionForAnimate() {
        removeLoginViewController()
    }
    
    //Стыренная анимация (работает, но надо самому разбираться/учиться)
    private func showLoginVC() {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.5) {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
    }
    
    private func removeLoginViewController() {
        UIView.animate(withDuration: 0.7, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0 }) { _ in                             //замыкание
            self.view.removeFromSuperview()
        }
    }
    
    
    private func saveCredantional() {
        UserDefaults.standard.set(emailTFsecond.text, forKey: "emailSU")
        UserDefaults.standard.set(passTFsecondTwo.text, forKey: "passSU")
    }
    
    private func setMyDesign() {
        registrationButtonAction.layer.cornerRadius = 20
        registrationButtonAction.backgroundColor = .red
        registrationButtonAction.setTitleColor(.white, for: .normal)
        registrationButtonAction.alpha = 0.3
        registrationButtonAction.isEnabled = false
    
        emailTFsecond.layer.cornerRadius = 15
        emailTFsecond.layer.borderWidth = 0.1
        emailTFsecond.clipsToBounds = true
        
        passTFsecond.layer.cornerRadius = 15
        passTFsecond.layer.borderWidth = 0.1
        passTFsecond.clipsToBounds = true
        
        passTFsecondTwo.layer.cornerRadius = 15
        passTFsecondTwo.layer.borderWidth = 0.1
        passTFsecondTwo.clipsToBounds = true
        
        emailOrPassIncorrect.isHidden = true
 
        progressViewPassword.trackTintColor = .white
    }
    
    //Проверка на корректность emaila (находиться в stackoverflow)
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred  = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    //Проверка пароля стандартам безопастности
    private func isValidPassword() {
        let levelTwoBigChar   = NSPredicate(format: "SELF MATCHES %@ ",
                                     "^(?=.*[a-z])(?=.*[A-Z]).{6,}$")
        let levelTwoNumber    = NSPredicate(format: "SELF MATCHES %@ ",
                                     "^(?=.*[a-z])(?=.*[0-9]).{6,}$")
        let levelTwoSpec      = NSPredicate(format: "SELF MATCHES %@ ",
                                     "^(?=.*[a-z])(?=.*[$@$#!%*?&]).{6,}$")
        
        let levelThreeNumber  = NSPredicate(format: "SELF MATCHES %@ ",
                                     "^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9]).{6,}$")
        let levelThreeSpec    = NSPredicate(format: "SELF MATCHES %@ ",
                                     "^(?=.*[a-z])(?=.*[0-9])(?=.*[$@$#!%*?&]).{6,}$")
        let levelThreeBigChar = NSPredicate(format: "SELF MATCHES %@ ",
                                     "^(?=.*[a-z])(?=.*[$@$#!%*?&])(?=.*[A-Z]).{6,}$")
        
        let levelFour         = NSPredicate(format: "SELF MATCHES %@ ",
                                     "^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[$@$#!%*?&]).{8,}$")
        
        if let pass = passTFsecond.text {
            switch pass {
                case _ where levelFour.evaluate(with: pass):
                    progressViewPassword.progress = 1
                    progressViewPassword.progressTintColor = .green
                
                case _ where levelThreeBigChar.evaluate(with: pass) || levelThreeNumber.evaluate(with: pass) || levelThreeSpec.evaluate(with: pass):
                    progressViewPassword.progress = 0.75
                    progressViewPassword.progressTintColor = .systemYellow
                    
                case _ where levelTwoBigChar.evaluate(with: pass) || levelTwoNumber.evaluate(with: pass) || levelTwoSpec.evaluate(with: pass):
                    progressViewPassword.progress = 0.5
                    progressViewPassword.progressTintColor = .orange
                    
                case _ where pass.count > 4:
                    progressViewPassword.progress = 0.25
                    progressViewPassword.progressTintColor = .red
                    
                default:
                    progressViewPassword.progress = 0
            }
        }
    }
    
    //Кнопка входа появляется/скрывается
    private func signInBttnActivna(bool: Bool) {
        registrationButtonAction.alpha     = bool ? 1 : 0.3
        registrationButtonAction.isEnabled = bool
    }
}
