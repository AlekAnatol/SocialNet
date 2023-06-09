//
//  AllGroupsController.swift
//  SocialNet
//
//  Created by Екатерина Алексеева on 13.04.2023.
//

import UIKit

class AllGroupsController: UIViewController {

    //MARK: - Private properties
    
    private var allGroupsTableView = UITableView()

    //MARK: -  Lyfe cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "All Groups"
        setUpView()
    }
    
    //MARK: - UI - setup
    
    private func setUpView() {
        allGroupsTableView = {
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
        view.addSubview(allGroupsTableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            allGroupsTableView.topAnchor.constraint(equalTo: view.topAnchor),
            allGroupsTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            allGroupsTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            allGroupsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
}

// MARK: - extension UITableViewDataSource

extension AllGroupsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StorageSingleton.share.allGroupsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.customTableViewCellReuseIdentifier) as? CustomTableViewCell else
        { return UITableViewCell() }
        print("By main image did select \(indexPath.row)")
        cell.configure(group: StorageSingleton.share.allGroupsArray[indexPath.row]) { 
            StorageSingleton.share.addGroupToMyGroups(group:
                                                        StorageSingleton.share.allGroupsArray[indexPath.row])
            tableView.deselectRow(at: indexPath, animated: true)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForCellTableView
    }
}

// MARK: - extension UITableViewDelegate

extension AllGroupsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("In all groups did select \(indexPath.row)")
        StorageSingleton.share.addGroupToMyGroups(group:
                                                    StorageSingleton.share.allGroupsArray[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
