//
//  Owner.swift
//  Pets
//
//  Created by Naga Praveen Kumar Pendyala on 3/17/16.
//  Copyright (c) 2016 Naga Praveen Kumar Pendyala. All rights reserved.
//

import Foundation

class Owner {
    
    var oid: Int
    var fname: String
    var lname: String
    
    //default initializer
    
    init(oid: Int,fname: String, lname: String){
        
        self.oid = oid
        self.fname = fname
        self.lname = lname
    }
}
