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
    
    var arrayOfImages = ["https://www.advancedcustomfields.com/wp-content/uploads/2013/02/acf-image-field-edit.jpg","https://community.imgur.com/uploads/default/original/3X/9/4/946841767587979b888acd2c2e6f6a99982ff68a.jpg","https://clevertechie.com/img/php-curl-tutorial/array_imageurls.jpg"]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let backTitle = NSLocalizedString("Back", comment: "Back button label")
        self.addBackbutton(title: backTitle)
        
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
    
}

extension UIViewController {
    
    func backButtonAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func addBackbutton(title: String) {
        if let nav = self.navigationController,
            let item = nav.navigationBar.topItem {
            item.backBarButtonItem  = UIBarButtonItem(title: title, style: UIBarButtonItemStyle.plain, target: self, action:
                #selector(self.backButtonAction))
        } else {
            if let nav = self.navigationController,
                let _ = nav.navigationBar.backItem {
                self.navigationController!.navigationBar.backItem!.title = title
            }
        }
    }
}
