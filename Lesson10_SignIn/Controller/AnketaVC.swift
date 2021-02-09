//
//  AnketaVC.swift
//  Lesson10
//
//  Created by Валерий Игнатьев on 08.02.2021.
//

import UIKit

class AnketaVC: UIViewController {

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var surnameTF: UITextField!
    @IBOutlet weak var genderSegmentControl: UISegmentedControl!
    @IBOutlet weak var sendDataButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var stepperChildren: UIStepper!
    @IBOutlet weak var numberChildren: UILabel!
    @IBOutlet weak var smokeSwitch: UISwitch!
    @IBOutlet weak var vegeterianSwitch: UISwitch!
    @IBOutlet weak var fillInAllTheFields: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setMyDesign()

        // Do any additional setup after loading the view.
    }
    @IBAction func genderSCChangeed(_ sender: UISegmentedControl) {
        switch genderSegmentControl.selectedSegmentIndex {
        case 0:
            UserDefaults.standard.set("man", forKey: "gender")
        case 1:
            UserDefaults.standard.set("no gender", forKey: "gender")
        case 2:
            UserDefaults.standard.set("wonam", forKey: "gender")
        default:
            break
        }
    }
    @IBAction func sendDataBttnAction(_ sender: UIButton) {
        if let nameTF = nameTF.text, let surNameTF = surnameTF.text {
            if !nameTF.isEmpty && !surNameTF.isEmpty {
                UserDefaults.standard.set(nameTF, forKey: "name")
                UserDefaults.standard.set(surNameTF, forKey: "surname")
                
                if smokeSwitch.isOn {
                    UserDefaults.standard.set("smoke", forKey: "smoke")
                }
                if vegeterianSwitch.isOn {
                    UserDefaults.standard.set("vegan", forKey: "vegeterian")
                }
                
                UserDefaults.standard.set(String(format: "%.0f", stepperChildren.value), forKey: "children")
                sendDataButton.isEnabled = false
                sendDataButton.alpha = 1
            } else {
                fillInAllTheFields.isHidden = false
            }
        }
    }
    
    
    @IBAction func stepperAction(_ sender: UIStepper) {
        switch stepperChildren.value {
        case 0:
            numberChildren.text = ""
        case 1...4:
            numberChildren.text = String(format: "%.0f", stepperChildren.value)
        case 5:
            numberChildren.text = "large family"
        default:
            break
        }
    }
    
    
    private func setMyDesign() {
        skipButton.layer.cornerRadius = 20
        skipButton.backgroundColor = .red
        skipButton.setTitleColor(.white, for: .normal)
        
        sendDataButton.layer.cornerRadius = 20
        sendDataButton.backgroundColor = .red
        sendDataButton.setTitleColor(.white, for: .normal)
        
        skipButton.layer.cornerRadius = 20
        skipButton.backgroundColor = .red
        skipButton.setTitleColor(.white, for: .normal)
        
        genderSegmentControl.layer.cornerRadius = 15
        genderSegmentControl.setTitle("man", forSegmentAt: 0)
        genderSegmentControl.insertSegment(withTitle: "gender", at: 1, animated: false)
        genderSegmentControl.setTitle("woman", forSegmentAt: 2)
        genderSegmentControl.selectedSegmentIndex = 1
        
        stepperChildren.value = 0
        stepperChildren.minimumValue = 0
        stepperChildren.maximumValue = 5
        stepperChildren.layer.cornerRadius = 15
        
        nameTF.layer.cornerRadius = 15
        nameTF.layer.borderWidth = 0.1
        nameTF.clipsToBounds = true
        
        surnameTF.layer.cornerRadius = 15
        surnameTF.layer.borderWidth = 0.1
        surnameTF.clipsToBounds = true
        
        fillInAllTheFields.isHidden = true
        
        sendDataButton.isEnabled = true
        sendDataButton.alpha = 0.3
    }
    
    //Скрыть панель навигации на контроллере этого вида
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

}
