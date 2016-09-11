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

    override func viewWillAppear(animated: Bool) {
        imageView.image = meme.memedImage
    }

}
