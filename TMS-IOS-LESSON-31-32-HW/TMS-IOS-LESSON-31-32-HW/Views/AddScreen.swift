import UIKit

class AddScreenViewController: UIViewController {
    
    private let markTextField = Constructor.createTextField(placeholder: "Enter mark...")
    private let modelTextField = Constructor.createTextField(placeholder: "Enter model...")
    private let yearTextField = Constructor.createTextField(placeholder: "Enter year")
    private let maxSpeedTextField = Constructor.createTextField(placeholder: "Enter max speed")
    private let button = Constructor.createButton(title: "Add")
    private var buttonBottomConstraint_withCloseKB: NSLayoutConstraint?
    private var buttonBottomConstraint_withOpenKB: NSLayoutConstraint?
    private var keyboardHelper: KeyboardHelper?
    
    var reloadData: (() -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
        setupTextFields()
        setupAddButton()
        setupKeyboardHelper()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        markTextField.becomeFirstResponder()
    }
    
    private func setupTextFields() {
        view.addSubview(markTextField)
        view.addSubview(modelTextField)
        view.addSubview(yearTextField)
        view.addSubview(maxSpeedTextField)

        NSLayoutConstraint.activate([
            markTextField.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.9),
            markTextField.heightAnchor.constraint(equalToConstant: 35),
            markTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            markTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            modelTextField.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.9),
            modelTextField.heightAnchor.constraint(equalToConstant: 35),
            modelTextField.topAnchor.constraint(equalTo: markTextField.bottomAnchor, constant: 24),
            modelTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            yearTextField.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.25),
            yearTextField.heightAnchor.constraint(equalToConstant: 35),
            yearTextField.topAnchor.constraint(equalTo: modelTextField.bottomAnchor, constant: 24),
            yearTextField.leftAnchor.constraint(equalTo: modelTextField.leftAnchor),
            
            maxSpeedTextField.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.35),
            maxSpeedTextField.heightAnchor.constraint(equalToConstant: 35),
            maxSpeedTextField.topAnchor.constraint(equalTo: modelTextField.bottomAnchor, constant: 24),
            maxSpeedTextField.rightAnchor.constraint(equalTo: modelTextField.rightAnchor)
        ])
    }
    
    private func setupAddButton() {
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.4),
            button.heightAnchor.constraint(equalToConstant: 40),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        buttonBottomConstraint_withCloseKB = button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32)
        buttonBottomConstraint_withCloseKB?.isActive = true
        
        let action = UIAction {_ in
            
            CoreDataManager.shared.addCar(mark: self.markTextField.text ?? "", model: self.modelTextField.text ?? "", year: self.yearTextField.text ?? "", maxSpeed: self.maxSpeedTextField.text ?? "") {
                print("HEllo")
            }
            self.reloadData?()
            self.dismiss(animated: true, completion: nil)
        }
        button.addAction(action, for: .touchUpInside)
    }
    
    private func setupNavigationBar() {
        let add = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(close))
        navigationItem.rightBarButtonItem = add
    }
    
    private func setupKeyboardHelper() {
        keyboardHelper = KeyboardHelper {  animation, keyboardFrame, duration in
            switch animation {
            case .keyboardWillShow:
                self.buttonBottomConstraint_withCloseKB?.isActive = false
                self.buttonBottomConstraint_withOpenKB = self.button.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -keyboardFrame.height - 32)
                self.buttonBottomConstraint_withOpenKB?.isActive = true
                UIView.animate(withDuration: duration) {
                    self.view.layoutIfNeeded()
                }
            case .keyboardWillHide:
                self.buttonBottomConstraint_withOpenKB?.isActive = false
                self.buttonBottomConstraint_withCloseKB?.isActive = true
                UIView.animate(withDuration: duration) {
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
    
    @objc private func close() {
        dismiss(animated: true, completion: nil)
    }
}
