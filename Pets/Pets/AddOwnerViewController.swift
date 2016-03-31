//
//  AddOwnerViewController.swift
//  Pets
//
//  Created by Naga Praveen Kumar Pendyala on 3/20/16.
//  Copyright (c) 2016 Naga Praveen Kumar Pendyala. All rights reserved.
//

import UIKit

class AddOwnerViewController: UIViewController {
    
    @IBOutlet weak var firstNameLabel: UITextField!
    @IBOutlet weak var lastNameLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // when cancel button pressed dismiss the add owner modal
    @IBAction func cancelButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: { () -> Void in

        })
    }
    
    // when done button pressed, add the owner and dismiss the add owner modal
    @IBAction func doneButton(sender: AnyObject) {
        uploadData()
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }

    // add the owner using POST request
    func uploadData()
    {   var alert: UIAlertView? = nil
        if let url = NSURL(string: "http://www.jorjabrown.us/petstore/api/owners/add") {
        let session = NSURLSession.sharedSession()
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData
        let uploadData = "fname=\(firstNameLabel.text)&lname=\(lastNameLabel.text)".dataUsingEncoding(NSUTF8StringEncoding)
        let task = session.uploadTaskWithRequest(request, fromData: uploadData) {
        (data, response, error) in
        let httpResponse = response as? NSHTTPURLResponse
        if httpResponse!.statusCode != 200 {
        // Perform some error handling, other status codes should be
        // handled as well
        alert = UIAlertView(title: "HTTP Error:", message: "status code \(httpResponse!.statusCode)", delegate: self, cancelButtonTitle: "OK")
        } else if (data == nil && error != nil) {
        alert = UIAlertView(title: "Error", message: "No response data downloaded", delegate: self, cancelButtonTitle: "OK")
        } else {
        println("response data downloaded")
            let dataString = NSString(data: data, encoding: NSUTF8StringEncoding) as! String
        println(dataString) }
        }
        task.resume()
    } else {
        alert = UIAlertView(title: "Error", message: "Invalid URL", delegate: self, cancelButtonTitle: "OK")
        } }
    
}