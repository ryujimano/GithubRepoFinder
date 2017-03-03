//
//  ViewController.swift
//  GithubDemo
//
//  Created by Nhan Nguyen on 5/12/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit
import MBProgressHUD

// Main ViewController
class RepoResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SettingsPresentingViewControllerDelegate {
    @IBOutlet weak var tableView: UITableView!

    var searchBar: UISearchBar!
    var searchSettings = GithubRepoSearchSettings()

    var repos: [GithubRepo]!
    var filteredRepos: [GithubRepo]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.alpha = 0

        // Initialize the UISearchBar
        searchBar = UISearchBar()
        searchBar.delegate = self

        // Add SearchBar to the NavigationBar
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar

        // Perform the first search when the view controller first loads
        doSearch()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    // Perform the search.
    fileprivate func doSearch() {

        MBProgressHUD.showAdded(to: self.view, animated: true)

        // Perform request to GitHub API to get the list of repositories
        GithubRepo.fetchRepos(searchSettings, successCallback: { (newRepos) -> Void in

            // Print the returned repositories to the output window
            for repo in newRepos {
                print(repo)
            }
            self.repos = newRepos
            self.filteredRepos = self.repos

            self.tableView.reloadData()
            
            MBProgressHUD.hide(for: self.view, animated: true)
            self.tableView.alpha = 1
            }, error: { (error) -> Void in
                print(error)
        })
    }
    
    //MARK: UITableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredRepos?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "repoCell", for: indexPath) as! RepoTableViewCell
        
        let repo = filteredRepos[indexPath.row]
        
        cell.selectionStyle = .none
        
        cell.repoNameLabel.text = repo.name
        cell.starsLabel.text = "\(repo.stars!)"
        cell.forksLabel.text = "\(repo.forks!)"
        cell.ownerLabel.text = repo.ownerHandle
        cell.ownerView.setImageWith(URL(string: repo.ownerAvatarURL!)!)
        cell.descriptionLabel.text = repo.repoDescription
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navController = segue.destination as! UINavigationController
        let vc = navController.topViewController as! SettingsViewController
        vc.settings = searchSettings
        vc.settingsDelegate = self
    }
    
    
    func didSaveSettings(settings: GithubRepoSearchSettings) {
        
    }
    
    func didCancelSettings() {
        
    }
    
    
}

// SearchBar methods
extension RepoResultsViewController: UISearchBarDelegate {

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        
        return true
    }

    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchSettings.searchString = searchBar.text
        searchBar.resignFirstResponder()
        doSearch()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //filter the repos array based on the user's search
        let filtered = searchText.isEmpty ? repos : repos?.filter({ (repos: GithubRepo) -> Bool in
            let repo = repos.name
            return repo!.lowercased().range(of: searchText.lowercased()) != nil
        })
        
        //assign the filtered array to filteredRepos
        filteredRepos = filtered ?? []
        
        //reload data
        tableView.reloadData()
    }
}
