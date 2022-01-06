//
//  LoginViewModelTest.swift
//  FidelidadeTests
//
//  Created by Raphael de Jesus on 30/12/21.
//

@testable import Fidelidade
import XCTest
import Observable

class LoginViewModelTest: XCTestCase {
    
    var viewModel: LoginViewModel?
//    private var disposal: Disposal!
    private lazy var loginUseCaseMock = LoginUseCaseProtocolMock()

    override func setUp() {
        viewModel = LoginViewModel(loginUseCase: loginUseCaseMock)
//        disposal = Disposal()
    }
    
    override func tearDown() {
      viewModel = nil
//        disposal = nil
    }
    
    func testLoginCode403Error() {
        let expec = expectation(description: "wait the login flow finish")
        expec.expectedFulfillmentCount = 2
        loginUseCaseMock.handleLoginHandler = { _, completion in
            expec.fulfill()
            return completion(.failure(.decodingError))
        }
        viewModel?.isLogged.observe { result, _ in
            guard let result = result else {
                XCTFail("result was not instacied")
                expec.fulfill()
                return
            }
            XCTAssertFalse(result.isError)
            XCTAssertEqual(result.error, NetworkError.decodingError.description)
            expec.fulfill()
        }
        viewModel?.handleLogin(loginModel: LoginModel(cpf: "11111111111", password: "teste123"))
        wait(for: [expec], timeout: 5)
        
    }
    

}

