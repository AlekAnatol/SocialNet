//
//  LoginController.swift
//  SocialNet
//
//  Created by Екатерина Алексеева on 23.04.2023.
//

import UIKit

class LoginController: UIViewController {
    
    //MARK: - Private properties
    
    private var scrollView = UIScrollView()
    private var netImageView = UIImageView()
    private var netLabel = UILabel()
    private var loginLabel = UILabel()
    private var loginTextField = UITextField()
    private var passwordLabel = UILabel()
    private var passwordTextField = UITextField()
    private var loginButton = UIButton()
    
    // Views for loading animation
    private var firstCircleView = UIView()
    private var secondCircleView = UIView()
    private var thirdCircleView = UIView()
    
    //MARK: -  Lyfe cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(tapOnMainView))
        recognizer.cancelsTouchesInView = false
        self.view.addGestureRecognizer(recognizer)
        setUpView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupScrollContetntView()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: - UI - setup
    
    private func setUpView() {
        netImageView = {
            let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0),
                                                      size: CGSize(width: 150, height: 150)))
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.image = UIImage(named: "VK")
            return imageView
        }()
        
        netLabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.systemFont(ofSize: 32.0, weight: .bold)
            label.text = "SocialNet"
            return label
        }()

        loginLabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.systemFont(ofSize: 20.0, weight: .medium)
            label.text = "Login"
            return label
        }()

        loginTextField = {
            let textField = UITextField()
            textField.translatesAutoresizingMaskIntoConstraints = false
            textField.placeholder = "Login"
            textField.borderStyle = .roundedRect
            return textField
        }()
        
        passwordLabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.systemFont(ofSize: 20.0, weight: .medium)
            label.text = "Password"
            return label
        }()
        
        passwordTextField = {
            let textField = UITextField()
            textField.translatesAutoresizingMaskIntoConstraints = false
            textField.placeholder = "Password"
            textField.borderStyle = .roundedRect
            textField.isSecureTextEntry = true
            return textField
        }()
        
        loginButton = {
            let button = UIButton(configuration: .filled())
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setTitle("Log In", for: .normal)
            button.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
            return button
        }()
        
        firstCircleView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .systemBlue
            view.layer.cornerRadius = 20
            return view
        }()
        
        secondCircleView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .systemBlue
            view.layer.cornerRadius = 20
            view.alpha = 0.5
            return view
        }()
        
        thirdCircleView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .systemBlue
            view.layer.cornerRadius = 20
            view.alpha = 0
            return view
        }()
        createScrollView()
        addSubviews()
        setupConstraints()
        fillDataInStorage()
    }
    
    private func createScrollView() {
        scrollView = UIScrollView(frame: CGRect(origin: CGPoint(x: 0, y: 0),
                                                size: CGSize(width: view.frame.width, height: view.frame.height)))
        scrollView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(netImageView)
        scrollView.addSubview(netLabel)
        scrollView.addSubview(loginLabel)
        scrollView.addSubview(loginTextField)
        scrollView.addSubview(passwordLabel)
        scrollView.addSubview(passwordTextField)
        scrollView.addSubview(loginButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            netImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 30),
            netImageView.widthAnchor.constraint(equalToConstant: 200),
            netImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            netImageView.heightAnchor.constraint(equalTo: netImageView.widthAnchor),
            
            netLabel.topAnchor.constraint(equalTo: netImageView.bottomAnchor, constant: 10),
            netLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            loginLabel.topAnchor.constraint(equalTo: netLabel.bottomAnchor, constant: 15),
            loginLabel.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor, constant: 20),
            loginLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),

            loginTextField.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 8),
            loginTextField.leftAnchor.constraint(equalTo: loginLabel.leftAnchor),
            loginTextField.rightAnchor.constraint(equalTo: loginLabel.rightAnchor),
            
            passwordLabel.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 15),
            passwordLabel.leftAnchor.constraint(equalTo: loginLabel.leftAnchor),
            passwordLabel.rightAnchor.constraint(equalTo: loginLabel.rightAnchor),
            
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 8),
            passwordTextField.leftAnchor.constraint(equalTo: loginLabel.leftAnchor),
            passwordTextField.rightAnchor.constraint(equalTo: loginLabel.rightAnchor),
            
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 25),
            loginButton.centerXAnchor.constraint(equalTo: passwordTextField.centerXAnchor),
            ])
        
    }
    
    private func setupScrollContetntView() {
        let loginButtonFrameBottomY = loginButton.frame.maxY
        let frameHeight = view.frame.height + CGFloat(0.1)
        var customHeight = CGFloat()
        loginButtonFrameBottomY > frameHeight ? (customHeight = loginButtonFrameBottomY) : (customHeight = frameHeight)
        scrollView.contentSize = CGSize(width: view.frame.width, height: customHeight)
    }
    
    private func fillDataInStorage() {
        let group1 = Group(name:  "tiny tigers", avatar:  "tigers", description:  "tigers")
        let group2 = Group(name: "pussy cats", avatar: "cats", description: "cats")
        let group3 = Group(name: "little goats", avatar: "goats", description: "goats")
        StorageSingleton.share.allGroupsArray.append(group1)
        StorageSingleton.share.allGroupsArray.append(group2)
        StorageSingleton.share.allGroupsArray.append(group3)
        
        let friend1 = Friend(name: "Anna", avatar: "Anna", fotos: ["1", "2", "3", "4", "5", "6", "7"])
        let friend2 = Friend(name: "Galina", avatar: "Galina", fotos: ["5", "6", "7"])
        let friend3 = Friend(name: "Ruslana", avatar: "Ruslana", fotos: ["1", "2"])
        StorageSingleton.share.myFriendsSource.append(friend1)
        StorageSingleton.share.myFriendsSource.append(friend2)
        StorageSingleton.share.myFriendsSource.append(friend3)
    }
    
    //MARK: -  Actions
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let keyboardHeight = ((notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue)?.height else { return }
        let loginButtonFrameBottomY = loginButton.frame.maxY
        let differenceHeight = view.frame.height - keyboardHeight
        var insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        if differenceHeight < loginButtonFrameBottomY {
            insets.bottom = loginButtonFrameBottomY - differenceHeight
        }
        scrollView.contentInset = insets
        scrollView.scrollIndicatorInsets = insets
    }
    
    @objc private func keyboardWillHide() {
        scrollView.contentInset = UIEdgeInsets.zero
        scrollView.scrollIndicatorInsets = UIEdgeInsets.zero
    }
    
    @objc private func tapOnMainView() {
        self.view.endEditing(true)
    }
    
    @objc private func loginButtonPressed() {
        guard let login = self.loginTextField.text,
              let password = self.passwordTextField.text else {
            print("no login/password data")
            return
        }
        //checkLoginPassword(login, password) ? animateTransitionToNextViewController() : showAlertController()
        animateTransitionToNextViewController()
    }
    
    // MARK: - Private functions
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        setupConstraints()
        setupScrollContetntView()
    }
    
    private func checkLoginPassword(_ login: String, _ password: String) -> Bool {
        return (login == "Login" && password == "12345") ? true : false
    }
    
    private func transitionToNextViewController() {
        let tabBarController = UITabBarController()
        let myFriendsController = MyFriendsController()
        let myGroupsController = MyGroupsController()
        let myFriendsNavigationController = UINavigationController(rootViewController: myFriendsController)
        let myGroupsNavigationController = UINavigationController(rootViewController: myGroupsController)
        tabBarController.setViewControllers([myFriendsNavigationController, myGroupsNavigationController], animated: false)
        tabBarController.tabBar.tintColor = .systemBlue
        tabBarController.tabBar.backgroundColor = .white
        //tabBarController.selectedIndex = 1
        guard let items = tabBarController.tabBar.items else {
            return
        }
        items[0].image = UIImage(systemName: "person")
        items[1].image = UIImage(systemName: "person.2")
        items[0].title = "My Friends"
        items[1].title = "My Groups"
        tabBarController.modalPresentationStyle = .fullScreen
        tabBarController.modalTransitionStyle = .crossDissolve
        present(tabBarController, animated: true)
    }
    
    private func showAlertController() {
        let alertController = UIAlertController(title: "Ошибка",
                                           message: "Неверные логин/пароль",
                                           preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .cancel)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true)
    }
    
    private func animateTransitionToNextViewController() {
        hideAllViews()
        addCircleViews()
        setUpCircleViews()
        animateCircleViews(totalCount: 3)
    }
    
    private func hideAllViews() {
        scrollView.isHidden = true
        netImageView.isHidden = true
        netLabel.isHidden = true
        loginLabel.isHidden = true
        loginTextField.isHidden = true
        passwordLabel.isHidden = true
        passwordTextField.isHidden = true
        loginButton.isHidden = true
    }
    
    private func addCircleViews() {
        view.addSubview(firstCircleView)
        view.addSubview(secondCircleView)
        view.addSubview(thirdCircleView)
    }

    private func setUpCircleViews() {
        NSLayoutConstraint.activate([
            secondCircleView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            secondCircleView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            secondCircleView.heightAnchor.constraint(equalToConstant: 40),
            secondCircleView.widthAnchor.constraint(equalToConstant: 40),
            
            firstCircleView.centerXAnchor.constraint(equalTo: secondCircleView.centerXAnchor, constant: -80),
            firstCircleView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            firstCircleView.heightAnchor.constraint(equalToConstant: 40),
            firstCircleView.widthAnchor.constraint(equalToConstant: 40),
            
            thirdCircleView.centerXAnchor.constraint(equalTo: secondCircleView.centerXAnchor, constant: 80),
            thirdCircleView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            thirdCircleView.heightAnchor.constraint(equalToConstant: 40),
            thirdCircleView.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func  animateCircleViews(totalCount: Int, currentCount: Int = 0) {
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.firstCircleView.alpha = 1
            self?.secondCircleView.alpha = 0.5
            self?.thirdCircleView.alpha = 0
        } completion: { [weak self] _ in
            UIView.animate(withDuration: 0.3) {
                self?.firstCircleView.alpha = 0.5
                self?.secondCircleView.alpha = 1
                self?.thirdCircleView.alpha = 0.5
            } completion: { [weak self] _ in
                UIView.animate(withDuration: 0.3) {
                    self?.firstCircleView.alpha = 0
                    self?.secondCircleView.alpha = 0.5
                    self?.thirdCircleView.alpha = 1
                } completion: { [weak self] _ in
                    UIView.animate(withDuration: 0.3) {
                        self?.firstCircleView.alpha = 0.5
                        self?.secondCircleView.alpha = 0
                        self?.thirdCircleView.alpha = 0.5
                    } completion: { [weak self] _ in
                        currentCount == totalCount ? self?.transitionToNextViewController() : self?.animateCircleViews(totalCount: totalCount, currentCount: currentCount + 1)
                    }
                }
            }
        }
    }
}
