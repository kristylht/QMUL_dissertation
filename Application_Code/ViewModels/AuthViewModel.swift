//
//  AuthViewModel.swift
//  DietFitFinal
//
//  Created by Kristy on 3/7/2023.
//

// authentication with users
// form validation & networking for signing in
// updating UI with user data

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift
import SwiftUI

// class able to observe changes of the AuthViewModel
@MainActor
class AuthViewModel : ObservableObject{
    // whether or not we have a user logged in
    @Published var userSession: FirebaseAuth.UserInfo?
    @Published var currentUser: UserInfo?
    @Published var showAlert = false
    @Published var alertMessage = ""
    @Published var isActive = false
    @Published var showMainView = false
    @Published var showGoalView = false
    @Published var fitnessRecords : [EachFitnessRecord] = []
    @Published var dietRecords : [EachDietRecord] = []
    @Published var breakfastRecords : [EachDietRecord] = []
    @Published var lunchRecords : [EachDietRecord] = []
    @Published var dinnerRecords : [EachDietRecord] = []
    @Published var snacksRecords : [EachDietRecord] = []
    @Published var weightRecords : [EachUserWeight] = []
    @Published var totalCalories: Int = 0
    @Published var totalCarbohydrates: Int = 0
    @Published var totalProtein: Int = 0
    @Published var totalFat: Int = 0
    @Published var totalSugar: Double = 0
    @Published var totalFibre: Double = 0
    @Published var totalSaturatedFat: Double = 0
    @Published var totalCalcium: Double = 0
    @Published var totalIron: Double = 0
    @Published var totalPotassium: Double = 0
    @Published var totalSodium: Double = 0
    @Published var totalVitaminA: Double = 0
    @Published var totalVitaminC: Double = 0
    @Published var totalVitaminE: Double = 0
    @Published var totalVitaminB6: Double = 0
    @Published var totalVitaminB12: Double = 0
    @Published var weightLeft: Int = 0
    @Published var weightAlert: Bool = false
    
    init() {
        self.userSession = Auth.auth().currentUser
        Task{
            await fetchUserData()
        }
    }
    
