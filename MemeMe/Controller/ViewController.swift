//
//  ViewController.swift
//  MemeMe
//
//  Created by Jonathan Sweeney on 7/10/20.
//  Copyright © 2020 Jonathan Sweeney. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    // MARK: Outlets
    
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var shareBtn: UIBarButtonItem!
    @IBOutlet weak var resetBtn: UIBarButtonItem!
    @IBOutlet weak var topTF: UITextField!
    @IBOutlet weak var imageIV: UIImageView!
    @IBOutlet weak var bottomTF: UITextField!
    @IBOutlet weak var pickBtn: UIBarButtonItem!
    @IBOutlet weak var cameraBtn: UIBarButtonItem!
    @IBOutlet weak var toolbar: UIToolbar!
    
    // MARK: - Variables
    
    var memeImage: UIImage! = nil
    var meme: Meme? = nil
    
    let topStr: String = "TOP"
    let bottomStr: String = "BOTTOM"
    
    // MARK: - Meme Text Attributes
    
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth:  -4.0
    ]
    
    // MARK: Methods
    
    // MARK: - Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        subscribeToKeyboardNotifications()
        resetUI()
        cameraBtn.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        unsubscribeFromKeyboardNotfications()
    }
    
    // MARK: - Helpers
    
    func saveMeme() -> Meme {
        return Meme(textTop: topTF.text ?? "Error", textBottom: bottomTF.text ?? "Error", imageOrigninal: imageIV.image!, imageEdited: memeImage)
    }
    
    func generateMemedImage() -> UIImage {
        // Hide Nav and Toolbar
        showHideBars(hide: true)
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // Show Nav and Toolbar
        showHideBars(hide: false)
        
        return memedImage
    }
    
    // Show alert to user
    func showAlert(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: AlertMsgs.DismissAlert, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Configure UI
    
    func showHideBars(hide: Bool) {
        navBar.isHidden = hide
        toolbar.isHidden = hide
    }
    
    func configureTF(textField tf: UITextField, text txt: String) {
        tf.text = txt
        tf.delegate = self
        tf.defaultTextAttributes = memeTextAttributes
        tf.textAlignment = .center
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageIV.image = image
            shareBtn.isEnabled = true
        }
            dismiss(animated: true, completion: nil)
    }
    
    func resetUI() {
        configureTF(textField: topTF, text: topStr)
        configureTF(textField: bottomTF, text: bottomStr)
        shareBtn.isEnabled = false
        imageIV.image = nil
    }
    
    // MARK: - Configure Elements
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if bottomTF.isEditing {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        if bottomTF.isEditing {
            view.frame.origin.y = 0
        }
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotfications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    // MARK: Actions
    
    @IBAction func pickAnImageFromAlbum(_ sender: Any) {
        let imagePkr = UIImagePickerController()
        imagePkr.delegate = self
        imagePkr.sourceType = .photoLibrary
        present(imagePkr, animated: true, completion: nil)
    }
    
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        let imagePkr = UIImagePickerController()
        imagePkr.delegate = self
        imagePkr.sourceType = .camera
        present(imagePkr, animated: true, completion: nil)
    }
    
    @IBAction func resetBtnPressed(_ sender: Any) {
        resetUI()
        memeImage = nil
    }
    
    @IBAction func shareMemePressed(_ sender: Any) {
        memeImage = generateMemedImage()
        let aVC = UIActivityViewController(activityItems: [memeImage!], applicationActivities: nil)
        aVC.popoverPresentationController?.sourceView = self.view
        aVC.completionWithItemsHandler = {
            (activity, success, items, error) in
            if success {
                self.meme = self.saveMeme()
            } else {
                self.showAlert(AlertMsgs.SharingMemeTitle, message: AlertMsgs.SharingMemeMessage)
            }
        }
        self.present(aVC, animated: true, completion: nil)
    }
}

