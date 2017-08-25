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
    
    func imageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        // Your action
        let x = tappedImage.accessibilityLabel
        print(x)
        let url = URL(string: x!)!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell") as! ImageCell
        let resource = ImageResource(downloadURL: URL(string: arrayOfImages[indexPath.row][1] )!, cacheKey: arrayOfImages[indexPath.row][1] )
        cell.imgView.kf.setImage(with: resource)
        cell.textView.text = arrayOfImages[indexPath.row][0]
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        
        cell.textView.superview?.addGestureRecognizer(tapGestureRecognizer)
        
        cell.imgView.isUserInteractionEnabled = true
        cell.imgView.accessibilityLabel = arrayOfImages[indexPath.row][2]
        cell.imgView.addGestureRecognizer(tapGestureRecognizer)

        return cell
    }
    
    @IBAction func newSearch(_ sender: UIButton) {
        urls = []
    }
}
