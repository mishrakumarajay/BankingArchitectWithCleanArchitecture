//
//  BankingProjectWithSwiftUICleanArchitectureApp.swift
//  BankingProjectWithSwiftUICleanArchitecture
//
//  Created by Ajay Mishra on 20/07/2026.
//

import SwiftUI

@main
struct BankingProjectWithSwiftUICleanArchitectureApp: App {
    var body: some Scene {
        WindowGroup {
            // PREVIOUS MOCK:
            // let repository = MockDashboardRepository()
            
            // NEW LIVE NETWORK:
            let repository = LiveDashboardRepository()
            
            let useCase = FetchDashboardUseCase(repository: repository)
            let viewModel = DashboardViewModel(fetchDashboardUseCase: useCase)
            
            // Inject the fully built ViewModel into the View
            DashboardView(viewModel: viewModel)
        }
    }
}
