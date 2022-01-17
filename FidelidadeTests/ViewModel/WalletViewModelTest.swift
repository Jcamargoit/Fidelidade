//
//  WalletViewModelTest.swift
//  FidelidadeTests
//
//  Created by Juninho on 14/01/22.
//

import XCTest
import Observable
@testable import Fidelidade


class WalletViewModelTest: XCTestCase {

    var viewModel: WalletViewModel?
    private var disposal: Disposal!
    private var walletUseCaseMock: WalletUseCaseProtocolMock!
    private weak var _viewModel: WalletViewModel?
    
    override func setUp() {
        super.setUp()
        walletUseCaseMock = WalletUseCaseProtocolMock()
        viewModel = WalletViewModel(walletUseCase: walletUseCaseMock)
        _viewModel = viewModel
        disposal = Disposal()
    }
    
    override func tearDown() {
        viewModel = nil
        disposal = nil
        walletUseCaseMock = nil
        XCTAssertNil(_viewModel)
        super.tearDown()
    }
    
    
    
    
    func testgetWalletsById() {
        //expec - verifica se o processo finalizou ou não
        let expec = expectation(description: "Loading Api get")
        expec.expectedFulfillmentCount = 2
        
//        walletUseCaseMock.getWalletsByIdHandler = { _, completion in
//            expec.fulfill()
//            return completion(.success("Api-get-success"))
//        }

        
        
    }
    
    
    
    
    
}
