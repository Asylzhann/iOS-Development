import UIKit

//problem 1
for i in 1...100{
    if i%15==0 { print("FizzBuzz")}
    else if i%3==0 { print("Fizz")}
    else if i%5==0 { print("Buzz")}
    else { print(i)}
}

//problem 2
func isPrime(_ number: Int)-> Bool{
    if number==1{
        return false
    }
    for i in 2..<number{
        if (number%i)==0{
            return false
        }
    }
    return true
}
for i in 1...100{
    if isPrime(i){print(i)}
}

//problem 3
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

let temperatureValue: Double = 100
let temperatureUnit: Character = "C"

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
func addItem(to list: inout [String], item:String){
    return list.append(item)
}
func removeItem(from list: inout [String], item:String){
    if let index = list.firstIndex(of: item){
        list.remove(at: index)
    }
    else{
        print("item not found")
    }
}
func showList(list:[String]){
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
var chars = Array(text)
let punctiation: Set<Character> = [",",".","\\","/",":",";"]
for i in 0..<chars.count{
    if punctiation.contains(chars[i]){
        chars[i]=" "
    }
}
text=String(chars)
let words = text.lowercased().split(separator: " ").map{String($0)}
for word in words{
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
    if n<1{
        return []
    }
    else{
        for i in 2..<n{
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
for i in 0..<scores.count{
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
for i in 0..<names.count{
    if Double(scores[i])<averageScore{
        print(names[i],":",scores[i]," - below average")
    }
    else if Double(scores[i])>=averageScore{
        print(names[i],":",scores[i]," - above average")
    }
}

//problem 8
func isPalindrome(_ text:String)->Bool{
    let text = text.lowercased().filter {$0.isLetter||$0.isNumber}
    if text == String(text.reversed()){
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
func addition(_ a: Double, _ b: Double)->Double{
    return a + b}
func subtraction(_ a: Double, _ b: Double)->Double{
    return a - b}
func multiplication(_ a: Double, _ b: Double)->Double{
    return a * b}
func division(_ a: Double, _ b: Double)->Double?{
    if b==0{
        return nil
    }
    else {
        return a / b
    }
}
let operations:[(Double,String,Double)]=[
    (10, "+", 20),
    (30, "-", 15),
    (40, "*", 2),
    (50, "/", 5),
    (60, "/", 0)]

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
        set.insert(i)
    }
    return text.count==set.count
}
let uniqueText="helLo"
print(hasUniqueCharacters(uniqueText))
