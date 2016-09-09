//
//  ViewController.swift
//  MemeMe
//
//  Created by Aayush Kapoor on 07/09/16.
//  Copyright © 2016 Aayush Kapoor. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    let memeTextAttributes = [
        NSStrokeWidthAttributeName: Float(-4),
        NSStrokeColorAttributeName: UIColor.blackColor(),
        NSForegroundColorAttributeName: UIColor.whiteColor(),
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!
    ]

    @IBOutlet weak var topToolbar: UIToolbar!
    @IBOutlet weak var bottomToolbar: UIToolbar!

    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!


    @IBOutlet weak var albumButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!

    @IBOutlet weak var imagePickerView: UIImageView!

    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    // MARK: Life Cycle

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(.Camera)

        topTextField.delegate = self
        bottomTextField.delegate = self
        topTextField.textAlignment = .Center
        bottomTextField.textAlignment = .Center
        topTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.defaultTextAttributes = memeTextAttributes

        subscribeToKeyboardNotifications()
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)

        unsubscribeFromKeyboardNotifications()
    }

    // MARK: Image

    @IBAction func pickAnImageFromAlbum(sender: AnyObject) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .PhotoLibrary
        presentViewController(imagePickerController, animated: true, completion: nil)
    }

    @IBAction func pickAnImageFromCamera(sender: AnyObject) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .Camera
        presentViewController(imagePickerController, animated: true, completion: nil)
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.image = image
            dismissViewControllerAnimated(true, completion: nil)
        }
    }

    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    // MARK: Keyboard

    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }

    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }

    func keyboardWillShow(notification: NSNotification) {
        if bottomTextField.isFirstResponder() {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }

    func keyboardWillHide(notification: NSNotification) {
        if bottomTextField.isFirstResponder() {
            view.frame.origin.y += getKeyboardHeight(notification)
        }
    }

    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    // MARK: Meme

    func generateMemedImage() -> UIImage {

        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return memedImage
    }

    @IBAction func share(sender: AnyObject) {

        hideToolbars(true)

        let memedImage = generateMemedImage()
        let originalImage = imagePickerView.image ?? UIImage.init()

        hideToolbars(false)

        let activityViewController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)

        activityViewController.completionWithItemsHandler = {
            if $0.1 == true {
                let topText = self.topTextField.text ?? "TOP"
                let bottomText = self.topTextField.text ?? "BOTTOM"

                let meme = Meme(topText: topText, bottomText: bottomText, memedImage: memedImage, originalImage: originalImage)
            }
        }

        presentViewController(activityViewController, animated: true, completion: nil)
    }

    // MARK: Helpers

    func hideToolbars(flag: Bool) {
        topToolbar.hidden = flag
        bottomToolbar.hidden = flag
    }

}

