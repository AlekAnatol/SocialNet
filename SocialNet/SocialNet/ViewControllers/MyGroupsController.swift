//
//  MyGroupsController.swift
//  SocialNet
//
//  Created by Екатерина Алексеева on 13.04.2023.
//

import UIKit

class MyGroupsController: UIViewController {

    //MARK: - Private properties
    
    private var myGroupsTableView = UITableView()
    private var addButton = UIBarButtonItem()
    private var myGroupsArray: [String] = []

    //MARK: -  Lyfe cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "My Groups"
        setUpView()
    }
    
    //MARK: - UI - setup
    
    private func setUpView() {
        myGroupsTableView = {
            let tableView = UITableView()
            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: CustomTableViewCell.customTableViewCellReuseIdentifier)
            tableView.dataSource = self
            tableView.delegate = self
            return tableView
        }()
        
        addButton = {
            let button = UIBarButtonItem(barButtonSystemItem: .add, target: self,
                                         action: #selector(transitionToAllGroupsController))
            return button
        }()
        navigationItem.rightBarButtonItem = addButton
        
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(myGroupsTableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            myGroupsTableView.topAnchor.constraint(equalTo: view.topAnchor),
            myGroupsTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            myGroupsTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            myGroupsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
    
    @objc private func transitionToAllGroupsController() {
        let nextController = AllGroupsController()
        self.navigationController?.pushViewController(nextController, animated: true)
    }
}

// MARK: - extension UITableViewDataSource

extension MyGroupsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myGroupsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.customTableViewCellReuseIdentifier) as? CustomTableViewCell else { return UITableViewCell() }
        cell.configure(image: UIImage(named: myGroupsArray[indexPath.row]), name: myGroupsArray[indexPath.row], description: nil)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForCellTableView
    }
}

// MARK: - extension UITableViewDelegate

extension MyGroupsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? CustomTableViewCell else { return }
        print(cell.nameLabel.text ?? "no name")
    }
}

