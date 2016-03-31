//
//  AddPetViewController.swift
//  Pets
//
//  Created by Naga Praveen Kumar Pendyala on 3/20/16.
//  Copyright (c) 2016 Naga Praveen Kumar Pendyala. All rights reserved.
//

import UIKit

class AddPetViewController: UIViewController {
    
    @IBOutlet weak var petNameTextField: UITextField!
    @IBOutlet weak var petTypeTextField: UITextField!
    @IBOutlet weak var breedTextField: UITextField!
    @IBOutlet weak var ownerIDTextField: UITextField!
    @IBOutlet weak var dobTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // when the cancel button pressed dismiss the add pet modal
    @IBAction func cancelButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }
    
    // done button pressed, add the pet and dismiss the add pet modal
    @IBAction func doneButton(sender: AnyObject) {
        uploadData()
        dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }
    
    // add the pet using POST
    func uploadData()
    {   var alert: UIAlertView? = nil
        if let url = NSURL(string: "http://www.jorjabrown.us/petstore/api/pets/add") {
        let session = NSURLSession.sharedSession()
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData
        let uploadData = "name=\(petNameTextField.text)&type=\(petTypeTextField.text)&breed=\(breedTextField.text)&oid=\(ownerIDTextField.text)&dob=\(dobTextField)".dataUsingEncoding(NSUTF8StringEncoding)
        let task = session.uploadTaskWithRequest(request, fromData: uploadData) {
            (data, response, error) in
            let httpResponse = response as? NSHTTPURLResponse
            if httpResponse!.statusCode != 200 {
                // Perform some error handling, other status codes should be
                // handled as well
                alert = UIAlertView(title: "HTTP Error:", message: "status code \(httpResponse!.statusCode)", delegate: self, cancelButtonTitle: "OK") } else if (data == nil && error != nil) {
                alert = UIAlertView(title: "Error", message: "No response data downloaded", delegate: self, cancelButtonTitle: "OK")} else {
                println("response data downloaded")
                let dataString = NSString(data: data, encoding: NSUTF8StringEncoding) as! String
                println(dataString) }
        }
        task.resume()
    } else {
        alert = UIAlertView(title: "Error", message: "Invalid URL", delegate: self, cancelButtonTitle: "OK")
        } }
    
}
