//
//  Items.swift
//  IMDTest
//
//  Created by Agil Febrianistian on 9/16/17.
//  Copyright © 2017 Agil Febrianistian. All rights reserved.
//

import Foundation
import SwiftyJSON

class Items {
    
    var timestamp : String!
    var update_timestamp : String!
    var readings : JSON!
        
    init(_ timestamp : String, _ update_timestamp : String, _ readings : JSON){
        self.timestamp = timestamp
        self.update_timestamp = update_timestamp
        self.readings = readings
    }
}





