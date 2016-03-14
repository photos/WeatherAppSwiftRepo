//
//  ViewController.swift
//  WhatsTheWeather
//
//  Created by Forrest Collins on 6/19/15.
//  Copyright (c) 2015 Forrest Collins. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //-------------------
    // MARK: - UI Outlets
    //-------------------
    @IBOutlet weak var weatherTextField: UITextField!
    @IBOutlet weak var weatherInfoLabel: UILabel!
    @IBAction func weatherButtonTapped(sender: AnyObject) {
        
        //made it so when a user types in a city with a space, it replaces it with a dash
        let url = NSURL(string: "http://www.weather-forecast.com/locations/" + weatherTextField.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()).stringByReplacingOccurrencesOfString(" ", withString: "-") + "/forecasts/latest")
        
        // if the url exists...
        if url != nil {
            
            let task = NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: { (data, response, error) in
                
                var urlError:Bool = false
                
                var weather = ""
                
                let httpURLResponse = response as! NSHTTPURLResponse
                
                if error == nil && httpURLResponse.statusCode == 200 {
                    
                    // we have something in data
                    let urlContent = NSString(data: data!, encoding: NSUTF8StringEncoding) as NSString!
                    
                    var urlContentArray = urlContent.componentsSeparatedByString("<span class=\"phrase\">")
                    
                    // check if urlContent[1] exists
                    // if the user enters a location that doesn't exist...
                    if urlContentArray.count > 0 {
                        
                        var weatherArray = urlContentArray[1].componentsSeparatedByString("</span>")
                        
                        weather = weatherArray[0] 
                        
                        // fix degrees sign
                        weather = weather.stringByReplacingOccurrencesOfString("&deg;", withString: "º")
                        
                    } else {
                        urlError = true
                    }
                    
                    // choose urlContentArray[1] because it starts with what we are interested in. The zero'th array will be everything...
                    // before the first occurrence of the string urlContent
                    print(urlContentArray[1])
                    
                } else {
                    urlError = true
                }
                
                dispatch_async(dispatch_get_main_queue()) {
                    
                    if urlError == true {
                        
                        // display error message
                        self.showError()
                    } else {
                        
                        // do this down here b/c you want to use dispatch async
                        self.weatherInfoLabel.text = weather
                    }
                }
            })
            task.resume()
            
        } else {
            showError()
        }
    }
    
    // Show Error Method
    func showError() {
        weatherInfoLabel.text = "Could not find weather for" + weatherTextField.text! + ". Please try again"
    }
}

