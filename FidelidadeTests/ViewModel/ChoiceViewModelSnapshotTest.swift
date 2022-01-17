//
//  RecoverPasswordViewController.swift
//  FidelidadeTests
//
//  Created by Juninho on 14/01/22.
//

import XCTest
@testable import Fidelidade
import SnapshotTesting

class ChoiceViewControllerSnapshotTest: XCTestCase {
    
    var devices: [String: ViewImageConfig]? = ["iPhoneX": .iPhoneX,
                                                      "iPhone8": .iPhone8,
                                                      "iPhoneSe": .iPhoneSe]
    
    
    override func setUp() {
        isRecording = false
        
    }
    
    override func tearDown() {
        devices = nil
    }
    
    
    func test_choiceSnapshotTest(){
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let sut = storyboard.instantiateViewController(withIdentifier: "ChoiceViewController") as UIViewController
        
            sut.beginAppearanceTransition(true, animated: false)
            sut.endAppearanceTransition()
        
        let results = devices?.map { key, value in
            verifySnapshot(matching: sut, as: .image(on: value), named: "default", testName: "ChoiceViewController+\(key)")
        }
        
        results?.forEach { XCTAssertNil($0) }
    
    }


}
