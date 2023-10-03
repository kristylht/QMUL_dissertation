//
//  FitnessItemViewModel.swift
//  DietFitFinal
//
//  Created by Kristy on 12/7/2023.
//

import Foundation

public class FitnessItemViewModel: ObservableObject {
    @Published var fitnessItem = [FitnessItem]()
   // @Published var ItemName = ""
    @Published var filteredFitnessItems: [FitnessItem] = []
    var searchText : String? = nil
    var selectedMuscle:  String? = nil
    var selectedLevel:  String? = nil
    
    var filteredItems: [FitnessItem] {
        return fitnessItem.filter { item in
            if let muscle = selectedMuscle, let level = selectedLevel {
                // Filter by both muscle and level constraints
                return item.primaryMuscles.contains(muscle) && item.level == level
            } else if let muscle = selectedMuscle {
                // Filter by muscle constraint only
                return item.primaryMuscles.contains(muscle)
            } else if let level = selectedLevel {
                // Filter by level constraint only
                return item.level == level
            } else if let searchText = searchText , !searchText.isEmpty {
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
        if let fileLocation = Bundle.main.url(forResource: "exercises", withExtension: "json"){
            do{
                let data = try Data(contentsOf: fileLocation)
                let jsonDecoder = JSONDecoder()
                let dataFromJson = try jsonDecoder.decode([FitnessItem].self, from: data)
                
                self.fitnessItem = dataFromJson
                filteredFitnessItems = filteredItems
                
            } catch {
                print(error)
            }
        }
    }
    
    func filterItems(selectedMuscle: String? = nil, selectedLevel: String? = nil, searchText: String? = nil) -> () {
        self.selectedMuscle = selectedMuscle
        self.selectedLevel = selectedLevel
        self.searchText = searchText
        filteredFitnessItems = filteredItems
    }
    
    
    

}
