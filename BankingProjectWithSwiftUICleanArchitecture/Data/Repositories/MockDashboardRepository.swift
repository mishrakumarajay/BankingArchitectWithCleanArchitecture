//
//  MockDashboardRepository.swift
//  BankingProjectWithSwiftUICleanArchitecture
//
//  Created by Ajay Mishra on 20/07/2026.
//


import Foundation
import Combine
// Notice we DO NOT import SwiftUI here.

public final class MockDashboardRepository: DashboardRepositoryProtocol {
    
    public init() {}
    
    public func fetchCustomerAccounts() -> AnyPublisher<[BankingAccount], Error> {
        // We simulate a network delay of 1.5 seconds, then return fake data
        let fakeAccounts = [
            BankingAccount(id: "1", accountName: "Premium Savings", accountNumber: "9876543210", availableBalance: 150000.50, accountType: .savings),
            BankingAccount(id: "2", accountName: "Salary Checking", accountNumber: "1122334455", availableBalance: 5500.00, accountType: .checking),
            // This negative account should be filtered out by our Domain Use Case!
            BankingAccount(id: "3", accountName: "Old Checking", accountNumber: "9999999999", availableBalance: -50.0, accountType: .checking)
        ]
        
        return Just(fakeAccounts)
            .setFailureType(to: Error.self)
            .delay(for: .seconds(1.5), scheduler: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}