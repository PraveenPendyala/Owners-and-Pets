//
//  Owner.swift
//  Pets
//
//  Created by Naga Praveen Kumar Pendyala on 3/17/16.
//  Copyright (c) 2016  Naga Praveen Kumar Pendyala. All rights reserved.
//

import Foundation

class Pet {
    
    var oid: Int
    var pid: Int
    var name: String
    var type: String
    var breed: String
    var fname: String
    var lname: String
    
    //default initializer
    
    init(oid: Int, pid: Int, name: String, type: String, breed: String, fname: String, lname: String){
        
        self.oid = oid
        self.pid = pid
        self.name = name
        self.type = type
        self.breed = breed
        self.fname = fname
        self.lname = lname
    }
}
