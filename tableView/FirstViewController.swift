//
//  FirstViewController.swift
//  tableView
//
//  Created by inaldo on 03/09/2018.
//  Copyright © 2018 InaldoRRibeiro. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var repoNameTextField: UITextField!
    
    
    @IBAction func searchButtonAction(_ sender: Any) {
        let secondStoryboard = UIStoryboard(name: "Second", bundle: nil)
        let secondVC = secondStoryboard.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        secondVC.repoName = repoNameTextField.text!
        
        self.navigationController?.show(secondVC, sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // TODO: Implement textfield delegate and change "Return" of the keyboard to "Search", linking the related action
}
