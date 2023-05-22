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
    private var myFriendsArray = ["Andrey", "Boris", "Vlad", "Galina", "Evgenia"]

    //MARK: -  Lyfe cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "My Friends"
        setUpView()
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
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(myFriendsTableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            myFriendsTableView.topAnchor.constraint(equalTo: view.topAnchor),
            myFriendsTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            myFriendsTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            myFriendsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
}

// MARK: - extension UITableViewDataSource

extension MyFriendsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myFriendsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.customTableViewCellReuseIdentifier) as? CustomTableViewCell else { return UITableViewCell() }
        if indexPath.row % 2 == 0 {
            cell.configure(image: UIImage(named: "lynx"), name: myFriendsArray[indexPath.row], description: "Wild animal")
        } else {
            cell.configure(image: UIImage(named: "cat"), name: myFriendsArray[indexPath.row], description: "Home animal")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForCellTableView
    }
}

// MARK: - extension UITableViewDelegate

extension MyFriendsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? CustomTableViewCell else { return }
        print(cell.nameLabel.text ?? "no name")
    }
}
