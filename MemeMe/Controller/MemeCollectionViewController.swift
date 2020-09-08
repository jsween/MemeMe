//
//  MemeCollectionViewController.swift
//  MemeMe
//
//  Created by Jonathan Sweeney on 9/6/20.
//  Copyright © 2020 Jonathan Sweeney. All rights reserved.
//

import UIKit

//private let reuseIdentifier = K.reuseableCollectionCellId

class MemeCollectionViewController: UICollectionViewController {
    var memes: [Meme]! {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.memes
    }
    var tests: [String]! {
        return (UIApplication.shared.delegate as! AppDelegate).tests
    }
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    // MARK: - Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let space: CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        
        flowLayout.minimumLineSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
        
        collectionView?.reloadData()
        print("There are \(memes.count) memes")
        
        // Add createMeme button in tab bar
        let rtBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(MemeCollectionViewController.navigateToMemeEditor))
        navigationItem.setRightBarButton(rtBarButtonItem, animated: true)

        collectionView?.reloadData()
    }

    // MARK: - UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tests.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.reuseableCollectionCellId, for: indexPath) as! MemeCVCell
    
        // Configure the cell
        if let image = cell.imageView {
            image.image = UIImage(named: "test")
        }
        
        return cell
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: K.goToDetailsFromCVSegue, sender: self)
    }
    
    // MARK: - Navigation
    
    @objc func navigateToMemeEditor() {
        let memeEditorController = storyboard?.instantiateViewController(withIdentifier: K.editMemeId) as! EditMemeViewController
        self.present(memeEditorController, animated: true, completion: nil)
    }

}
