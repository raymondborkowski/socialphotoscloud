//
//  ImageCell.swift
//  SocialCloud Photos
//
//  Created by Raymond Borkowski on 8/3/17.
//  Copyright © 2017 Raymond Borkowski. All rights reserved.
//

import UIKit

class ImageCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var textView: UITextView!

    @IBOutlet weak var uiBox: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }

}
