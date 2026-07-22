//
//  DashboardRepositoryProtocol.swift
//  BankingProjectWithSwiftUICleanArchitecture
//
//  Created by Ajay Mishra on 20/07/2026.
//


import Foundation
import Combine

public protocol DashboardRepositoryProtocol {
    // Returns a stream that either emits an array of accounts or an Error
    func fetchCustomerAccounts() -> AnyPublisher<[BankingAccount], Error>
}