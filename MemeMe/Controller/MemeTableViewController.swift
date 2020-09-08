//
//  MemeTableViewController.swift
//  MemeMe
//
//  Created by Jonathan Sweeney on 9/6/20.
//  Copyright © 2020 Jonathan Sweeney. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController {
    var memes: [Meme]! {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.memes
    }
    var tests: [String]! {
        return (UIApplication.shared.delegate as! AppDelegate).tests
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.separatorStyle = .none
        tableView.rowHeight = 75.0
        tableView.reloadData()
        print("There are \(memes.count) memes")
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tests.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.reuseableTableViewCellId, for: indexPath)
        let meme = tests[indexPath.row]
        
        cell.textLabel?.text = meme
        cell.imageView?.image = UIImage(named: "test")
        
        return cell
    }

    // MARK: - Table view delegate methods

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: K.goToDetailsSegue, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let destinationVC = segue.destination as! MemeDetailViewController
        
//        destinationVC.MemeImageView.image = UIImage(named: "test")
//        if let indexPath = tableView.indexPathForSelectedRow {
//            destinationVC.selectedCategory = categories?[indexPath.row]
//        }
    }
    
    // MARK: - Navigation
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let newMemeVC = storyboard.instantiateViewController(withIdentifier: K.editMemeId)
        let navigationController = UINavigationController()
        navigationController.viewControllers = [newMemeVC]
        self.navigationController?.present(navigationController, animated: true, completion: nil)
    }
}
