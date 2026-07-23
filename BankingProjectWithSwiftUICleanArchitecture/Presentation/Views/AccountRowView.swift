//
//  AccountRowView.swift
//  BankingProjectWithSwiftUICleanArchitecture
//
//  Created by Ajay Mishra on 23/07/2026.
//

import SwiftUI

struct AccountRowView: View {
    
    // 1. Accepts the UI Model provided by the ViewModel
    let account: AccountUIModel
    
    var body: some View {
        HStack {
            // 2. The ViewModel already combined the Name and Account Number
            VStack {
                Text(account.accountName)
                    .font(.headline)
                    .fontWeight(.bold)
                
                Spacer()
                
                Text(account.accountNumber)
                    .font(.subheadline)
                    .fontWeight(.medium)
            }
            
            Spacer()
            
            VStack {
                Text(account.accounttype)
                    .font(.title3)
                    .fontWeight(.bold)
                
                Spacer()
                
                Text(account.formattedBalance)
                    .font(.headline)
                    .foregroundColor(account.isBalanceNegative ? .red : .primary)
            }
            
            
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
    }
}

