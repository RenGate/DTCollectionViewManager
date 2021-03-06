//
//  StoryboardMappingTestCase.swift
//  DTCollectionViewManager
//
//  Created by Denys Telezhkin on 10.01.16.
//  Copyright © 2016 Denys Telezhkin. All rights reserved.
//

import XCTest
@testable import DTCollectionViewManager

class StoryboardMappingTestCase: XCTestCase {
    
    var controller : StoryboardViewController!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "FixtureStoryboard", bundle: Bundle(for: type(of: self)))
        controller = storyboard.instantiateInitialViewController() as? StoryboardViewController
        _ = controller.view
    }
    
    func testStoryboardCellIsCreatedAndOutletsAreWired() {
        controller.manager.register(StoryboardCollectionViewCell.self)
        controller.manager.memoryStorage.addItem(3)
        
        let cell = controller.manager.collectionDataSource?.collectionView(controller.collectionView!, cellForItemAt: indexPath(0, 0)) as? StoryboardCollectionViewCell
        
        XCTAssertNotNil(cell?.storyboardLabel)
    }
    
    func testSupplementaryHeadersAreRegisteredAndOutletsAreWired() {
        controller.manager.registerHeader(StoryboardCollectionReusableHeaderView.self)
        controller.manager.registerFooter(StoryboardCollectionReusableFooterView.self)
        
        
        controller.manager.memoryStorage.setSectionHeaderModels(["1"])
        controller.manager.memoryStorage.setSectionFooterModels(["2"])
        controller.manager.memoryStorage.setItems([1])
        
        if #available(iOS 9, *) {
            controller.collectionView?.performBatchUpdates(nil, completion: nil)
            
            let headerView = controller.manager.collectionDataSource?.collectionView(controller.collectionView!, viewForSupplementaryElementOfKind: DTCollectionViewElementSectionHeader, at:  indexPath(0, 0)) as? StoryboardCollectionReusableHeaderView
            
            let footerView = controller.manager.collectionDataSource?.collectionView(controller.collectionView!, viewForSupplementaryElementOfKind: DTCollectionViewElementSectionFooter, at:  indexPath(0, 0)) as? StoryboardCollectionReusableFooterView
            
            XCTAssertEqual(headerView?.storyboardLabel.text, "Header")
            XCTAssertEqual(footerView?.storyboardLabel.text, "Footer")
        }
        
    }
}
