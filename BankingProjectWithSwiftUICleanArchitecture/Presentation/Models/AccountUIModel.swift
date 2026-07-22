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
    public let displayName: String
    public let formattedBalance: String
    public let isBalanceNegative: Bool
    
    public init(id: String, displayName: String, formattedBalance: String, isBalanceNegative: Bool) {
        self.id = id
        self.displayName = displayName
        self.formattedBalance = formattedBalance
        self.isBalanceNegative = isBalanceNegative
    }
}