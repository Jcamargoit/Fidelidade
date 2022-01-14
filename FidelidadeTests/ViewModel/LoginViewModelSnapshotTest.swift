//
//  LoginViewModelSnapshotTest.swift
//  FidelidadeTests
//
//  Created by Raphael de Jesus on 12/01/22.
//

import XCTest
@testable import Fidelidade
import SnapshotTesting


class LoginViewModelSnapshotTest: XCTestCase {
    
    var devices: [String: ViewImageConfig]? = ["iPhoneX": .iPhoneX,
                                                      "iPhone8": .iPhone8,
                                                      "iPhoneSe": .iPhoneSe]
    override func setUp() {
        isRecording = false
    }
    
    override func tearDown() {
        devices = nil
    }
    
    func test_loginScreenSnapshot(){
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let sut = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as UIViewController
            sut.beginAppearanceTransition(true, animated: false)
            sut.endAppearanceTransition()
        
        let results = devices?.map { key, value in
            verifySnapshot(matching: sut, as: .image(on: value), named: "default", testName: "LoginViewController+\(key)")
        }
        
        results?.forEach { XCTAssertNil($0) }
    }

}
