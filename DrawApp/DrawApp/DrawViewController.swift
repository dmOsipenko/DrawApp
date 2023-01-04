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
        slider.minimumValue = 1
        slider.maximumValue = 10
        slider.value = 1
        slider.minimumTrackTintColor = .orange
        slider.thumbTintColor = .orange
        return slider
    }()
    
    let colorView: UIColorWell = {
        let view = UIColorWell()
        view.supportsAlpha = false
        view.selectedColor = .orange
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 25
        view.backgroundColor = .white
        return view
    }()
    
    let mainView: CanvasView = {
        let view = CanvasView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    @objc func tapClean() {
        mainView.clear()
    }
    
    @objc func tapCancel() {
        mainView.undo()
    }
    
    @objc func tapSave() {
      print("tap save")
    }
    
    @objc func tapColorView() {
        print("JJJJJ")
        mainView.setStrokeColor(color: colorView.selectedColor ?? .black)
        colorSlider.minimumTrackTintColor = colorView.selectedColor
        colorSlider.thumbTintColor = colorView.selectedColor
    }
    
    @objc func tapSlider() {
        mainView.setStrokeWidth(width: colorSlider.value)
    }
}

extension DrawViewController {
    private func setupConstraints() {
        view.addSubview(mainView)
        
        NSLayoutConstraint.activate([
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mainView.leftAnchor.constraint(equalTo: view.leftAnchor),
            mainView.rightAnchor.constraint(equalTo: view.rightAnchor),
            mainView.topAnchor.constraint(equalTo: view.topAnchor)
        ])
        
        mainView.addSubview(saveButton)
        saveButton.addTarget(self, action: #selector(tapSave), for: .touchUpInside)
        NSLayoutConstraint.activate([
            saveButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            saveButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            saveButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            saveButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        mainView.addSubview(colorSlider)
        colorSlider.addTarget(self, action: #selector(tapSlider), for: .touchUpInside)
        NSLayoutConstraint.activate([
            colorSlider.bottomAnchor.constraint(equalTo: saveButton.topAnchor, constant: -30),
            colorSlider.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            colorSlider.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            colorSlider.widthAnchor.constraint(equalToConstant: view.frame.size.width - 100)
        ])
        
        mainView.addSubview(cancelButton)
        cancelButton.addTarget(self, action: #selector(tapCancel), for: .touchUpInside)
        NSLayoutConstraint.activate([
            cancelButton.bottomAnchor.constraint(equalTo: colorSlider.topAnchor, constant: -25),
            cancelButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            cancelButton.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        mainView.addSubview(cleanButton)
        cleanButton.addTarget(self, action: #selector(tapClean), for: .touchUpInside)
        NSLayoutConstraint.activate([
            cleanButton.bottomAnchor.constraint(equalTo: colorSlider.topAnchor, constant: -25),
            cleanButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            cleanButton.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        mainView.addSubview(colorView)
        colorView.addTarget(self, action: #selector(tapColorView), for: .valueChanged)
        NSLayoutConstraint.activate([
            colorView.bottomAnchor.constraint(equalTo: colorSlider.topAnchor, constant: -15),
            colorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            colorView.widthAnchor.constraint(equalToConstant: 50),
            colorView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
