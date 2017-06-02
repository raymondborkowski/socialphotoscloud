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
        if let userID = Twitter.sharedInstance().sessionStore.session()?.userID {
            let client = TWTRAPIClient(userID: userID)
            let statusesShowEndpoint = "https://api.twitter.com/1.1/search/tweets.json"
            let params = ["q": "#\(textField)%20filter:media"]
            var clientError : NSError?
            
            let request = client.urlRequest(withMethod: "GET", url: statusesShowEndpoint, parameters: params, error: &clientError)
            
            client.sendTwitterRequest(request) { (response, data, connectionError) -> Void in
                if connectionError != nil {
                    print("Error: \(String(describing: connectionError))")
                }
                
                do {
                    var urls = [Any]()
                    if let data = data,
                    let json = try JSONSerialization.jsonObject(with: data) as? NSDictionary,
                    let statuses = json.value(forKey: "statuses") as? NSArray,
                    let entities = statuses.value(forKey: "entities") as? NSArray,
                    let media = entities.value(forKey: "media") as? NSArray,
                    let text = media.value(forKey: "media_url_https") as? NSArray {
                        urls.append(text[0])
                    }
                    let NameArray:NSArray = urls as NSArray
                    let swiftArray = NameArray as! [[String]]
                    let flattenedArray = swiftArray.flatMap{ $0 }
                    self.createImages(flattenedArray);
                    
                } catch _ as NSError {
                }
            }
        }
    }
    
    func createImages(_ imgArr: Array<Any>) {
        print(imgArr[0])
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    // Mark: Actions
    @IBAction func makeTwitterRequest(_ sender: UIButton) {
        getTwitterResults(hashTagField.text!)
    }
    
}

