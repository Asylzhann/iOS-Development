import UIKit

//problem 1
for i in 1...100{
    if i%15==0 { print("FizzBuzz")}//if divisible by both 3 and 5
    else if i%3==0 { print("Fizz")}//if divisible only by 3
    else if i%5==0 { print("Buzz")}//if divisible only by 5
    else { print(i)}
}

//problem 2
func isPrime(_ number: Int)-> Bool{
    if number==1{// 1 is not prime
        return false
    }
    for i in 2..<number{//check if it is divisible by any number
        if (number%i)==0{
            return false
        }
    }
    return true
}
for i in 1...100{//run from 1 to 100
    if isPrime(i){print(i)}
}

//problem 3
//function to convert from one unit to another
func fahrenheitToCelsius(_ fahrenheit: Double) -> Double {
    return (fahrenheit - 32) * 5/9}
func fahrenheitToKelvin(_ fahrenheit: Double) -> Double {
    return (fahrenheit - 32) * 5/9 + 273.15}
func celsiusToFahrenheit(_ celcius: Double) -> Double {
    return celcius * 9/5 + 32}
func celsiusToKelvin(_ celcius: Double) -> Double {
    return celcius + 273.15}
func kelvinToFahrenheit(_ kelvin: Double) -> Double {
    return (kelvin - 273.15) * 9/5 + 32}
func kelvinToCelsius(_ kelvin: Double) -> Double {
    return kelvin - 273.15}
//hardcode input
let temperatureValue: Double = 100
let temperatureUnit: Character = "C"
//determine which function to use
switch temperatureUnit {
case "C":
    print("\(temperatureValue)°C is equal to \(celsiusToFahrenheit(temperatureValue))°F and \(celsiusToKelvin(temperatureValue))°K")
case "F":
    print("\(temperatureValue)°F is equal to \(fahrenheitToCelsius(temperatureValue))°C and \(fahrenheitToKelvin(temperatureValue))°K")
case "K":
    print("\(temperatureValue)°K is equal to \(kelvinToCelsius(temperatureValue))°C and \(kelvinToFahrenheit(temperatureValue))°F")
default:
    print("wrong unit")
}

//problem 4
func addItem(to list: inout [String], item:String){//to add item to list
    return list.append(item)
}
func removeItem(from list: inout [String], item:String){//to remove item from list by finding index
    if let index = list.firstIndex(of: item){
        list.remove(at: index)
    }
    else{
        print("item not found")
    }
}
func showList(list:[String]){//printing out the list
    if list.isEmpty{
        print("list empty")
    }
    else{
        for (i,item) in list.enumerated(){
            print(i+1, item)
        }
    }
}

var ShoppingList: [String] = []
//test shopping list
showList(list: ShoppingList)
addItem(to: &ShoppingList, item: "Tomato")
addItem(to: &ShoppingList, item: "Potato")
addItem(to: &ShoppingList, item: "Onion")
showList(list: ShoppingList)

removeItem(from: &ShoppingList, item: "Onion")
showList(list: ShoppingList)
removeItem(from: &ShoppingList, item: "Banana")

//problem 5
var dict: [String: Int] = [:]
var text = "Tomato, tomato\\ TOMATO: potato/ Potato; POTATO onion onnnion carrot caRRot"
var chars = Array(text)//convert text to array of characters and remove punctuations
let punctiation: Set<Character> = [",",".","\\","/",":",";"]
for i in 0..<chars.count{
    if punctiation.contains(chars[i]){
        chars[i]=" "
    }
}
text=String(chars)
let words = text.lowercased().split(separator: " ").map{String($0)}//split text to words
for word in words{//counting frequencies by dictionary
    if dict[word] != nil{
        dict[word]!+=1
    }
    else{
        dict[word]=1
    }
}
for (word, count) in dict{
    print(word,":",count)
}

//problem 6
func fibonacci(_ n:Int)->[Int]{
    var sequence: [Int] = [1,1]
    if n<1{//return empty list if number is equal or less than zero
        return []
    }
    else{
        for i in 2..<n{//generate fibonacci sequence
            sequence.append(sequence[i-1]+sequence[i-2])
        }
    }
    return sequence
}
let n = 10
print(fibonacci(n))

//problem 7
let names=["James","Jhones","Jhane","Jabe","Jake","Jamey"]
let scores=[90,85,92,88,95,93]
var highestScore=scores[0]
var lowestScore=scores[0]
var sumOfScores=0
for i in 0..<scores.count{//track highest, lowest, average score
    sumOfScores+=scores[i]
    if scores[i]>highestScore{
        highestScore=scores[i]
    }
    if scores[i]<lowestScore{
        lowestScore=scores[i]
    }
}
var averageScore=Double(sumOfScores)/Double(scores.count)
print("highest = \(highestScore), lowest = \(lowestScore), average = \(averageScore)")
for i in 0..<names.count{//display each student, score and indication about average
    if Double(scores[i])<averageScore{
        print(names[i],":",scores[i]," - below average")
    }
    else if Double(scores[i])>=averageScore{
        print(names[i],":",scores[i]," - above average")
    }
}

//problem 8
func isPalindrome(_ text:String)->Bool{
    let text = text.lowercased().filter {$0.isLetter||$0.isNumber}//filter only letters and digits
    if text == String(text.reversed()){//compare to its reverse if palindrome
        return true
    }
    else{
        return false
    }
}

print(isPalindrome("1 2 3 4 5 4 3 2 1"))
print(isPalindrome("1234"))
print(isPalindrome("Abba"))

//problem 9
//functions for operations
func addition(_ a: Double, _ b: Double)->Double{
    return a + b}
func subtraction(_ a: Double, _ b: Double)->Double{
    return a - b}
func multiplication(_ a: Double, _ b: Double)->Double{
    return a * b}
func division(_ a: Double, _ b: Double)->Double?{
    if b==0{//prevent division by 0
        return nil
    }
    else {
        return a / b
    }
}
let operations:[(Double,String,Double)]=[//operation examples
    (10, "+", 20),
    (30, "-", 15),
    (40, "*", 2),
    (50, "/", 5),
    (60, "/", 0)]
//performing operations by switch-case
for (a,op,b) in operations{
    switch op {
    case "+":
        print(a,op,b,"=",addition(a,b))
    case "-":
        print(a,op,b,"=",subtraction(a,b))
    case "*":
        print(a,op,b,"=",multiplication(a,b))
    case "/":
        if let result = division(a,b){
            print(a,op,b,"=",result)
        }
        else{
            print("no division by zero")
        }
    default:
        print("invalid operator")
    }
}

//problem 10
func hasUniqueCharacters(_ text:String)->Bool{
    var set:Set<Character>=[]
    for i in text{
        set.insert(i)//insert unique character from text to set
    }
    return text.count==set.count//text has unique characters if their length match
}
let uniqueText="helLo"
print(hasUniqueCharacters(uniqueText))
