//
//  MainViewController.swift
//  ColorizedApp
//
//  Created by Asya Sher on 06.11.2022.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func setColor(for backgroundColor: UIColor)
}

class MainViewController: UIViewController {
    
    private var backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgroundColor
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navigationVC = segue.destination as? UINavigationController else { return }
        guard let settingsVC = navigationVC.topViewController as? SettingsViewController else { return }
        
        settingsVC.backgroundColor = backgroundColor
        settingsVC.delegate = self
    }
}

// MARK: extensions

extension MainViewController: SettingsViewControllerDelegate{
    func setColor(for backgroundColor: UIColor) {
        view.backgroundColor = backgroundColor
        self.backgroundColor = backgroundColor
    }
}
