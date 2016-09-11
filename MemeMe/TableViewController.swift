//
//  TableViewController.swift
//  MemeMe
//
//  Created by Aayush Kapoor on 10/09/16.
//  Copyright © 2016 Aayush Kapoor. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.reloadData()
        self.navigationItem.title = "Sent Memes"
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let meme = self.memes[indexPath.row]

        let cell = self.tableView.dequeueReusableCellWithIdentifier("TableViewCell")!
        cell.textLabel?.text = "\(meme.topText) ... \(meme.bottomText)"
        cell.imageView?.image = meme.memedImage

        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailViewController = self.storyboard?.instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
        detailViewController.meme = self.memes[indexPath.row]
        navigationController?.pushViewController(detailViewController, animated: true)
    }

    @IBAction func createMeme(sender: AnyObject) {
        let memeEditorViewController = self.storyboard?.instantiateViewControllerWithIdentifier("Meme Editor") as! MemeEditorViewController
        presentViewController(memeEditorViewController, animated: true, completion: nil)
    }
}
