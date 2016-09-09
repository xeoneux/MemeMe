//
//  TabBarController.swift
//  MemeMe
//
//  Created by Aayush Kapoor on 10/09/16.
//  Copyright © 2016 Aayush Kapoor. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        let toolbar = UIToolbar()
        toolbar.frame = CGRectMake(0, 20, self.view.frame.size.width, 44);

        let addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(self.createMeme))
        let spacer = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: self, action: nil)

        toolbar.items = [spacer, addBarButtonItem]

        self.view.addSubview(toolbar)
    }

    func createMeme() {
        print("Add new meme!")
    }

}
