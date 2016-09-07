//
//  ViewController.swift
//  MemeMe
//
//  Created by Aayush Kapoor on 07/09/16.
//  Copyright © 2016 Aayush Kapoor. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var albumButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!

    @IBOutlet weak var imagePickerView: UIImageView!

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(.Camera)
    }

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

}

