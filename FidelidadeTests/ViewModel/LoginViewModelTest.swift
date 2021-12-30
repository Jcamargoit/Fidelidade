//
//  LoginViewModelTest.swift
//  FidelidadeTests
//
//  Created by Raphael de Jesus on 30/12/21.
//

@testable import Fidelidade
import Observable
import XCTest

class LoginViewModelTest: XCTestCase {
    
    var viewModel: LoginViewModel?
    var loginUseCaseMock = LoginUseCaseProtocolMock()

    override func setUp() {
        viewModel = LoginViewModel(loginUseCase: loginUseCaseMock)
    }
    
    override func tearDown() {
      viewModel = nil
    }
    
    func testLoginCode403Error() {
        let expec = expectation(description: "wait the login flow finish")
        loginUseCaseMock.handleLoginHandler = { _, completion in
            expec.fulfill()
            return completion(.failure(.decodingError))
        }
        
        viewModel?.handleLogin(loginModel: LoginModel(cpf: "11111111111", password: "teste123"))
        waitForExpectations(timeout: 5, handler: nil)
        
    }
    

}

