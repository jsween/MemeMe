//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Jonathan Sweeney on 9/7/20.
//  Copyright © 2020 Jonathan Sweeney. All rights reserved.
//

import UIKit

class MemeDetailViewController : UIViewController {
//    var meme: Meme!
    @IBOutlet weak var MemeImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MemeImageView.image = UIImage(named: "test")
//        imageView.image = meme.ImageEdited
    }
    
}
