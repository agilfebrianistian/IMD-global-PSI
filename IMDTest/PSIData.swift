//
//  PSIData.swift
//  IMDTest
//
//  Created by Agil Febrianistian on 9/16/17.
//  Copyright © 2017 Agil Febrianistian. All rights reserved.
//

import Foundation

class PSIData {
    
    var regionMetadata : [RegionMetadata]!
    var items : [Items]!
    
    init(){}
    
    init(_ regionMetadata : [RegionMetadata], _ items : [Items]){
        self.regionMetadata = regionMetadata
        self.items = items
    }
}
