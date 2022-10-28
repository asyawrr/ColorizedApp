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
        
        coloredView.layer.cornerRadius = 10
                
        coloredView.backgroundColor = UIColor(
            red: CGFloat(redColorSlider.value),
            green: CGFloat(greenColorSlider.value),
            blue: CGFloat(blueColorSlider.value),
            alpha: 1
        )
        
        setupLabel(for: redColorLabel, greenColorLabel, blueColorLabel)

    }
    
    // MARK: IB Actions
    @IBAction func changeRGB(_ sender: UISlider) {
        changeColor()
        switch sender{
        case redColorSlider:
            setupLabel(for: redColorLabel)
        case greenColorSlider:
            setupLabel(for: greenColorLabel)
        default:
            setupLabel(for: blueColorLabel)
        }
    }
    
    // MARK: private methods
    
    private func setupLabel(for labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case redColorLabel:
                label.text = formatToString(from: redColorSlider)
            case greenColorLabel:
                label.text = formatToString(from: greenColorSlider)
            default:
                label.text = formatToString(from: blueColorSlider)
            }
        }
    }
    
    private func changeColor() {
        let red = CGFloat(redColorSlider.value)
        let green = CGFloat(greenColorSlider.value)
        let blue = CGFloat(blueColorSlider.value)
        
        let color = UIColor(red: red, green: green, blue: blue, alpha: 1)
        coloredView.backgroundColor = color
    }
    
    private func formatToString(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
}

