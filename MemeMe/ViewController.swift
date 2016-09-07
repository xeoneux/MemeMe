//
//  ViewController.swift
//  MemeMe
//
//  Created by Aayush Kapoor on 07/09/16.
//  Copyright © 2016 Aayush Kapoor. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imagePickerView: UIImageView!

    @IBAction func pickAnImage(sender: AnyObject) {
        let imagePickerController = UIImagePickerController()
        presentViewController(imagePickerController, animated: true, completion: nil)
    }

}

