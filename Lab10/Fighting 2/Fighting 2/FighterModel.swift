//
//  FighterModel.swift
//  Fighting 2
//
//  Created by Assylzhan on 28.11.2025.
//

import Foundation

nonisolated
struct FighterModel: Codable{
    let id: Int
    let name: String
    let images: FighterImage
    let powerstats: Powerstats
    let biography: Biography
    
    struct Powerstats: Codable{
        let intelligence: Int
        let strength: Int
        let speed: Int
        let durability: Int
        let power: Int
        let combat: Int
    }
    
    struct Biography: Codable{
        let alignment: String
    }
    
    struct FighterImage: Codable{
        let md: String
    }
}
