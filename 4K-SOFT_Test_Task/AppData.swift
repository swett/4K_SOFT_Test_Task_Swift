//
//  AppData.swift
//  4K-SOFT_Test_Task
//
//  Created by Vitaliy Griza on 08.09.2022.
//

import UIKit

class AppData: NSObject {
    
    
    fileprivate override init() {
        super.init()
        loadData()
    }
    
    
    var doorsArray: [DoorsItem] = []
    
//    let array = Bundle.main.decode(DoorsItem.self, from: "Data.json")
 
    func loadData() {

        // google json to make items of DoorsItem
        if let fileLocation = Bundle.main.url(forResource: "Data", withExtension: "json") {
            do {
                print(fileLocation)
                let data = try Data(contentsOf: fileLocation)
                print(data)
                let jsonDecoder = JSONDecoder()
                let dataFromJson = try jsonDecoder.decode([DoorsItem].self, from: data)
                print(dataFromJson)
                self.doorsArray = dataFromJson
            } catch {
                print("pizdec, \(error)")
            }
        }
    }
    
    static let shared: AppData = AppData()
}


