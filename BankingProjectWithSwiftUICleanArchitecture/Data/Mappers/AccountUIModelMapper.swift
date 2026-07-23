//
//  AccountUIModelMapper.swift
//  BankingProjectWithSwiftUICleanArchitecture
//
//  Created by Ajay Mishra on 23/07/2026.
//


import Foundation

public struct AccountUIModelMapper {
    
    public static func map(from domainAccounts: [BankingAccount]) -> [AccountUIModel] {
        return domainAccounts.map { account in
            AccountUIModel(id: account.id,
                           accountName: account.accountName,
                           accountNumber: "\(account.accountNumber.suffix(4))",
                           formattedBalance: "₹\(String(format: "%.2f", account.availableBalance))",
                           accounttype: account.accountType.rawValue,
                           isBalanceNegative: account.availableBalance < 0)
        }
    }
}
