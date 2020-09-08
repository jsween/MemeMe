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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.separatorStyle = .none
        tableView.rowHeight = 80.0
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.reuseableTableViewCellId, for: indexPath)
        let meme = memes[indexPath.row]
        
        cell.textLabel?.text = meme.textTop + " " + meme.textBottom
        cell.imageView?.image = meme.imageEdited
        
        return cell
    }

    // MARK: - Table view delegate methods

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let memeDetailVC = storyboard!.instantiateViewController(withIdentifier: K.memeDetailVCId) as! MemeDetailViewController
        memeDetailVC.meme = memes[indexPath.row]
        navigationController!.pushViewController(memeDetailVC, animated: true)
    }
    
    // MARK: - Navigation
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let newMemeVC = storyboard!.instantiateViewController(withIdentifier: K.editMemeId)
        let navigationController = UINavigationController()
        navigationController.viewControllers = [newMemeVC]
        self.navigationController?.present(navigationController, animated: true, completion: nil)
    }
}
