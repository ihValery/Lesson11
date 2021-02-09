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
    
    @IBOutlet weak var registrationButtonAction: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewWillDisappear(true)
        setMyDesign()
        // Do any additional setup after loading the view.
    }

    @IBAction func emailTFChangedSU(_ sender: UITextField) {
        signInBttnActivna(bool: isEmptyTF())
    }
    @IBAction func passTFChangedSU(_ sender: UITextField) {
        signInBttnActivna(bool: isEmptyTF())
    }
    @IBAction func passTFChangedSUTwo(_ sender: UITextField) {
        signInBttnActivna(bool: isEmptyTF())
    }
    
    @IBAction func registrationButtonAction(_ sender: UIButton) {
        if isValidEmail(emailTFsecond.text ?? "") {
            UserDefaults.standard.set(emailTFsecond.text, forKey: "emailSU")
            if passTFsecond.text == passTFsecondTwo.text,
               let eightPass = passTFsecond.text?.count, eightPass >= 8 {
                UserDefaults.standard.set(passTFsecond.text, forKey: "passSU")
                
               performSegue(withIdentifier: "inVerification", sender: nil)
                //performSegue(withIdentifier: "fromRegistrationToMainApp", sender: nil)
            } else {
                emailOrPassIncorrect.text = "Password is not correct"
                emailOrPassIncorrect.isHidden = false
            }
        } else {
            emailOrPassIncorrect.text = "Email is not correct"
            emailOrPassIncorrect.isHidden = false
        }
        
    }
    
    //
    
    //Проверяем все три поля на заполненость
    private func isEmptyTF() -> Bool {
        emailOrPassIncorrect.isHidden = true
        if let x = emailTFsecond.text, let y = passTFsecond.text, let z = passTFsecondTwo.text {
            return !x.isEmpty && !y.isEmpty && !z.isEmpty
        } else {
            return false
        }
    }
    
//    var myUserForMyApp = UserModel()
//    
//    private func semMyUserForMyApp() {
//    }
    
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
    }
    
    //Проверка на корректность emaila (находиться в stackoverflow)
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    //Кнопка входа появляется/скрывается
    private func signInBttnActivna(bool: Bool) {
        registrationButtonAction.alpha = bool ? 1 : 0.3
        registrationButtonAction.isEnabled = bool
    }
    
    //Показать навигационную панель на контроллере вида мы ее не вызываем в viewDidLoad
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

}
