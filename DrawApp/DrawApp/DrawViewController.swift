//
//  DrawViewController.swift
//  DrawApp
//
//  Created by Дмитрий Осипенко on 4.01.23.
//

import UIKit

class DrawViewController: UIViewController {

    let cleanButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Очистить", for: .normal)
        button.setTitleColor(UIColor.lightGray, for: .normal)
        return button
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Отменить", for: .normal)
        button.setTitleColor(UIColor.lightGray, for: .normal)
        return button
    }()
    
    let saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Сохранить", for: .normal)
        button.setTitleColor(UIColor.lightGray, for: .normal)
        return button
    }()
    
    let colorSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.thumbTintColor = .white
        return slider
    }()
    
    let colorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 25
        view.backgroundColor = .black
        return view
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setGradientBackground()
    }
    
    @objc func tapClean() {
      print("tap claen")
    }
    
    @objc func tapCancel() {
      print("tap cancel")
    }
    
    @objc func tapSave() {
      print("tap save")
    }
    
    func setGradientBackground() {
        let fistColor = UIColor.orange
        let lastColor = UIColor.purple
        let gradient = CAGradientLayer(start: .topLeft, end: .topRight, colors: [fistColor.cgColor, lastColor.cgColor], type: .axial)
        gradient.frame = colorView.bounds
        gradient.cornerRadius = 25
        colorView.layer.cornerRadius = 25
        colorView.layer.addSublayer(gradient)
    }
}

extension DrawViewController {
    private func setupConstraints() {
        view.backgroundColor = .white
        view.addSubview(saveButton)
        saveButton.addTarget(self, action: #selector(tapSave), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            saveButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            saveButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            saveButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            saveButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        view.addSubview(colorSlider)
        NSLayoutConstraint.activate([
            colorSlider.bottomAnchor.constraint(equalTo: saveButton.topAnchor, constant: -30),
            colorSlider.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            colorSlider.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            colorSlider.widthAnchor.constraint(equalToConstant: view.frame.size.width - 100)
        ])
        
        view.addSubview(cancelButton)
        cancelButton.addTarget(self, action: #selector(tapCancel), for: .touchUpInside)
        NSLayoutConstraint.activate([
            cancelButton.bottomAnchor.constraint(equalTo: colorSlider.topAnchor, constant: -25),
            cancelButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            cancelButton.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        view.addSubview(cleanButton)
        cleanButton.addTarget(self, action: #selector(tapClean), for: .touchUpInside)
        NSLayoutConstraint.activate([
            cleanButton.bottomAnchor.constraint(equalTo: colorSlider.topAnchor, constant: -25),
            cleanButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            cleanButton.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        view.addSubview(colorView)
        NSLayoutConstraint.activate([
            colorView.bottomAnchor.constraint(equalTo: colorSlider.topAnchor, constant: -15),
            colorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            colorView.widthAnchor.constraint(equalToConstant: 50),
            colorView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
