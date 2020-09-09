//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Jonathan Sweeney on 9/7/20.
//  Copyright © 2020 Jonathan Sweeney. All rights reserved.
//

import UIKit

class MemeDetailViewController : UIViewController {
    var detailMeme: Meme!
    @IBOutlet weak var memeImageView: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        memeImageView.image = detailMeme.imageEdited
        tabBarController?.tabBar.isHidden = true
    }
}
