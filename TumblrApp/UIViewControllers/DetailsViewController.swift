//
//  DetailsViewController.swift
//  TumblrApp
//
//  Created by MacOS on 2/11/18.
//  Copyright © 2018 MacOS. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var photoImageView: UIImageView!
    var post: [String: Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let post = post {
            let photos = post["photos"] as! [[String: Any]]
            let photo = photos[0]
            let originalSize = photo["original_size"] as! [String: Any]
            let urlString = originalSize["url"] as! String
            let url = URL(string: urlString)!
            photoImageView.af_setImage(withURL: url)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
