//
//  RegionMetadata.swift
//  IMDTest
//
//  Created by Agil Febrianistian on 9/16/17.
//  Copyright © 2017 Agil Febrianistian. All rights reserved.
//

import Foundation

class RegionMetadata {
    
    var name : String!
    var labelLocation : Location!
    
    init(_ name : String, _ labelLocation : Location){
        self.name = name
        self.labelLocation = labelLocation
    }
}


