//
//  PictureView.swift
//  SocialCloud Photos
//
//  Created by Raymond Borkowski on 6/5/17.
//  Copyright © 2017 Raymond Borkowski. All rights reserved.
//

import UIKit

class PictureView: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!

    var scrollView: UIScrollView!
    var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

