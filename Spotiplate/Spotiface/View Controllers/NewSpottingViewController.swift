//
//  NewSpottingViewController.swift
//  Spotiface
//
//  Created by Simon Ljungberg on 2017-10-07.
//  Copyright © 2017 Simon Ljungberg. All rights reserved.
//

import Foundation
import UIKit

public final class NewSpottingViewController: UIViewController {
    
    // MARK: Properties
    
    private var number: Int
    private var letters: String?
    public weak var delegate: NewSpottingViewControllerDelegate?
    
    private var initialToggleState: Bool

    // MARK: Initialization
    
    public init(number: Int, isLocationToggled: Bool = false) {
        self.number = number
        self.initialToggleState = isLocationToggled
        super.init(nibName: nil, bundle: nil)
        self.title = "Record New Spotting"
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: View Controller Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalTo: stackView.widthAnchor, constant: -32),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }

    // MARK: Views
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.addArrangedSubview(self.labelStackView)
        stackView.addArrangedSubview(self.locationToggleStack)
        stackView.addArrangedSubview(self.textField)
        stackView.addArrangedSubview(self.saveButton)
        return stackView
    }()
    
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(self.lettersInput)
        stackView.addArrangedSubview(self.numbersLabel)
        stackView.spacing = 8
        stackView.axis = .horizontal
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var numbersLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = String(format: "%03d", self.number)
        return label
    }()
    
    private lazy var lettersInput: UITextField = {
        let input = UITextField()
        input.translatesAutoresizingMaskIntoConstraints = false
        input.placeholder = "ABC"
        return input
    }()
    
    private lazy var locationToggleStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 32
        stackView.addArrangedSubview(self.locationToggleLabel)
        stackView.addArrangedSubview(self.locationToggle)
        return stackView
    }()
    
    private lazy var locationToggleLabel: UILabel = {
        let label = UILabel()
        label.text = "Save spotting location"
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        return label
    }()
    
    private lazy var locationToggle: UISwitch = {
        let toggle = UISwitch()
        toggle.addTarget(self, action: #selector(toggleLocation), for: .valueChanged)
        toggle.isOn = self.initialToggleState
        return toggle
    }()
    
    private lazy var textField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.heightAnchor.constraint(equalToConstant: 128).isActive = true
        field.borderStyle = .line
        field.layer.borderColor = UIColor.black.cgColor
        field.placeholder = "Notes…"
        field.contentVerticalAlignment = .top
        return field
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(saveSpotting), for: .touchUpInside)
        return button
    }()
    
    // MARK: User Actions
    
    @objc public func toggleLocation(sender: UISwitch) {
        delegate?.storeLocationToggled(on: sender.isOn)
    }
    
    @objc public func saveSpotting() {
        let letters = (lettersInput.text ?? "").isEmpty ? nil : lettersInput.text
        delegate?.saveSpotting(withNumbers: number,
                               letters: letters,
                               storeLocation: locationToggle.isOn,
                               notes: textField.text)
    }
}

// MARK: Delegate Protocol

public protocol NewSpottingViewControllerDelegate: class {
    func saveSpotting(withNumbers numbers: Int, letters: String?, storeLocation: Bool, notes: String?)
    func storeLocationToggled(on: Bool)
}
