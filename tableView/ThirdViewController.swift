//
//  ThirdViewController.swift
//  tableView
//
//  Created by inaldo on 03/09/2018.
//  Copyright © 2018 InaldoRRibeiro. All rights reserved.
//

import UIKit
import SwiftyJSON

class ThirdViewController: UIViewController {

    var user: UserModel?
    
    @IBOutlet weak var openIssuesLabel: UILabel!
    @IBOutlet weak var forksNumberLabel: UILabel!
    @IBOutlet weak var readmeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        initializeElements()
    }
    
    // MARK: Initializes elements of the screen regarding the repo selected
    fileprivate func initializeElements() {
        
        if let repo = user {
            openIssuesLabel.text = "Open issues: \(repo.openIssues)"
            forksNumberLabel.text = "Forks: \(repo.numberOfForks)"
            navigationItem.title = repo.name
        }
        
        readmeFileRequest()
    }
    
    // TODO: Move readmeFileRequest to a local API Manager
    func readmeFileRequest() {
        // TODO: Decode readme.md text
        
        let url = URL(string: "https://api.github.com/repos/geekcomputers/Python/readme")!
        
        var textReadme = String()
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            let json = JSON(data)
            let content = json["content"]
            
            textReadme = content.string!
            print(textReadme)
        }
        
        self.readmeLabel.text = textReadme
        
        task.resume()
    }
}
