//
//  ReposTableViewController.swift
//  github-repo-starring-swift
//
//  Created by Haaris Muneer on 6/28/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ReposTableViewController: UITableViewController {
    
    let store = ReposDataStore.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.accessibilityLabel = "tableView"
        self.tableView.accessibilityIdentifier = "tableView"
        
        store.getRepositories {
            OperationQueue.main.addOperation({ 
                self.tableView.reloadData()
            })
        }
        
        GithubAPIClient.checkIfRepositoryIsStarred(name: "ptangen/FirstApp") {
            print("The FirstApp repo is starred: \($0)")
        }
        
//        GithubAPIClient.starResposity(name: "ptangen/FirstApp") {
//            print("Results of attempt to star the \($0) repo: \($1)")
//        }
        
//        GithubAPIClient.unstarResposity(name: "ptangen/FirstApp") {
//            print("Results of attempt to UNstar the \($0) repo: \($1)")
//        }
        
        store.toggleStarStatus(name: "ptangen/FirstApp") {
            print("The attempt to toggle the star was successful: \($0)")
        }
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.store.repositories.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "repoCell", for: indexPath)

        let repository:GithubRepository = self.store.repositories[(indexPath as NSIndexPath).row]
        cell.textLabel?.text = repository.fullName

        return cell
    }

}
