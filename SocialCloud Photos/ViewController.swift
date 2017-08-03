//
//  ViewController.swift
//  SocialCloud Photos
//
//  Created by Raymond Borkowski on 5/31/17.
//  Copyright © 2017 Raymond Borkowski. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher


class ViewController: UIViewController, UITextFieldDelegate {
    
    // Mark: Properties
    @IBOutlet weak var hashTagField: UITextField!
    @IBOutlet weak var socialPhotosLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Handle the text field’s user input through delegate callbacks.
        hashTagField.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let imageView = UIImageView()
        super.viewDidAppear(animated)
        if !Reachability.isConnectedToNetwork(){
            self.showOfflineAlert()
        }
        
        let url = URL(string: "https://domain.com/image.jpg")!
        imageView.kf.setImage(with: url)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "One"
    }
    
    func showOfflineAlert() {
        let alert = UIAlertController(title: "Offline", message: "Oh no! It looks like you are offline. Please connect to search photos!", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func transferToResults() {
        self.performSegue(withIdentifier: "homeToPictureView", sender: self)
    }
    
    func onSearch() {
        // Create and add the loading modal.
        let progressHUD = ProgressHUD(text: "Creating something magnificant")
        self.view.addSubview(progressHUD)
        Twit.getTwitterResults(hashTagField.text!, callback: transferToResults)
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        onSearch()

        return true
    }
    
    // Mark: Actions
    @IBAction func makeTwitterRequest(_ sender: UIButton) {
        onSearch()
    }
}

