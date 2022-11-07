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
    
    @IBOutlet var redTF: UITextField!
    @IBOutlet var greenTF: UITextField!
    @IBOutlet var blueTF: UITextField!
    
    @IBOutlet var toolbar: UIToolbar!
    
    @IBOutlet var coloredView: UIView!
    
    // MARK: public properties
    var backgroundColor: UIColor!
    var delegate: SettingsViewControllerDelegate!
    
    // MARK: override functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coloredView.layer.cornerRadius = 10
        
        coloredView.backgroundColor = backgroundColor
        
        setSliderValue(for: redColorSlider,
                       greenColorSlider,
                       blueColorSlider)
        
        setupLabel(for: redColorLabel,
                   greenColorLabel,
                   blueColorLabel)
        
        setupTextField(for: redTF, greenTF, blueTF)
        
        redTF.delegate = self
        greenTF.delegate = self
        blueTF.delegate = self
        
        inputAccessoryTextField(for: redTF, greenTF, blueTF)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: IB Actions
    @IBAction func changeRGB(_ sender: UISlider) {
        changeColor()
        switch sender{
        case redColorSlider:
            setupLabel(for: redColorLabel)
            setupTextField(for: redTF)
        case greenColorSlider:
            setupLabel(for: greenColorLabel)
            setupTextField(for: greenTF)
        default:
            setupLabel(for: blueColorLabel)
            setupTextField(for: blueTF)
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem){
        view.endEditing(true)
        delegate.setColor(for: backgroundColor)
        dismiss(animated: true)
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        view.endEditing(true)
        delegate.setColor(for: backgroundColor)
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
    
    private func setupTextField(for textFields: UITextField...) {
        textFields.forEach { textField in
            switch textField {
            case redTF:
                textField.text = formatToString(from: redColorSlider)
            case greenTF:
                textField.text = formatToString(from: greenColorSlider)
            default:
                textField.text = formatToString(from: blueColorSlider)
            }
        }
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
    
    private func inputAccessoryTextField(for textFields: UITextField...) {
        textFields.forEach{ textField in
            switch textField{
            case redTF:
                redTF.inputAccessoryView = toolbar
            case greenTF:
                greenTF.inputAccessoryView = toolbar
            default:
                blueTF.inputAccessoryView = toolbar
            }
        }
    }
    
    
    
    //    private func setObjectsValue<T>(for stacks: T...){
    //        stacks.forEach {stack in
    //            switch stack {
    //            case is UISlider:
    //                let slider: UISlider!
    //                slider.value = Float(backgroundColor.rgba.red)
    //            case is UILabel:
    //                let label: UILabel!
    //                label.text = formatToString(from: redColorSlider)
    //            case is UITextField:
    //                let textField: UITextField!
    //                textField.text = formatToString(from: redColorSlider)
    //            default:
    //                return
    //            }
    //
    //        }
    //    }
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

extension SettingsViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let colorValue = textField.text else { return }
        guard let valueFloat = Float(colorValue) else {return}
        
        switch textField{
        case redTF:
            redColorSlider.value = valueFloat
            redColorLabel.text = valueFloat.formatted()
            changeRGB(redColorSlider)
        case greenTF:
            greenColorSlider.value = valueFloat
            greenColorLabel.text = valueFloat.formatted()
            changeRGB(greenColorSlider)
        default:
            blueColorSlider.value = valueFloat
            blueColorLabel.text = valueFloat.formatted()
            changeRGB(blueColorSlider)
        }
    }
    
    
}

