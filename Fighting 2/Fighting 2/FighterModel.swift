//
//  FighterModel.swift
//  Fighting 2
//
//  Created by Assylzhan on 28.11.2025.
//

import Foundation

struct FighterModel: Decodable{
    let id: Int
    let name: String
    let images: FighterImage
    let powerstats: Powerstats
    let biography: Biography
    
    struct Powerstats: Decodable{
        let intelligence: Int
        let strength: Int
        let speed: Int
        let durability: Int
        let power: Int
        let combat: Int
    }
    
    struct Biography: Decodable{
        let alignment: String
    }
    
    struct FighterImage: Decodable{
        let md: String
    }
}
