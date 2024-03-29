import UIKit

class DetailsScreenViewController: UIViewController {
    private var car: AnyObject?
    private var modelLabel = Constructor.createLabel(text: "Model:")
    private var yearLabel = Constructor.createLabel(text: "Year:")
    private var maxSpeedLabel = Constructor.createLabel(text: "Maximum speed:")
    
    private let deleteButton = Constructor.createButton(title: "Delete")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupLabels()
        setupDeleteButton()
    }
    
    var reloadData: (() -> ())?
    
    func configure(car: CarItem) {
//        navigationItem.title = car.mark.count > 0 ? car.mark.uppercased() : "Details"
        
        self.car = car
        modelLabel.text = "Model: \(car.model.count > 0 ?  car.model : "Unknown")"
        yearLabel.text = "Year: \(car.year.count > 0 ?  car.year : "Unknown")"
        maxSpeedLabel.text = "Maximum speed: \(car.maxSpeed.count > 0 ?  "\(car.maxSpeed) km/h" : "Unknown")"
    }
    
    private func setupLabels() {
        view.addSubview(modelLabel)
        view.addSubview(yearLabel)
        view.addSubview(maxSpeedLabel)
        
        NSLayoutConstraint.activate([
            modelLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            modelLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 123),
            
            yearLabel.leftAnchor.constraint(equalTo: modelLabel.leftAnchor),
            yearLabel.topAnchor.constraint(equalTo: modelLabel.bottomAnchor, constant: 24),
            
            maxSpeedLabel.leftAnchor.constraint(equalTo: modelLabel.leftAnchor),
            maxSpeedLabel.topAnchor.constraint(equalTo: yearLabel.bottomAnchor, constant: 24)
        ])
    }
    
    private func setupDeleteButton() {
        view.addSubview(deleteButton)
        deleteButton.backgroundColor = .systemRed
        deleteButton.tintColor = .white
        
        
        NSLayoutConstraint.activate([
            deleteButton.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.4),
            deleteButton.heightAnchor.constraint(equalToConstant: 40),
            deleteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            deleteButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32)
        ])
        
        let action = UIAction {_ in 
            guard let car = self.car else {return}
            self.navigationController?.popViewController(animated: true)
            DBManager.service.removeCar(car: car) {
                self.reloadData?()
            }
        }
        deleteButton.addAction(action, for: .touchUpInside)
    }
    
}
