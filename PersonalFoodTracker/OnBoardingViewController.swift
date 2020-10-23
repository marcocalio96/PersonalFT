//
//  OnBoardingViewController.swift
//  PersonalFoodTracker
//
//  Created by Marco Caliò on 20/10/2020.
//  Copyright © 2020 Marco Caliò. All rights reserved.
//

import UIKit
class OnBoardingViewController: UIViewController {
    @IBOutlet weak var caloriesText: UITextField!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var forwardButton: UIButton!
    var  delegate : onBoardingDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func foreward(_ sender: Any) {
        guard let name = nameText.text else {return}
        guard let kcal = caloriesText.text, let number = Double(kcal) else {return}
        let person = Person(name: name, kcal: number)
        dismiss(animated: true) {
            self.delegate?.passDataBack(person: person)
        }
    }
    
}

protocol onBoardingDelegate {
    func passDataBack (person : Person)
}
