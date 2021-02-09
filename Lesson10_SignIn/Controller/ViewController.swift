//
//  ViewController.swift
//  Lesson10PersonalityQuiz
//
//  Created by Валерий Игнатьев on 03.02.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var emailOrPassIncorrect: UILabel!
    @IBOutlet weak var tokenSwitch: UISwitch!
    @IBOutlet weak var saveToken: UILabel!
    
    @IBOutlet weak var signInButton: UIButton!
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passTF: UITextField!
    
    @IBOutlet weak var saveEmail: UILabel!
    @IBOutlet weak var savePass: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setMyDesign()
        authorizedOrNot()
        showEmailAndPass()
        
        // Do any additional setup after loading the view.
    }

    @IBAction func emailTFChanged(_ sender: UITextField) {
        signInBttnActivna(bool: isEmptyTF())
    }
    
    @IBAction func passTFChanged(_ sender: UITextField) {
        signInBttnActivna(bool: isEmptyTF())
    }
    
    @IBAction func signInButtonAction(_ sender: UIButton) {
        if let email = UserDefaults.standard.string(forKey: "emailSU"), email == emailTF.text ,
           let pass = UserDefaults.standard.string(forKey: "passSU"), pass == passTF.text {
            
            //saveCredantional()
            saveTokenSwitch()
            performSegue(withIdentifier: "segueToMainApp", sender: nil)
        } else {
            emailOrPassIncorrect.isHidden = false
        }
    }
    
//    unwin для кнопки назад (просто набери unwin)
    @IBAction func unwindToSignIn(_ unwindSegue: UIStoryboardSegue) {
//        let sourceViewController = unwindSegue.source
//         Use data from the view controller which initiated the unwind segue
    }
    
//    проваливаемся в приложение или нет
    private func authorizedOrNot() {
        if checkToken() {
            performSegue(withIdentifier: "segueToMainApp", sender: nil)
        }
    }
    
//    Записываем фиктивный токен
    private func saveCredantional() {
        UserDefaults.standard.set(emailTF.text, forKey: "emailSU")
        UserDefaults.standard.set(passTF.text, forKey: "passSU")
    }
    
    private func saveTokenSwitch() {
        if tokenSwitch.isOn {
            let date = Date()
            UserDefaults.standard.set(date, forKey: "Date")
        }
    }
    
    private func isEmptyTF() -> Bool {
        emailOrPassIncorrect.isHidden = true
        if let emailTFText = emailTF.text, let passTFText = passTF.text {   //пытаемся вытащить текст из TextField
            return !emailTFText.isEmpty && !passTFText.isEmpty              //проверяем - неПустой и неПустой = true
        } else {
            return false
        }
    }
    
    private func checkToken() -> Bool {
        //Если мы смогли вытащить значение и привести к Date
        if let tempDate = UserDefaults.standard.object(forKey: "Date") as? Date,
           let earlyDate = Calendar.current.date(
            byAdding: .minute,
            value: -60,
            to: Date()) {
            return earlyDate <= tempDate
        } else {
            return false
        }
    }
    
    private func setMyDesign() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.navigationBar.tintColor = .red
        navigationController?.navigationBar.alpha = 0
        
        emailOrPassIncorrect.isHidden = true
        
        signInButton.layer.cornerRadius = 20
        signInButton.backgroundColor = .red
        signInButton.setTitleColor(.white, for: .normal)
        signInButton.alpha = 0.3
        signInButton.isEnabled = false
        
        tokenSwitch.isOn = false
        saveToken.isEnabled = false
        
        emailTF.layer.cornerRadius = 15
        emailTF.layer.borderWidth = 0.1
        emailTF.clipsToBounds = true
        
        passTF.layer.cornerRadius = 15
        passTF.layer.borderWidth = 0.1
        passTF.clipsToBounds = true
        
        saveEmail.isHidden = true
        savePass.isHidden = true
    }

    //Проверка на корректность emaila (находиться в stackoverflow)
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

    //Скрыть панель навигации на контроллере этого вида
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.setNavigationBarHidden(true, animated: animated)
//    }
    
    //Кнопка входа появляется/скрывается
    private func signInBttnActivna(bool: Bool) {
        signInButton.alpha = bool ? 1 : 0.3
        signInButton.isEnabled = bool
    }
    
    //показывает наши сохранненые email u password
    private func showEmailAndPass() {
        if let email = UserDefaults.standard.string(forKey: "emailSU") {
            saveEmail.text = email
            saveEmail.isHidden = false
            saveEmail.textColor = .lightGray
        }
        if let pass = UserDefaults.standard.string(forKey: "passSU") {
            savePass.text = pass
            savePass.isHidden = false
            savePass.textColor = .lightGray
        }
    }
}
