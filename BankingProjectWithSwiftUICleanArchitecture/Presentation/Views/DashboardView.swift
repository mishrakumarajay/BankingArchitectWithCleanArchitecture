//
//  DashboardView.swift
//  BankingProjectWithSwiftUICleanArchitecture
//
//  Created by Ajay Mishra on 20/07/2026.
//


import SwiftUI

struct DashboardView: View {
    
    @StateObject private var viewModel: DashboardViewModel
    
    init(viewModel: DashboardViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            Group {
                // 1. The Switch Statement dictates the UI
                switch viewModel.state {
                    
                case .idle, .loading:
                    // Show a spinner while fetching
                    ProgressView("Fetching Vault Data...")
                    
                case .success(let accounts):
                    // The accounts array is safely extracted from the enum
                    ScrollView {
                        LazyVStack(spacing: 0) {
                            ForEach(accounts, id: \.id) { accountUIModel in
                                AccountRowView(account: accountUIModel)
                                Divider().padding(.leading, 16)
                            }
                        }
                    }
                    
                case .error(let message):
                    // Show an error view
                    VStack {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundColor(.red)
                            .font(.largeTitle)
                        Text(message)
                            .font(.headline)
                            .multilineTextAlignment(.center)
                            .padding()
                    }
                }
            }
            .navigationTitle("Accounts")
            .onAppear {
                viewModel.loadData()
            }
        }
    }
}
