//
//  ViewController.swift
//  ColorizedApp
//
//  Created by Asya Sher on 27.10.2022.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: IB Outlets
    
    @IBOutlet var blueColorSlider: UISlider!
    @IBOutlet var greenColorSlider: UISlider!
    @IBOutlet var redColorSlider: UISlider!
    
    @IBOutlet var blueColorLabel: UILabel!
    @IBOutlet var greenColorLabel: UILabel!
    @IBOutlet var redColorLabel: UILabel!
    
    @IBOutlet var coloredView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coloredView.backgroundColor = .white
        
        setupSlider(redColorSlider)
        setupSlider(greenColorSlider)
        setupSlider(blueColorSlider)
        
        setupLabel(label: redColorLabel, slider: redColorSlider)
        setupLabel(label: greenColorLabel, slider: greenColorSlider)
        setupLabel(label: blueColorLabel, slider: blueColorSlider)
        
    }
    
    // MARK: IB Actions
    @IBAction func changeRedColor() {
        changeColor(slider: redColorSlider, label: redColorLabel)
    }
    
    @IBAction func changeGreenColor() {
        changeColor(slider: greenColorSlider, label: greenColorLabel)
    }
    
    @IBAction func changeBlueColor() {
        changeColor(slider: blueColorSlider, label: blueColorLabel)
    }
    
    // MARK: private methods
    
    private func setupSlider(_ slider: UISlider){
        slider.value = 1
        slider.minimumValue = 0
        slider.maximumValue = 1
    }
    
    private func setupLabel(label: UILabel, slider: UISlider) {
        label.text = String(slider.value)
    }
    
    private func changeColor(slider: UISlider, label: UILabel) {
        let red = CGFloat(redColorSlider.value)
        let green = CGFloat(greenColorSlider.value)
        let blue = CGFloat(blueColorSlider.value)
        
        label.text = String(round(slider.value * 100) / 100)
        
        let color = UIColor(red: red, green: green, blue: blue, alpha: 1)
        coloredView.backgroundColor = color
    }
    
}

