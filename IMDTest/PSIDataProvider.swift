//
//  PSIDataProvider.swift
//  IMDTest
//
//  Created by Agil Febrianistian on 9/16/17.
//  Copyright © 2017 Agil Febrianistian. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import CircularSpinner
import SCLAlertView

protocol PSIDataProviderProtocol {
    func getPSIData(_ stringDate : String, _ onCompleted: @escaping (PSIData) -> Void)
}

class PSIDataProvider : NSObject, PSIDataProviderProtocol, CircularSpinnerDelegate {
    
    func getPSIData(_ stringDate: String, _ onCompleted: @escaping (PSIData) -> Void) {
        CircularSpinner.show("loading", animated: true, type: .indeterminate, showDismissButton: false, delegate: self)
        apiProvider.request(ApiConstant.getPSIData(stringDate: stringDate)) { result in
            switch result {
            case let .success(response):
                let json = JSON(response.data)
                switch response.statusCode {
                case 200..<300:
                    var regions = [RegionMetadata]()
                    var items = [Items]()
                    
                    for data in json["region_metadata"].array! {
                        regions.append(self.parseToRegion(data))
                    }
                    for data in json["items"].array! {
                        items.append(self.parseToItems(data))
                    }
                    onCompleted(PSIData(regions,items))
                    break
                case 300..<600:
                    _ = SCLAlertView().showWarning("Warning", subTitle: "data not found")
                    break
                default:
                    return
                }
            case let .failure(error):
                _ = SCLAlertView().showWarning("Warning", subTitle: error.localizedDescription)
            }
            CircularSpinner.hide()
        }
    }
    
    func parseToRegion(_ j : JSON) -> RegionMetadata{
        
        let name = j["name"].stringValue
        let locations = j["label_location"]
        let latitude = locations["latitude"].doubleValue
        let longitude = locations["longitude"].doubleValue
        
        return RegionMetadata(name, Location(latitude,longitude))
    }
    
    func parseToItems(_ j : JSON) -> Items{
        
        let timestamp = j["timestamp"].stringValue
        let update_timestamp = j["update_timestamp"].stringValue
        let readingData = j["readings"]
        
        return Items(timestamp, update_timestamp, readingData)
    }
}




