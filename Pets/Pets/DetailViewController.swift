//
//  DetailViewController.swift
//  Pets
//
//  Created by Naga Praveen Kumar Pendyala on 3/17/16.
//  Copyright (c) 2016 Naga Praveen Kumar Pendyala. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var breedLabel: UILabel!
    @IBOutlet weak var ownerLabel: UILabel!
    


    var detailItem: Pet? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail: Pet = self.detailItem {
            if let label = self.nameLabel {
                label.text = detail.name
            }
            if let label = self.typeLabel {
                label.text = detail.type
            }
            if let label = self.breedLabel {
                label.text = detail.breed
            }
            if let label = self.ownerLabel {
                label.text = "\(detail.fname) \(detail.lname)"
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

