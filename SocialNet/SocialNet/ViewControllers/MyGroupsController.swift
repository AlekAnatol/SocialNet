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

    //MARK: -  Lyfe cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "My Groups"
        setUpView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        myGroupsTableView.reloadData()
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
        return StorageSingleton.share.myGroupsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.customTableViewCellReuseIdentifier) as? CustomTableViewCell else { return UITableViewCell() }
        cell.configure(group: StorageSingleton.share.myGroupsArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForCellTableView
    }
}

// MARK: - extension UITableViewDelegate

extension MyGroupsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("In my groups did select \(indexPath.row)")
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        StorageSingleton.share.myGroupsArray.remove(at: indexPath.row)
        myGroupsTableView.deleteRows(at: [indexPath], with: .fade)
    }
}

