//
//  AccountDTO.swift
//  BankingProjectWithSwiftUICleanArchitecture
//
//  Created by Ajay Mishra on 20/07/2026.
//


// In the Network/Data Layer
struct AccountDTO: Decodable {
    let account_id: String
    let name: String
    let acc_num: String
    let bal: Double
    let type_code: String
}
