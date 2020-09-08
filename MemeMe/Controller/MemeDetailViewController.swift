//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Jonathan Sweeney on 9/7/20.
//  Copyright © 2020 Jonathan Sweeney. All rights reserved.
//

import UIKit

class MemeDetailViewController : UIViewController {
    var meme: Meme!
    @IBOutlet weak var memeImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        memeImageView.image = meme.imageEdited
    }
}
