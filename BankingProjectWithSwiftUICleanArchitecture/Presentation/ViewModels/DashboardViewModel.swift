//
//  DashboardViewModel.swift
//  BankingProjectWithSwiftUICleanArchitecture
//
//  Created by Ajay Mishra on 20/07/2026.
//


import Foundation
import Combine

public final class DashboardViewModel: ObservableObject {
    
    // 1. UI State (The Data binding for SwiftUI)
    @Published public private(set) var accounts: [AccountUIModel] = []
    @Published public private(set) var errorMessage: String? = nil
    @Published public private(set) var isLoading: Bool = false
    
    // 2. Dependencies & Memory Management
    private let fetchDashboardUseCase: FetchDashboardUseCaseProtocol
    private var cancellables = Set<AnyCancellable>()
    
    // Constructor Dependency Injection
    public init(fetchDashboardUseCase: FetchDashboardUseCaseProtocol) {
        self.fetchDashboardUseCase = fetchDashboardUseCase
    }
    
    // 3. The Action Triggered by the View
    public func loadData() {
        isLoading = true
        errorMessage = nil
        
        fetchDashboardUseCase.execute()
            .receive(on: DispatchQueue.main) // Force UI updates to Main Thread
            .sink { [weak self] completion in
                guard let self = self else { return }
                self.isLoading = false
                
                // THIS is where the Error Track ends up!
                if case .failure(let error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] domainAccounts in
                guard let self = self else { return }
                
                // Map the pure Domain Entities to UI Models
                self.accounts = domainAccounts.map { account in
                    AccountUIModel(
                        id: account.id,
                        displayName: "\(account.accountName) (\(account.accountNumber.suffix(4)))",
                        formattedBalance: "₹\(String(format: "%.2f", account.availableBalance))",
                        isBalanceNegative: account.availableBalance < 0
                    )
                }
            }
            .store(in: &cancellables) // Binds subscription lifecycle to the ViewModel
    }
}