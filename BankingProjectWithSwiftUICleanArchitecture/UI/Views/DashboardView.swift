//
//  DashboardView.swift
//  BankingProjectWithSwiftUICleanArchitecture
//
//  Created by Ajay Mishra on 20/07/2026.
//


import SwiftUI

public struct DashboardView: View {
    
    // The View only talks to the ViewModel. It knows nothing about Use Cases or Repositories.
    @StateObject private var viewModel: DashboardViewModel
    
    public init(viewModel: DashboardViewModel) {
        // We use _viewModel to initialize a @StateObject via dependency injection
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView("Fetching Accounts...")
                } else if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                } else {
                    List(viewModel.accounts) { account in
                        HStack {
                            Text(account.displayName)
                                .font(.headline)
                            Spacer()
                            Text(account.formattedBalance)
                                .foregroundColor(account.isBalanceNegative ? .red : .primary)
                                .fontWeight(.bold)
                        }
                    }
                }
            }
            .navigationTitle("HSBC Dashboard")
            .onAppear {
                viewModel.loadData()
            }
        }
    }
}