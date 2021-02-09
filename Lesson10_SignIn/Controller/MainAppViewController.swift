//
//  MainAppViewController.swift
//  Lesson10PersonalityQuiz
//
//  Created by Валерий Игнатьев on 05.02.2021.
//

import UIKit

class MainAppViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        viewWillDisappear(false)

        // Do any additional setup after loading the view.
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}
