//
//  DetailViewController.swift
//  MemeMe
//
//  Created by Aayush Kapoor on 10/09/16.
//  Copyright © 2016 Aayush Kapoor. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var meme: Meme!

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!

    override func viewWillAppear(animated: Bool) {
        imageView.image = meme.memedImage
    }

    @IBAction func shareAction(sender: UIBarButtonItem) {
        let activityViewController = UIActivityViewController(activityItems: [meme.memedImage], applicationActivities: nil)
        presentViewController(activityViewController, animated: true, completion: nil)
    }

    @IBAction func cancelAction(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
