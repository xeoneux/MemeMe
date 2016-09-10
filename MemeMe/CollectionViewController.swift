//
//  CollectionViewController.swift
//  MemeMe
//
//  Created by Aayush Kapoor on 10/09/16.
//  Copyright © 2016 Aayush Kapoor. All rights reserved.
//

import UIKit

class CollectionViewController: UICollectionViewController {

    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }

    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Memes"
        self.collectionView?.backgroundColor = UIColor.whiteColor()
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memes.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let meme = self.memes[indexPath.row]

        let cell = self.collectionView!.dequeueReusableCellWithReuseIdentifier("CollectionViewCell", forIndexPath: indexPath)
        cell.backgroundView = UIImageView(image: meme.memedImage)
    
        return cell
    }

}
