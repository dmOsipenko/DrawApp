import UIKit
import PencilKit

class DrawViewController: UIViewController {
    
    let canvasView: CanvasView = {
        let view = CanvasView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    let toolPicker = PKToolPicker.init()


    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        setupBarButtonItem()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setUpPencilKit()
    }

   private func setUpPencilKit() {
        toolPicker.setVisible(true, forFirstResponder: canvasView)
        toolPicker.addObserver(canvasView)
        toolPicker.isRulerActive = false
        canvasView.isOpaque = true
        canvasView.delegate = self
        canvasView.drawingPolicy = .anyInput
        canvasView.becomeFirstResponder()
    }
    
    private func setupBarButtonItem() {
        let undo = UIBarButtonItem(image: UIImage(named: "left")?.resizeTo(size: CGSize(width: 25, height: 25)), style: .plain, target: self, action: #selector(tapUndo))
           
        let redo = UIBarButtonItem(image: UIImage(named: "right")?.resizeTo(size: CGSize(width: 25, height: 25)), style: .plain, target: self, action: #selector(tapRedo))
        undo.tintColor = .darkGray
        redo.tintColor = .darkGray
        navigationItem.leftBarButtonItems = [undo, redo]
        let settings = UIBarButtonItem(image: UIImage(named: "settings")?.resizeTo(size: CGSize(width: 25, height: 25)), style: .plain, target: self, action: #selector(tapSettings))
        settings.tintColor = .darkGray
        navigationItem.rightBarButtonItem = settings
    }
    
    @objc func tapUndo() {
        canvasView.undoManager?.undo()
    }
    
    @objc func tapRedo() {
        canvasView.undoManager?.redo()
    }
    
    @objc func tapSettings() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Скачать", style: .default, handler: { [weak self] _ in
            PhotoLibraryManager.shared.saveImage(canvasView: self?.canvasView ?? CanvasView()) { success, error in
                DispatchQueue.main.async {
                    self?.showAlert(success: success)
                }
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Удалить", style: .default, handler: { [weak self] _ in
            self?.canvasView.drawing = PKDrawing()
        }))
        
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        present(alert, animated: true)
    }
    
    func showAlert(success: Bool) {
        let alert = UIAlertController(title: success ? "Отлично" : "Ошибка", message: success ? "Ваше изображение сохранено" : "Ваше изображение не удалось сохранить", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Окей", style: .default))
        present(alert, animated: true)
    }
}

extension DrawViewController: PKToolPickerObserver, PKCanvasViewDelegate {

     func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
       print("1111")
         if let inkingTool = toolPicker.selectedTool as? PKInkingTool {
             let color = inkingTool.color
             print(color)
         }
    }

     func canvasViewDidFinishRendering(_ canvasView: PKCanvasView) {
        print("22")
    }

     func canvasViewDidBeginUsingTool(_ canvasView: PKCanvasView) {
        print("333")
    }

     func canvasViewDidEndUsingTool(_ canvasView: PKCanvasView) {
        print("444")
    }
}

extension DrawViewController {
    private func setupConstraints() {
        view.addSubview(canvasView)
        
        NSLayoutConstraint.activate([
            canvasView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            canvasView.leftAnchor.constraint(equalTo: view.leftAnchor),
            canvasView.rightAnchor.constraint(equalTo: view.rightAnchor),
            canvasView.topAnchor.constraint(equalTo: view.topAnchor)
        ])
    }
}

extension UIView {
    func shadowView() {
       layer.shadowColor = UIColor.black.cgColor
       layer.shadowOffset = CGSize(width: 0, height: 0.3)
       layer.shadowOpacity = 0.15
       layer.shadowRadius = 4.0
    }
}

extension UIImage {
    func resizeTo(size: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        let image = renderer.image { _ in
            self.draw(in: CGRect.init(origin: CGPoint.zero, size: size))
        }
        
        return image.withRenderingMode(self.renderingMode)
    }
}

