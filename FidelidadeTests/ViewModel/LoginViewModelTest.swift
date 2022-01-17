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
    private var disposal: Disposal!
    private var loginUseCaseMock: LoginUseCaseProtocolMock!
    private weak var _viewModel: LoginViewModel?
    
    override func setUp() {
        super.setUp()
        loginUseCaseMock = LoginUseCaseProtocolMock()
        viewModel = LoginViewModel(loginUseCase: loginUseCaseMock)
        _viewModel = viewModel
        disposal = Disposal()
    }
    
    override func tearDown() {
        viewModel = nil
        disposal = nil
        loginUseCaseMock = nil
        XCTAssertNil(_viewModel)
        super.tearDown()
    }
    
    
    func testLoginSuccessful() {
        //expec - verifica se o processo finalizou ou não
        let expec = expectation(description: "wait the login flow finish success")
        expec.expectedFulfillmentCount = 2
        
        
        loginUseCaseMock.handleLoginHandler = { _, completion in
            expec.fulfill()
            return completion(.success("Key-success"))
        }
        viewModel?.isLogged.observe { result, _ in
            guard let result = result else {
                return
            }
            XCTAssertFalse(result.isError)
            XCTAssertEqual(result.data, "Key-success")
            expec.fulfill()
        }.add(to: &disposal)
        viewModel?.handleLogin(loginModel: LoginModel(cpf: "11111111111", password: "teste123"))
        wait(for: [expec], timeout: 1)
        XCTAssertEqual(loginUseCaseMock.handleLoginCallCount, 1)
        XCTAssertEqual(viewModel?.defaults.string(forKey: UserDefaultsKeys.userKey.rawValue), "Key-success")
        
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
                return
            }
            XCTAssertTrue(result.isError)
            XCTAssertEqual(result.error, NetworkError.decodingError.description)
            expec.fulfill()
        }.add(to: &disposal)
        viewModel?.handleLogin(loginModel: LoginModel(cpf: "11111111111", password: "teste123"))
        wait(for: [expec], timeout: 1)
        XCTAssertEqual(loginUseCaseMock.handleLoginCallCount, 1)
        
    }
    
}

