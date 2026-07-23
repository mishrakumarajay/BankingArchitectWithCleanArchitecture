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
        var generatedAccounts: [BankingAccount] = [BankingAccount]()
        var usedAccountNumbers = Set<String>()
        
        let firstNames = ["Liam", "Olivia", "Noah", "Emma", "Oliver", "Ava", "Elijah", "Charlotte"]
        let lastNames = ["Smith", "Johnson", "Williams", "Brown", "Jones", "Garcia", "Miller"]
        
        // Loop 100 times to create the data
        for ids in 1...100 {
            let randomName = "\(firstNames.randomElement()!) \(lastNames.randomElement()!)"
            
            // Loop until a truly unique random 8-digit account number is found
            var uniqueNumber = ""
            repeat {
                // STAFF FIX: Use Int.random(in:) for large ranges to prevent memory spikes
                uniqueNumber = String(Int.random(in: 10_000_000...99_999_999))
            } while usedAccountNumbers.contains(uniqueNumber)
            
            usedAccountNumbers.insert(uniqueNumber)
            
            // Note: Ensure your `AccountType` enum actually has a `.checking` case defined!
            let newAccount = BankingAccount(
                id: "\(ids)",
                accountName: randomName,
                accountNumber: "\(uniqueNumber)",
                availableBalance: 150000.50,
                accountType: ids % 2 == 0 ? .savings : .checking
            )
            generatedAccounts.append(newAccount)
        }
        
        return Just(generatedAccounts)
            .setFailureType(to: Error.self)
            // STAFF FIX: DispatchQueue strictly requires Ints. Use .milliseconds(1500) for 1.5 seconds.
            .delay(for: .milliseconds(1500), scheduler: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
