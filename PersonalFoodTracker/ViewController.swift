//
//  ViewController.swift
//  PersonalFoodTracker
//
//  Created by Marco Caliò on 20/10/2020.
//  Copyright © 2020 Marco Caliò. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var userdefault = UserDefaults()
    @IBOutlet weak var welcomeBack: UILabel!
    @IBOutlet weak var paramView: UIView!
    @IBOutlet weak var kcalLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var name: String?
    var kcal: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate  = self
        buildUI()
    }
    
    func buildUI() {
        self.title="Home"
        paramView.layer.cornerRadius=21
        let bookmarksButton = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(bookmarksAction))
        navigationItem.rightBarButtonItems = [bookmarksButton]
    }
    
    @objc
    func bookmarksAction() {
        print("Mostra prefe")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if !(userdefault.bool(forKey: "firstLoad")) {
            performSegue(withIdentifier: "onBoarding", sender: nil)
            userdefault.set(true, forKey: "firstLoad")
        } else {
            name = userdefault.string(forKey: "userName")
            kcal = userdefault.double(forKey: "userKcal")
            if let notOpationalName = name {
                welcomeBack.text = "Bentornato \(String(describing: notOpationalName)) 💪"
                self.name=notOpationalName
            }
            else {
                welcomeBack.text = "Bentornato  💪"
            }
            kcalLabel.text = "\(String(describing: kcal!)) kcal"
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? OnBoardingViewController {
            viewController.delegate = self
        }
    }
}
extension ViewController: onBoardingDelegate {
    
    func passDataBack(person: Person) {
        self.name=person.name
        self.kcal=person.kcal
        welcomeBack.text = "Bentornato \(String(describing: self.name!)) 💪"
        kcalLabel.text = "\(String(describing: kcal!)) kcal"
        userdefault.set(self.name, forKey: "userName")
        userdefault.set(self.kcal, forKey: "userKcal")
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! CustomCellViewController
        cell.macro.text = "1"
        cell.nomeCibo.text = "CIBO"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Hai cliccato \(indexPath.row) ")
    }
    
    
}

