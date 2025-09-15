import UIKit
//step 1
let firstName = "Assylzhan"
let lastName = "Ibadullayev"
var age = 20
let birthYear = 2005
let isStudent = true
let height = 1.76
let yearOfStudy📚 = 3
let gpa🤓 = 3.88
let currentYear = 2025
age = currentYear - birthYear
//step 2
let hobby = "Chess"
let numberOfHobbies = 3
let favouriteNumber = 534531
let isHobbyCreative = false
let favourite🖥Game = "Minecraft"
//step 3
var summary = """
My name is \(firstName) \(lastName).
I am \(age) years old, born in \(birthYear).
I am currently a
"""
if isStudent {
    summary=summary+"student"
}
else{
    summary=summary+"not a student"
}
summary=summary+".\nI enjoy \(hobby), which is a "
if isHobbyCreative{
    summary=summary+"creative"
}
else{
    summary=summary+"not creative"
}
summary=summary+" hobby.\nI have \(numberOfHobbies) hobbies in total, and my favourite number is \(favouriteNumber).\n"
//step 4
let futureGoals="In the future, I want to become a professional iOS developer🍎."
summary=summary+"I am \(height) meters high.\n"+futureGoals
print(summary)
