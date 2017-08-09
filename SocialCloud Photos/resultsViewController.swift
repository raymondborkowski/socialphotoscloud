//
//  resultsViewController.swift
//  SocialCloud Photos
//
//  Created by Raymond Borkowski on 8/3/17.
//  Copyright © 2017 Raymond Borkowski. All rights reserved.
//

import UIKit
import Kingfisher

class resultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var arrayOfImages = urls
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfImages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell") as! ImageCell
        let resource = ImageResource(downloadURL: URL(string: arrayOfImages[indexPath.row])!, cacheKey: arrayOfImages[indexPath.row])
        
        cell.imgView.kf.setImage(with: resource)
        return cell
    }
    
    @IBAction func newSearch(_ sender: UIButton) {
        urls = [String]()
    }
}
