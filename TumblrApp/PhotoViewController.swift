//
//  PhotoViewController.swift
//  TumblrApp
//
//  Created by MacOS on 2/4/18.
//  Copyright © 2018 MacOS. All rights reserved.
//

import UIKit
import AlamofireImage

class PhotoViewController: UIViewController, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    var posts:[[String: Any]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        print("About to Get posts")
        getPosts()
        print("Got posts")
    }

    func getPosts() {
        let url = URL(string: "https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        session.configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error{
                print(error.localizedDescription)
            } else if let data = data {
                let dataDict = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let responseDict = dataDict["response"] as! [String: Any]
                self.posts = responseDict["posts"] as! [[String:Any]]
                self.tableView.reloadData()
            }
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as! PhotoTableViewCell
        
        let post = posts[indexPath.row]
        if let photos = post["photos"] as? [[String: Any]] {
            let photo = photos[0]
            let originalSize = photo["orginalSize"] as! [String: Any]
            let urlString = originalSize["url"] as! String
            let url = URL(string: urlString)
            
            cell.postImageView.af_setImage(withURL: url!)
        }
        return cell
    }

}
