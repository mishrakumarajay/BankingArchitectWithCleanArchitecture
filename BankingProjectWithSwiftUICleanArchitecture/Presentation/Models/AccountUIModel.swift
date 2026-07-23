//
//  AccountUIModel.swift
//  BankingProjectWithSwiftUICleanArchitecture
//
//  Created by Ajay Mishra on 20/07/2026.
//


import Foundation

// Notice we only import Foundation here, but this model is tailored for the UI.
public struct AccountUIModel: Identifiable {
    public let id: String
    public let accountName: String
    public let accountNumber: String
    public let formattedBalance: String
    public let accounttype: String
    public let isBalanceNegative: Bool
    
    public init(id: String, accountName: String, accountNumber: String, formattedBalance: String, accounttype: String, isBalanceNegative: Bool) {
        self.id = id
        self.accountName = accountName
        self.accountNumber = accountNumber
        self.formattedBalance = formattedBalance
        self.accounttype = accounttype
        self.isBalanceNegative = isBalanceNegative
    }
}
