//
//  RegisterationController.swift
//  InstagramFirebaseDemo
//
//  Created by Pavan More on 08/09/22.
//

import UIKit

class RegistrationController: UIViewController {

    // MARK: - Properties
    private var viewModel = RegisterationViewModel()
    
    private lazy var plusPhotoButon: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleProfilePhotoSelect), for: .touchUpInside)
        button.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
        return button
    }()
    
    private let emailTextField: CustomTextField = {
        let textField = CustomTextField(placeHolder: "Email")
        textField.keyboardType = .emailAddress
        return textField
    }()
    
    private let passwordTextField: CustomTextField = {
        let textField = CustomTextField(placeHolder: "Password")
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let fullNameTextField: CustomTextField = {
        let textField = CustomTextField(placeHolder: "Fullname")
        return textField
    }()
    
    private let userNameTextField: CustomTextField = {
        let textField = CustomTextField(placeHolder: "Username")
        return textField
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        button.layer.cornerRadius = 5
        button.setHeight(50)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        return button
    }()
    
    private lazy var alreadyHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.attributedTitle(firstPart: "Already have an account? ", secondPart: "Log In")
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        return button
    }()
    
    // MARK: - View lift cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        configureGradientLayer()
        
        view.addSubview(plusPhotoButon)
        plusPhotoButon.centerX(inView: view)
        plusPhotoButon.setDimensions(height: 140, width: 140)
        plusPhotoButon.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, fullNameTextField, userNameTextField, signUpButton])
        stackView.axis = .vertical
        stackView.spacing = 20
        
        view.addSubview(stackView)
        stackView.anchor(top: plusPhotoButon.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 28, paddingRight: 28)
        
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.centerX(inView: view)
        alreadyHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleKeyboard)))
        
        configureObservers()
        addKeyboardObservers()
    }
    
    func addKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboard(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboard(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboard(notification:)), name:UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    func configureObservers() {
        emailTextField.addTarget(self, action: #selector(textFieldAction), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldAction), for: .editingChanged)
        fullNameTextField.addTarget(self, action: #selector(textFieldAction), for: .editingChanged)
        userNameTextField.addTarget(self, action: #selector(textFieldAction), for: .editingChanged)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleKeyboard)))
    }
    
    // MARK: - Action methods
    
    @objc func keyboard(notification:Notification) {
        guard let keyboardReact = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else{
            return
        }
        if notification.name == UIResponder.keyboardWillShowNotification ||  notification.name == UIResponder.keyboardWillChangeFrameNotification {
            self.view.frame.origin.y = -keyboardReact.height
        }else{
            self.view.frame.origin.y = 0
        }
    }
    
    @objc func handleShowLogin() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleKeyboard() {
        view.endEditing(true)
    }
    
    @objc func textFieldAction(sender: UITextField) {
        if sender == emailTextField {
            viewModel.email = sender.text
        } else if sender == passwordTextField {
            viewModel.password = sender.text
        } else if sender == userNameTextField {
            viewModel.username = sender.text
        } else {
            viewModel.fullname = sender.text
        }
        updateForm()
    }
    
    @objc func handleProfilePhotoSelect() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
    }
}

// MARK: - FormViewModel

extension RegistrationController: FormViewModel {
    func updateForm() {
        signUpButton.backgroundColor = viewModel.buttonBackgroundColor
        signUpButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
        signUpButton.isEnabled = viewModel.formIsValid
    }
}


// MARK: - UIImagePickerController

extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = info[.editedImage] as? UIImage else {
            return
        }
        
        plusPhotoButon.layer.cornerRadius = plusPhotoButon.frame.width / 2
        plusPhotoButon.layer.masksToBounds = true
        plusPhotoButon.layer.borderWidth = 2
        plusPhotoButon.layer.borderColor = UIColor.white.cgColor
        plusPhotoButon.setImage(selectedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        
        self.dismiss(animated: true)
    }
}
