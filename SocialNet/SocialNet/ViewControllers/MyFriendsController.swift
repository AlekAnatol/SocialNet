//
//  MyFriendsController.swift
//  SocialNet
//
//  Created by Екатерина Алексеева on 13.04.2023.
//

import UIKit

class MyFriendsController: UIViewController {
    
    //MARK: - Private properties
    
    private var myFriendsTableView = UITableView()
    private var searchBar = UISearchBar()

    //MARK: -  Lyfe cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "My Friends"
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(tapOutOfSearchBar))
        recognizer.cancelsTouchesInView = false
        self.view.addGestureRecognizer(recognizer)
        StorageSingleton.share.myFriendsArray = StorageSingleton.share.myFriendsSource
        setUpView()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: - UI - setup
    
    private func setUpView() {
        myFriendsTableView = {
            let tableView = UITableView()
            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: CustomTableViewCell.customTableViewCellReuseIdentifier)
            tableView.dataSource = self
            tableView.delegate = self
            return tableView
        }()
        searchBar = {
            let searchBar = UISearchBar()
            searchBar.translatesAutoresizingMaskIntoConstraints = false
            searchBar.delegate = self
            return searchBar
        }()
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(myFriendsTableView)
        view.addSubview(searchBar)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            searchBar.rightAnchor.constraint(equalTo: view.rightAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 50),
            
            myFriendsTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            myFriendsTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            myFriendsTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            myFriendsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
    
    //MARK: -  Actions
    
    @objc private func tapOutOfSearchBar() {
        self.view.endEditing(true)
    }
    
    @objc private func keyboardWillShow(_ notification: NSNotification) {
        guard let heightOfKeyboard = ((notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue)?.height else { return }
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: heightOfKeyboard, right: 0)
        myFriendsTableView.contentInset = insets
        myFriendsTableView.scrollIndicatorInsets = insets
    }
    
    @objc private func keyboardWillHide() {
        myFriendsTableView.contentInset = UIEdgeInsets.zero
        myFriendsTableView.scrollIndicatorInsets = UIEdgeInsets.zero
    }
}

// MARK: - extension UITableViewDataSource

extension MyFriendsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StorageSingleton.share.myFriendsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.customTableViewCellReuseIdentifier) as? CustomTableViewCell else { return UITableViewCell() }
        cell.configure(friend: StorageSingleton.share.myFriendsArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForCellTableView
    }
}

// MARK: - extension UITableViewDelegate

extension MyFriendsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedFriend = StorageSingleton.share.myFriendsArray[indexPath.row]
        let galleryController = GalleryController()
        galleryController.configure(photos: selectedFriend.fotos)
        self.navigationController?.pushViewController(galleryController, animated: true)
    }
}


// MARK: - extension UISearcBarDelegate

extension MyFriendsController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            StorageSingleton.share.myFriendsArray = StorageSingleton.share.myFriendsSource
        } else {
            StorageSingleton.share.myFriendsArray = StorageSingleton.share.myFriendsSource.filter({ myFriendsSourceItem in
                myFriendsSourceItem.name.lowercased().contains(searchText.lowercased())
            })
        }
        myFriendsTableView.reloadData()
    }
}
