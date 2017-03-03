//
//  SettingsViewController.swift
//  GithubDemo
//
//  Created by Ryuji Mano on 3/2/17.
//  Copyright © 2017 codepath. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var filterSwitch: UISwitch!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var starSlider: UISlider!
    @IBOutlet weak var starsNumberLabel: UILabel!
    
    var settings: GithubRepoSearchSettings!
    
    var stars: Int = 0
    
    weak var settingsDelegate: SettingsPresentingViewControllerDelegate?
    
    var languages = ["Java", "Swift", "JavaScript", "HTML", "CSS", "Python", "C", "C++", "Go"]
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

//        tableView.delegate = self
//        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else {
            if filterSwitch.isOn {
                return 1 + languages.count
            }
            else {
                return 1
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        if indexPath.section == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "starsCell", for: indexPath) as! StarsTableViewCell
        }
        else {
            cell = tableView.dequeueReusableCell(withIdentifier: "filterCell", for: indexPath) as! FilterTableViewCell
        }
        return cell!
    }

    @IBAction func saveButtonTapped(_ sender: Any) {
        settingsDelegate?.didSaveSettings(settings: settings)
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        settingsDelegate?.didCancelSettings()
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
