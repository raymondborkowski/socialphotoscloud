//
//  twitter.swift
//  SocialCloud Photos
//
//  Created by Raymond Borkowski on 8/3/17.
//  Copyright © 2017 Raymond Borkowski. All rights reserved.
//

import Foundation
import TwitterKit
import UIKit

var urls = [String]()

public class Twit {

    class func getTwitterResults(_ textField: String, callback:@escaping (() -> Void)){
        // API Client for User Context
        let client = TWTRAPIClient()
        let statusesShowEndpoint = "https://api.twitter.com/1.1/search/tweets.json"
        let params = ["q": "#\(textField)%20filter:media"]
        var clientError : NSError?
        
        let request = client.urlRequest(withMethod: "GET", url: statusesShowEndpoint, parameters: params, error: &clientError)
        
        client.sendTwitterRequest(request) { (response, data, connectionError) -> Void in
            if connectionError != nil {
                print("Error: \(String(describing: connectionError))")
            } else {
                do {
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
                    callback()
                    
                } catch _ as NSError {
                    print("Error: ")
                }
            }
        }
    }


}
