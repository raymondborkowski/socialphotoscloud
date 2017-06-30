//
//  ViewController.swift
//  SocialCloud Photos
//
//  Created by Raymond Borkowski on 5/31/17.
//  Copyright © 2017 Raymond Borkowski. All rights reserved.
//

import Foundation
import UIKit
import TwitterKit


class ViewController: UIViewController, UITextFieldDelegate {
    
    // Mark: Properties
    @IBOutlet weak var hashTagField: UITextField!
    @IBOutlet weak var socialPhotosLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Handle the text field’s user input through delegate callbacks.
        hashTagField.delegate = self
    }
    
    func getTwitterResults(_ textField: String){
        // API Client for User Context
        let client = TWTRAPIClient()
        let statusesShowEndpoint = "https://api.twitter.com/1.1/search/tweets.json"
        let params = ["q": "#\(textField)%20filter:media"]
        var clientError : NSError?
            
        let request = client.urlRequest(withMethod: "GET", url: statusesShowEndpoint, parameters: params, error: &clientError)
        
        client.sendTwitterRequest(request) { (response, data, connectionError) -> Void in
            if connectionError != nil {
                print("Error: \(String(describing: connectionError))")
            }
                
            do {
                var urls = [String]()
                let json = try JSONSerialization.jsonObject(with: data!) as? [String:Any]
                let statuses = json?["statuses"] as? Array<NSObject> // is an array
                for status in statuses! {
                    let entities = status.value(forKey: "entities") as? NSObject
                    let media = entities?.value(forKey: "media") as? Array<NSObject>
                    if media != nil {
                        for medium in media! {
                            let media_url_https = medium.value(forKey: "media_url_https") as! String
                            urls.append(media_url_https);
                        }
                    }
                }
                // call something in here with url
                self.performSegue(withIdentifier: "homeToPictureView", sender: self)
            } catch _ as NSError {
            }
        }
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        getTwitterResults(hashTagField.text!)
        return true
    }
    
    // Mark: Actions
    @IBAction func makeTwitterRequest(_ sender: UIButton) {
        getTwitterResults(hashTagField.text!)
    }
    
}

