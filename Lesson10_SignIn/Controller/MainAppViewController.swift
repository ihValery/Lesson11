//
//  MainAppViewController.swift
//  Lesson10PersonalityQuiz
//
//  Created by Валерий Игнатьев on 05.02.2021.
//

import UIKit

class MainAppViewController: UIViewController {

    @IBOutlet weak var labelForDate: UILabel!
    @IBOutlet weak var labelForUserDefols: UILabel!
    
    var userModel: UserModel = UserModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setMyDesign()
        // Do any additional setup after loading the view.
    }
    
    private func setMyDesign() {
        labelForDate.text = userModel.email
        labelForUserDefols.text = UserDefaults.standard.string(forKey: "passSU")
    }
    
}
