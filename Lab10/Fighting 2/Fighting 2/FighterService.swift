//
//  File.swift
//  Fighting 2
//
//  Created by Assylzhan on 28.11.2025.
//

import Foundation
import Alamofire

protocol FighterServiceDelegate{
    func onFightersFetched(model1: FighterModel, model2: FighterModel)
}

struct FighterService{
    
    var delegate: FighterServiceDelegate?
    
    func fetchFighters(){
        let randomId1 = Int.random(in: 1...731)
        var randomId2 = Int.random(in: 1...731)
        while randomId1 == randomId2{
            randomId2 = Int.random(in: 1...731)
        }
        let urlString1 = "https://akabab.github.io/superhero-api/api/id/\(randomId1).json"
        let urlString2 = "https://akabab.github.io/superhero-api/api/id/\(randomId2).json"
        AF.request(urlString1).responseDecodable(of: FighterModel.self) { response in
            switch response.result {
            case .success(let fighter1):
                AF.request(urlString2).responseDecodable(of: FighterModel.self) { response in
                    switch response.result {
                    case .success(let fighter2):
                        delegate?.onFightersFetched(model1: fighter1, model2: fighter2)
                    case .failure(let error):
                        debugPrint(error)
                    }
                }
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
}
