//
//  FetchDashboardUseCaseProtocol.swift
//  BankingProjectWithSwiftUICleanArchitecture
//
//  Created by Ajay Mishra on 20/07/2026.
//


import Foundation
import Combine

// 1. The Protocol for the ViewModel to talk to
public protocol FetchDashboardUseCaseProtocol {
    func execute() -> AnyPublisher<[BankingAccount], Error>
}

// 2. The Concrete Implementation
public final class FetchDashboardUseCase: FetchDashboardUseCaseProtocol {
    
    private let repository: DashboardRepositoryProtocol
    
    // Constructor Dependency Injection
    public init(repository: DashboardRepositoryProtocol) {
        self.repository = repository
    }
    
    public func execute() -> AnyPublisher<[BankingAccount], Error> {
        return repository.fetchCustomerAccounts()
            .map { accounts in
                // Business Rule: Filter out any closed accounts with negative balances
                return accounts.filter { $0.availableBalance >= 0 }
            }
            .eraseToAnyPublisher() // Hides the complex mapping type from the caller
    }
}