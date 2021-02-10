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
    @IBOutlet weak var DateOfBirthLabel: UILabel!
    
    var userModel: UserModel = UserModel()
    
    
    
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let nameTF = nameTF.text else { return }
        guard segue.identifier == "testTempValue" else { return }
        guard let myTEMP = segue.destination as? MainAppViewController else { return }
        myTEMP.myAnketa.name = nameTF
    }
    
    
//    @IBAction func sendDataBttnAction(_ sender: UIButton) {
//
////        if let nameTF = nameTF.text, let surNameTF = surnameTF.text {
////            userModel.anketa?.name = nameTF
////            userModel.anketa?.surName = surNameTF
////            if genderSegmentControl.selectedSegmentIndex == 0 { userModel.anketa?.gender = Gender.man }
////            if genderSegmentControl.selectedSegmentIndex == 1 { userModel.anketa?.gender = Gender.woman }
////            if smokeSwitch.isOn      { userModel.anketa?.isSmoke = true }
////            if vegeterianSwitch.isOn { userModel.anketa?.isVegaterian = true }
////            userModel.anketa?.numOfChildren = Int(stepperChildren.value)
////            userModel.anketa?.dateOfBirth = DateOfBirthLabel.text
////            performSegue(withIdentifier: "fromAnketaToMainApp", sender: nil)
////        }
//
//
//     //   if let nameTF = nameTF.text/*, let surNameTF = surnameTF.text*/ {
//            if let mainAppSB = storyboard?.instantiateViewController(identifier: "sendDataBttnSegue") as? MainAppViewController {
//                mainAppSB.myAnketa.name = "Valery"
//
////                mainAppSB.userModel.anketa?.surName = surNameTF
//////                mainAppSB.userModel.anketa?.gender  = genderSegmentControl.value(forKey: "123")
////                if smokeSwitch.isOn      { mainAppSB.userModel.anketa?.isSmoke = true }
////                if vegeterianSwitch.isOn { mainAppSB.userModel.anketa?.isVegaterian = true }
////                mainAppSB.userModel.anketa?.numOfChildren = Int(stepperChildren.value)
//
//                navigationController?.pushViewController(MainAppSB, animated: true)
//  //       }
//        }
//    }
    
    
    //Крутим барабан. На прямую присвоить нельзя. Запоминаем работаем
    @IBAction func changeDatePicker(_ sender: UIDatePicker) {
        let timeFormatter = DateFormatter()
 
        timeFormatter.dateStyle = .long
        DateOfBirthLabel.text = timeFormatter.string(from: sender.date)
        sendDataButton.isEnabled = true
        sendDataButton.alpha = 1
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
}
