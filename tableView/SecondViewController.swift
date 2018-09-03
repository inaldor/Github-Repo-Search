//
//  SecondViewController.swift
//  tableView
//
//  Created by inaldo on 03/09/2018.
//  Copyright © 2018 InaldoRRibeiro. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SecondViewController: UIViewController {
    
    var usersData = [UserModel]()
    var repoName = String()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCallGitApi(repoName)
    }
    
    // TODO: Move getCallGitApi to a local API Manager
    // Get call using Alamofire on Github
    fileprivate func getCallGitApi(_ repoName: String) {
        
        DispatchQueue.main.async {
            Alamofire.request("https://api.github.com/search/repositories?q=\(repoName)").responseJSON(completionHandler: { (response) in
                
                switch response.result {
                    
                case .success(let value):
                    let json = JSON(value)
                    let items = json["items"]
                    print(items)
                    items.array?.forEach({ (user) in
                        let user = UserModel(name: user["name"].stringValue, openIssues: user["open_issues"].stringValue, numberOfForks: user["forks_count"].stringValue)
                        print(user)
                        // forks_count, default_branch, contributors_url, commits_url, watchers_count
                        self.usersData.append(user)
                    })
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            })
        }
    }
}

extension SecondViewController: UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersData.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        
        cell.textLabel?.text = usersData[indexPath.row].name
        return(cell)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let thirdStoryboard = UIStoryboard(name: "Third", bundle: nil)
        let thirdVC = thirdStoryboard.instantiateViewController(withIdentifier: "ThirdViewController") as! ThirdViewController
        
        thirdVC.user = usersData[indexPath.row]
        
        self.navigationController?.show(thirdVC, sender: nil)
    }
}

