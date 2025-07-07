//
//  ViewModelTests.swift
//  Debt Tracker
//
//  Created by Vladyslav Danyliak on 23.06.2025.
//

import XCTest
@testable import Debt_Tracker

class ViewModelTests: XCTestCase {
    private var vm: ViewModel!
    
    override func setUpWithError() throws {
        vm = ViewModel()
    }
    
    override func tearDownWithError() throws {
        vm = nil
    }
    
    func test_decode_encode_transactions() {
        test_successfull_inc_add()
        XCTAssertNoThrow(try vm.loadTransactions())
    }
    
    func test_successfull_inc_add() {
        XCTAssertNoThrow(try executeAddFunc("100"))
    }
    
    func test_successfull_dec_add() {
        XCTAssertNoThrow(try executeAddFunc("-100"))
    }
    
    func test_unsuccessfull_inc_add() {
        XCTAssertThrowsError(try executeAddFunc("wrong_format"))
    }
    
    func test_successfull_removal() {
        test_successfull_inc_add()
        guard let firstTransaction = vm.transactions.first else {
            XCTFail(); return
        }
        XCTAssertNoThrow(try vm.remove(transaction: firstTransaction))
    }
    
    func test_unsuccessfull_removal() {
        XCTAssertThrowsError(try vm.remove(transaction: Transaction()))
    }
    
    private func executeAddFunc(_ value: String) throws -> Int {
        let count = vm.transactions.count
        try vm.add(value: value, date: .now)
        
        return count
    }
}
