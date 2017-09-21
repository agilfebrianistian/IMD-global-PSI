//
//  IMDTestTests.swift
//  IMDTestTests
//
//  Created by Agil Febrianistian on 9/16/17.
//  Copyright © 2017 Agil Febrianistian. All rights reserved.
//

import XCTest
import Quick
import Nimble
import SwiftyJSON

@testable import IMDTest

class ProviderSpec: QuickSpec {
    
    override func spec() {
        
        describe("PSI Data Provider") {
            let provider = PSIDataProvider()
            let jsonData = JSON([])
            
            context("After connected to server") {
                
                it("can parse region data") {
                    expect(provider.parseToRegion(jsonData)).toNot(beNil())
                    expect(provider.parseToRegion(jsonData)).to(beAKindOf(RegionMetadata.self))
                }
                
                it("can parse items data") {
                    expect(provider.parseToItems(jsonData)).toNot(beNil())
                    expect(provider.parseToItems(jsonData)).to(beAKindOf(Items.self))
                }
                
            }
        }
    }
}

class PSIDetailsSpec: QuickSpec {
    
    override func spec() {
        
        describe("PSI details chart and table") {
            let detailsPage = PSIDetailsVC()
            detailsPage.items = [Items("","",JSON([]))]
            
            context("After page showed") {
                it("can parse region data") {
                    expect(detailsPage.readings()).toNot(beNil())
                }
            }
        }
    }
}
