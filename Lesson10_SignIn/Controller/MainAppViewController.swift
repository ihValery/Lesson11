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
    
    var userModel = UserModel()
    var myAnketa = Anketa()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setMyDesign()
        // Do any additional setup after loading the view.
    }
    
    private func setMyDesign() {
        userModel.anketa = myAnketa
        labelForDate.text = userModel.anketa?.name
        labelForUserDefols.text = UserDefaults.standard.string(forKey: "passSU")
    }
    
}
