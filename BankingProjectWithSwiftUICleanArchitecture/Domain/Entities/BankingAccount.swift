//
//  BankingAccount.swift
//  BankingProjectWithSwiftUICleanArchitecture
//
//  Created by Ajay Mishra on 20/07/2026.
//


import Foundation

public struct BankingAccount {
    public let id: String
    public let accountName: String
    public let accountNumber: String
    public let availableBalance: Double
    public let accountType: AccountType
    
    public init(id: String, accountName: String, accountNumber: String, availableBalance: Double, accountType: AccountType) {
        self.id = id
        self.accountName = accountName
        self.accountNumber = accountNumber
        self.availableBalance = availableBalance
        self.accountType = accountType
    }
}

public enum AccountType: String {
    case savings
    case checking
    case creditCard
}
