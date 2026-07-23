//
//  DashboardViewModel.swift
//  BankingProjectWithSwiftUICleanArchitecture
//
//  Created by Ajay Mishra on 20/07/2026.
//


import Foundation
import Combine

public enum DashboardViewState {
    case idle
    case loading
    case success([AccountUIModel])
    case error(String)
}

public final class DashboardViewModel: ObservableObject {
    
    // 1. Single Source of Truth
    @Published public private(set) var state: DashboardViewState = .idle
    
    private let fetchDashboardUseCase: FetchDashboardUseCaseProtocol
    private var cancellables = Set<AnyCancellable>()
    
    public init(fetchDashboardUseCase: FetchDashboardUseCaseProtocol) {
        self.fetchDashboardUseCase = fetchDashboardUseCase
    }
    
    public func loadData() {
        // Instantly transition to loading
        state = .loading
        
        fetchDashboardUseCase.execute()
            .map { domainAccounts in
                return AccountUIModelMapper.map(from: domainAccounts)
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }
                
                if case .failure(let error) = completion {
                    // Transition to error state
                    self.state = .error(error.localizedDescription)
                }
            } receiveValue: { [weak self] uiModels in
                guard let self = self else { return }
                
                // Transition to success state, injecting the data directly into the enum!
                self.state = .success(uiModels)
            }
            .store(in: &cancellables)
    }
}
