//
//  ViewController.swift
//  ColorizedApp
//
//  Created by Asya Sher on 27.10.2022.
//

import UIKit


class SettingsViewController: UIViewController {
    
    // MARK: IB Outlets
    
    @IBOutlet var blueColorSlider: UISlider!
    @IBOutlet var greenColorSlider: UISlider!
    @IBOutlet var redColorSlider: UISlider!
    
    @IBOutlet var blueColorLabel: UILabel!
    @IBOutlet var greenColorLabel: UILabel!
    @IBOutlet var redColorLabel: UILabel!
    
    @IBOutlet var coloredView: UIView!
    
    // MARK: public properties
    var backgroundColor: UIColor!
    var delegate: SettingsViewControllerDelegate!
    
    // MARK: override functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coloredView.layer.cornerRadius = 10
        
        coloredView.backgroundColor = backgroundColor
        setSliderValue(for: redColorSlider, greenColorSlider, blueColorSlider)
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
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem){
        delegate.setColor(for: backgroundColor)
        dismiss(animated: true)
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
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
        backgroundColor = color
    }
    
    private func formatToString(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    private func setSliderValue(for sliders: UISlider...) {
        sliders.forEach { slider in
            switch slider {
            case redColorSlider:
                slider.value = Float(backgroundColor.rgba.red)
            case greenColorSlider:
                slider.value = Float(backgroundColor.rgba.green)
            default:
                slider.value = Float(backgroundColor.rgba.blue)
            }
        }
    }
}

// MARK: extensions

extension UIColor {
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        return (red, green, blue, alpha)
    }
}

