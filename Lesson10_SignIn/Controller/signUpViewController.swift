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
        setMyDesign()
        
        // Do any additional setup after loading the view.
    }

    @IBAction func emailTFdidBegin() {
        emailOrPassIncorrect.isHidden = true
    }
    
    @IBAction func emailTFdidEnd(_ sender: UITextField) {
        if !isValidEmail(emailTFsecond.text ?? "") {
            emailOrPassIncorrect.text = "Email is not correct"
            emailOrPassIncorrect.isHidden = false
        }
    }
    
    @IBAction func passTFChangedSU(_ sender: UITextField) {
        
    }
    @IBAction func passTFChangedSUTwo(_ sender: UITextField) {
        if passTFsecond.text == passTFsecondTwo.text,
           let eightPass = passTFsecond.text?.count, eightPass >= 8 {
            signInBttnActivna(bool: isEmptyTF())
        } else {
            emailOrPassIncorrect.text = "Password is not correct"
            emailOrPassIncorrect.isHidden = false
        }
    }
    
    @IBAction func registrationButtonAction(_ sender: UIButton) {
        if let verificationSB = storyboard?.instantiateViewController(identifier: "verificationSB") as? verificationVC {
            navigationController?.pushViewController(verificationSB, animated: true)
            //self.showDetailViewController(verificationSB, sender: nil)  //модальное окно
        }
    }
    
    //Проверяем все три поля на заполненость
    private func isEmptyTF() -> Bool {
        emailOrPassIncorrect.isHidden = true
        if let x = emailTFsecond.text, let y = passTFsecond.text, let z = passTFsecondTwo.text {
            return !x.isEmpty && !y.isEmpty && !z.isEmpty
        } else {
            return false
        }
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
}
