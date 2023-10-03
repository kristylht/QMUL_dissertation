//
//  FoodItemViewModel.swift
//  DietFitFinal
//
//  Created by Kristy on 18/7/2023.
//

import Foundation

public class FoodItemViewModel: ObservableObject {
    @Published var foodItem = [FoodItem]()
    @Published var filteredFoodItems: [FoodItem] = []
    var searchText : String? = nil
    
    var filteredfoodItems: [FoodItem] {
        return foodItem.filter { item in
            if let searchText = searchText , !searchText.isEmpty {
                return item.name.range(of: searchText, options: .caseInsensitive) != nil
            }
            else {
                // No constraints, return all items
                return true
            }
        }
    }
    
  
    init(){
        fetchAllFitnessItem()
    }
    
    func fetchAllFitnessItem() {
        if let fileLocation = Bundle.main.url(forResource: "nutrition", withExtension: "json"){
            do{
                let data = try Data(contentsOf: fileLocation)
                let jsonDecoder = JSONDecoder()
                let dataFromJson = try jsonDecoder.decode([FoodItem].self, from: data)
                
                self.foodItem = dataFromJson
                filteredFoodItems = filteredfoodItems
                
            } catch {
                print(error)
            }
        }
    }
    
    
    func filterFoodItems(searchText: String? = nil) -> () {
        self.searchText = searchText
        filteredFoodItems = filteredfoodItems
    }
}

