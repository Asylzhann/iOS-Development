//
//  Card.swift
//  doDep
//
//  Created by Assylzhan on 18.12.2025.
//

import Foundation

nonisolated
struct Card: Codable, Sendable {
    let id: Int
    let name: String
    let images: HeroImage

    var bonusDescription: String {
        switch id {
        case 70:  return "💰 +1% win reward"
        case 100: return "💰 +2% win reward"
        case 149: return "⏱️ $1/sec passive income"
        case 194: return "💰 +1% win reward"
        case 280: return "🔘 +$5 per circle tap"
        case 313: return "🔘 +$5 per circle tap"
        case 370: return "⏱️ $1/sec passive income"
        case 644: return "🔘 +$10 per circle tap"
        case 655: return "⏱️ $2/sec passive income"
        case 687: return "💰 +1% win reward"
        default: return "Rare Collectible"
        }
    }
}

struct HeroImage: Codable, Sendable {
    let sm: String
}