    //log in function
    func signIn(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUserData()
            
        } catch {
            showAlert = true
            alertMessage = "Incorrect email or password"
            print("DEBUG: Failed to sign in with error \(error.localizedDescription)")
        }
    }
    
    // create user
    // async function that can potentially throw an error (with catch)
    func signUp(withEmail email: String, password: String, fullname: String) async throws {
        do {
            // create a user from firebase code and store to result
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            //set userSession property
            self.userSession = result.user
            //create my own user object and encode it through a codable protocol
            let user = UserInfo(id: result.user.uid, fullname: fullname, isActive: true, email: email,gender: "Male", height: 60, weight:60, dateOfBirth: Date(), activityLevel: "", targetWeight: 60 , targetDate: Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date())
            let encodedUser = try Firestore.Encoder().encode(user)
            // upload the data to Firestore
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            await fetchUserData()
            showGoalView = true
            
        } catch {
            //if catched error, print the error message
            print("DEBUG: Failed to sign up with error \(error.localizedDescription)")
            showAlert = true
            alertMessage = "password needs to contain at least 1 upper-case, 1 lower-case and 1 special characters"
        }
    }
    
    // sign out
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
            // self.isLoggedIn = false
        } catch {
            alertMessage = "Password must be at least 6 characters long, include 1 upper case and 1 special characters"
            showAlert = true
        }
    }
    
    
    // delete account
    func deleteAccount() {
        guard self.userSession != nil else {
            return
        }
        guard let uid = Auth.auth().currentUser?.uid else {return}
        Firestore.firestore().collection("users")
            .document(uid)
            .setData(["isActive":false,
                      "email" : "Deleted", "fullname" :"Deleted", "id" : "Deleted", "dateOfBirth": "Deleted","height": "Deleted","weight": "Deleted", "targetWeight": "Deleted", "targetDate": "Deleted"], merge: true)
        Auth.auth().currentUser? .delete()
        self.userSession = nil // take back to login view
        self.currentUser = nil
        
    }
    
    // fetch user data
    func fetchUserData() async {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else {return}
        self.currentUser = try? snapshot.data(as: UserInfo.self)
        weightLeft = abs(Int(Double(currentUser?.weight ?? 0) - Double(currentUser?.targetWeight ?? 0)))
    }
    
    
    func updateHeight(height:String){
        let heightInt = Int(height) ?? 0
        guard let uid = Auth.auth().currentUser?.uid else {return}
        Firestore.firestore().collection("users")
            .document(uid)
            .setData(["height": heightInt], merge: true)
    }
    
    func updateWeight(weight:String){
        let weightInt = Int(weight) ?? 0
        guard let uid = Auth.auth().currentUser?.uid else {return}
        Firestore.firestore().collection("users")
            .document(uid)
            .setData(["weight": weightInt], merge: true)
    
    }
    
    func updateDateOfBirth(dateOfBirth: Date){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        Firestore.firestore().collection("users")
            .document(uid)
            .setData(["dateOfBirth": dateOfBirth], merge: true)
    }
    
    func updateTargetWeight(targetWeight: String){
        let targetWeightInt = Int(targetWeight) ?? 0
        guard let uid = Auth.auth().currentUser?.uid else {return}
        Firestore.firestore().collection("users")
            .document(uid)
            .setData(["targetWeight": targetWeightInt], merge: true)
    }
    
    func updateTargetDate(targetDate: Date){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        Firestore.firestore().collection("users")
            .document(uid)
            .setData(["targetDate": targetDate], merge: true)
    }
    
    
    
    var age: Int {
        let calendar = Calendar.current
        let currentDate = Date()
        let ageComponents = calendar.dateComponents([.year], from: currentUser?.dateOfBirth ?? Date(), to: currentDate)
        guard let age = ageComponents.year else { return 0 }
        return age
    }
    
    var BMR: Int {
        if let height = currentUser?.height, let weight = currentUser?.weight {
            let maleBMR = 66.47 + (13.75 *  Double(weight)) + (5.003 * Double(height)) - (6.755 * Double(age))
            let femaleBMR = 655.1 + (9.563 *  Double(weight)) + (1.85 *  Double(height)) - (4.676 * Double(age))
            
            if currentUser?.gender == "Male" {
                return Int(maleBMR)
            } else {
                return Int(femaleBMR)
            }
        } else {
            return 0
        }
    }
    
    var AMR: Int {
        if let activityLevel = currentUser?.activityLevel {
            if activityLevel == "Sedentary" {
                return Int(Double(BMR) * 1.2)
            } else if activityLevel == "Lightly active" {
                return Int(Double(BMR) * 1.375)
            } else if activityLevel == "Moderately active" {
                return Int(Double(BMR) * 1.55)
            } else if activityLevel == "Active" {
                return Int(Double(BMR) * 1.725)
            } else {
                return Int(Double(BMR) * 1.9)
            }
        } else {
            return 0
        }
    }
    
    var targetCalorie : Int {
        if let targetWeight = currentUser?.targetWeight, let weight = currentUser?.weight, let targetDate = currentUser?.targetDate {
            let calendar = Calendar.current
            guard let timeRange = (calendar.dateComponents([.day], from: calendar.startOfDay(for: targetDate), to: calendar.startOfDay(for: Date()))).day else { return 1 }
            let formula = ((targetWeight - weight) * 7700) / timeRange
            return Int(Double(AMR) - Double(formula))
        } else {
            return 0
        }
    }
    
    var carbohydratesRequirement : Int {
        return Int(AMR/8)
    }
    
    var fibreRequirement : Double {
        return 30
    }
    
    var sugarRequirement : Double {
        return 27
    }
    
    var fatRequirement : Int {
        return Int(AMR/30)
    }
    
    var proteinRequirement:Int {
        if currentUser?.gender == "Male" {
            return 55
        } else {
            return 45
        }
    }
    
    var satFatRequirement:Double{
        if currentUser?.gender == "Male" {
            return 30
        } else {
            return 20
        }
    }
    
    var sodiumRequirement:Double{
        return 500
    }
    
    var vitaminARequirement:Double{
        if currentUser?.gender == "Male" {
            return 900
        } else {
            return 700
        }
    }
    
    var vitaminB12Requirement:Double{
        return 2.4
    }
    
    var vitaminB6Requirement:Double{
        if currentUser?.gender == "Male" {
            if age < 50 {
                return 1.3
            }
            else{
                return 1.7}
        } else {
            if age < 50 {
                return 1.2
            }
            else{
                return 1.5}
        }
    }
    
    var vitaminCRequirement:Double{
        if currentUser?.gender == "Male" {
            return 90
        } else {
            return 75
        }
    }
    
    var vitaminERequirement:Double{
        if currentUser?.gender == "Male" {
            return 19
        } else {
            return 15
        }
    }
    
    var calciumRequirement:Double{
        if currentUser?.gender == "Male" {
            if age < 19 {
                return 1300
            }
            else if age>18 && age<71 {
                return 1000}
            else{
                return 1200
            }
        } else {
            if age < 19 {
                return 1300
            }
            else if age>18 && age<51 {
                return 1000}
            else{
                return 1200
            }
        }
    }
    
    var ironRequirement:Double{
        if currentUser?.gender == "Male" {
            if age < 19 {
                return 11
            } else{
                return 8
            }
        } else {
            if age < 19 {
                return 15
            }
            else if age>18 && age<51 {
                return 18}
            else{
                return 8
            }
        }
    }
    
    var potassiumRequirement:Double{
        if currentUser?.gender == "Male" {
            if age < 19 {
                return 3000
            } else{
                return 3400
            }
        } else {
            if age < 19 {
                return 2300
            } else{
                return 2600
            }
        }
    }
    
    func addFitnessRecord(dateOfExercise: Date, name: String, imageName: String, sets: Int, reps: Int, weight: Int) async {
        print("loading")
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let newFitnessRecord: [String: Any] = [
            "id": UUID().uuidString,
            "dateOfExercise": dateOfExercise,
            "imageName" : imageName,
            "name": name,
            "sets": sets,
            "reps": reps,
            "weight": weight
        ]
        
        Firestore.firestore().collection("users").document(uid).collection("FitnessRecord").addDocument(data: newFitnessRecord)
        { error in
            if let error = error {
                print("Error adding fitness record: \(error.localizedDescription)")
            } else {
                print("Fitness record added successfully!")
            }
        }
    }
    
    func addDietRecord(dateOfDiet: Date, typeOfDiet: String, size: Int, name: String, calories: Int, carbohydrates: Double, sugar: Double, fibre: Double, protein: Double, fat: Double, saturatedFat: Double, calcium: Double, sodium: Double, iron: Double, potassium: Double, vitaminA: Double, vitaminB6: Double, vitaminB12: Double, vitaminC: Double, vitaminE: Double) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let newRecord: [String: Any] = [
            "id": UUID().uuidString,
            "dateOfDiet": dateOfDiet,
            "typeOfDiet": typeOfDiet,
            "size": size,
            "name": name,
            "calories": calories,
            "carbohydrates" : carbohydrates,
            "sugar": sugar,
            "fibre": fibre,
            "protein": protein,
            "fat": fat,
            "saturatedFat": saturatedFat,
            "calcium": calcium,
            "sodium": sodium,
            "iron": iron,
            "potassium": potassium,
            "vitaminA": vitaminA,
            "vitaminB6": vitaminB6,
            "vitaminB12": vitaminB12,
            "vitaminC": vitaminC,
            "vitaminE": vitaminE
        ]
        
        Firestore.firestore().collection("users").document(uid).collection("DietRecord").addDocument(data: newRecord) { error in
            if let error = error {
                print("Error adding diet record: \(error.localizedDescription)")
            } else {
                print("Diet record added successfully!")
            }
        }
    }
    
    func fetchFitnessRecords(selectedDate: Date) async throws{
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let calendar = Calendar.current
        let startDate = calendar.date(bySettingHour: 0, minute: 0, second: 0, of: selectedDate) ?? selectedDate
        let endDate = calendar.date(bySettingHour: 23, minute: 59, second: 59, of: selectedDate) ?? selectedDate
        
        let query = Firestore.firestore()
            .collection("users")
            .document(uid)
            .collection("FitnessRecord")
            .whereField("dateOfExercise", isGreaterThanOrEqualTo: startDate)
            .whereField("dateOfExercise", isLessThanOrEqualTo: endDate)
        do {
            print("loading")
            let snapshot = try await query.getDocuments()
            
            fitnessRecords = snapshot.documents.compactMap { document in
                try? document.data(as: EachFitnessRecord.self)
            }
        } catch {
            print("Error fetching fitness records: \(error)")
            throw error
        }
    }
    
    func fetchDietRecords(selectedDate: Date) async throws{
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let calendar = Calendar.current
        let startDate = calendar.date(bySettingHour: 0, minute: 0, second: 0, of: selectedDate) ?? selectedDate
        let endDate = calendar.date(bySettingHour: 23, minute: 59, second: 59, of: selectedDate) ?? selectedDate
        
        let query = Firestore.firestore()
            .collection("users")
            .document(uid)
            .collection("DietRecord")
            .whereField("dateOfDiet", isGreaterThanOrEqualTo: startDate)
            .whereField("dateOfDiet", isLessThanOrEqualTo: endDate)
        
        do {
            print("loading")
            let snapshot = try await query.getDocuments()
            
            dietRecords = snapshot.documents.compactMap { document in
                try? document.data(as: EachDietRecord.self)
            }
            breakfastRecords = dietRecords.filter { $0.typeOfDiet == "Breakfast" }
            lunchRecords = dietRecords.filter { $0.typeOfDiet == "Lunch" }
            dinnerRecords = dietRecords.filter { $0.typeOfDiet == "Dinner" }
            snacksRecords = dietRecords.filter { $0.typeOfDiet == "Snack" }
         
            for record in dietRecords {
                totalCalories += record.calories
                totalCarbohydrates += Int(record.carbohydrates)
                totalFat += Int(record.fat)
                totalProtein += Int(record.protein)
                totalFibre += record.fibre
                totalSugar += record.sugar
                totalSaturatedFat += record.saturatedFat
                totalIron += record.iron
                totalSodium += record.sodium
                totalPotassium += record.potassium
                totalCalcium += record.calcium
                totalVitaminA += record.vitaminA
                totalVitaminC += record.vitaminC
                totalVitaminE += record.vitaminE
                totalVitaminB6 += record.vitaminB6
                totalVitaminB12 += record.vitaminB12
                
            }
        } catch {
            print("Error fetching diet records: \(error)")
            throw error
        }
    }
    
    func addUserWeight(date: Date, weight: Int ) async {
        print("loading")
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let newWeightRecord: [String: Any] = [
            "id": UUID().uuidString, // Generate a unique ID for the record
            "date": date,
            "weight": weight
        ]
        
        Firestore.firestore().collection("users").document(uid).collection("WeightRecord").addDocument(data: newWeightRecord)
        { error in
            if let error = error {
                print("Error adding weight record: \(error.localizedDescription)")
            } else {
                print("weight record added successfully!")
            }
        }
    }
    
    func fetchWeightRecords(selectedDate: Date) async throws{
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let calendar = Calendar.current
        let endDate = calendar.date(bySettingHour: 23, minute: 59, second: 59, of: selectedDate) ?? selectedDate
        
        var components = DateComponents()
        components.day = -30
        guard let startDate = calendar.date(byAdding: components, to: selectedDate) else { return }
        
        let query = Firestore.firestore()
            .collection("users")
            .document(uid)
            .collection("WeightRecord")
            .whereField("date", isGreaterThanOrEqualTo: startDate)
            .whereField("date", isLessThanOrEqualTo: endDate)
        do {
            print("loading")
            let snapshot = try await query.getDocuments()
            
            weightRecords = snapshot.documents.compactMap { document in
                try? document.data(as: EachUserWeight.self)
            }
            print("\(weightRecords)")
        } catch {
            print("Error fetching weight records: \(error)")
            throw error
        }
    }
    
}
