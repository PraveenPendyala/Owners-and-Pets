//
//  MasterViewController.swift
//  Pets
//
//  Created by Naga Praveen Kumar Pendyala on 3/17/16.
//  Copyright (c) 2016 Naga Praveen Kumar Pendyala. All rights reserved.
//

import UIKit

class OwnerViewController: UITableViewController {

    var petViewController: PetViewController? = nil
    var owners = [Owner]()


    override func awakeFromNib() {
        super.awakeFromNib()
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            self.clearsSelectionOnViewWillAppear = false
            self.preferredContentSize = CGSize(width: 320.0, height: 600.0)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // To download JSON data
    func downloadData() {
        var alert: UIAlertView? = nil
        if let url = NSURL(string: "http://www.jorjabrown.us/petstore/api/owners/list") {
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url)
            { (data, response, error) in
                    let httpResponse = response as? NSHTTPURLResponse
                    if httpResponse!.statusCode != 200
                    {
                        // Perform some error handling, other status codes should be // handled as well
                        alert = UIAlertView(title: "HTTP Error:", message: "status code \(httpResponse!.statusCode)", delegate: self, cancelButtonTitle: "OK")
        
                    } else if (data == nil && error != nil)
                            {
                                alert = UIAlertView(title: "Error", message: "No data downloaded", delegate: self, cancelButtonTitle: "OK")
            
                            } else {
                        var error: NSError? = nil

                        if let dictionary: [AnyObject] = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &error) as? [AnyObject]{
                            
                            let array: [AnyObject] = dictionary
                            
                            self.owners.removeAll(keepCapacity: true)
                            
                            for dict in array{
                                let oid = dict["oid"] as! String
                                let fname = dict["fname"] as! String
                                let lname = dict["lname"] as! String
                                
                                self.owners.append(Owner(oid: oid.toInt()!, fname: fname, lname: lname ))
                               
                            }
                            dispatch_async(dispatch_get_main_queue()){
                                self.tableView.reloadData()
                            }
                        }
 
                                    }
            
            }
                    task.resume()
            
    } else {
                alert = UIAlertView(title: "Error", message: "Invalid URL", delegate: self, cancelButtonTitle: "OK")
            }
        alert?.show()
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "show" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let object = owners[indexPath.row] as Owner
                let controller = segue.destinationViewController as! PetViewController
                controller.owner = object.oid
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return owners.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("OwnerCell", forIndexPath: indexPath) as! UITableViewCell

        let object = owners[indexPath.row] as Owner
       cell.textLabel!.text = "\(object.fname) \(object.lname)"
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            //objects.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    // download the data and reload the table when view appears
    override func viewWillAppear(animated: Bool) {
        downloadData()
    }
}

