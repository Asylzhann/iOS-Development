import UIKit
// part 1: Product and CartItem definitions

// Represents a product in the store
struct Product {
    let id: String
    let name: String
    let price: Double
    let category: Category
    let description: String
    
    // Available categories
    enum Category: String, CaseIterable {
        case electronics, clothing, food, books
    }
    
    // Computed property to format price for display
    var displayPrice: String {
        String("$\(price)")
    }
    
    // Failable initializer to ensure valid (non-negative) price
    init?(id: String, name: String, price: Double, category: Category, description: String) {
        guard price >= 0 else {
            print("price not positive")
            return nil
        }
        self.id = id
        self.name = name
        self.price = price
        self.category = category
        self.description = description
    }
}

// Represents an item in the shopping cart with quantity
struct CartItem {
    let product: Product
    var quantity: Int
    
    // Failable initializer to prevent negative quantity
    init?(product: Product, quantity: Int) {
        guard quantity >= 0 else {
            return nil
        }
        self.product = product
        self.quantity = quantity
    }
    
    // Total price for this cart item
    var subtotal: Double {
        Double(quantity) * product.price
    }
    
    // Update quantity safely
    mutating func updateQuantity(_ newQuantity: Int) {
        guard newQuantity >= 0 else {
            print("quantity not positive")
            return
        }
        self.quantity = newQuantity
    }
    
    // Increase/decrease quantity by amount
    mutating func increaseQuantity(by amount: Int) {
        guard self.quantity + amount >= 0 else {
            print("quantity less than 0")
            return
        }
        self.quantity += amount
    }
}

// part 2: Shopping cart class

class ShoppingCart {
    var items: [CartItem]
    var discountCode: String?
    
    init() {
        self.items = []
    }
    
    // Add a product to the cart
    func addItem(product: Product, quantity: Int = 1) {
        for i in 0..<items.count {
            if items[i].product.id == product.id {
                items[i].increaseQuantity(by: quantity)
                return
            }
        }
        if let newItem = CartItem(product: product, quantity: quantity) {
            items.append(newItem)
        }
    }
    
    // Remove product by id
    func removeItem(productId: String) {
        for i in 0..<items.count {
            if items[i].product.id == productId {
                items.remove(at: i)
                return
            }
        }
        print("Item not found")
    }
    
    // Update quantity or remove if set to 0
    func updateItemQuantity(productId: String, quantity: Int) {
        for i in 0..<items.count {
            if items[i].product.id == productId {
                if quantity == 0 {
                    items.remove(at: i)
                    return
                }
                items[i].updateQuantity(quantity)
                return
            }
        }
        print("Item not found")
    }
    
    // Clear all items
    func clearCart() {
        items.removeAll()
    }
    
    // Total price before discounts
    var subtotal: Double {
        var sum: Double = 0
        for item in items {
            sum += item.subtotal
        }
        return sum
    }
    
    // Discount amount depending on code
    var DiscountAmount: Double {
        guard let discountCode = discountCode else {
            return 0
        }
        switch discountCode {
        case "SAVE10":
            return subtotal * 0.1
        case "SAVE20":
            return subtotal * 0.2
        default:
            return 0
        }
    }
    
    // Final total after discount
    var total: Double {
        subtotal - DiscountAmount
    }
    
    // Count of all items in cart
    var itemCount: Int {
        var count: Int = 0
        for item in items {
            count += item.quantity
        }
        return count
    }
    
    // Check if cart is empty
    var isEmpty: Bool {
        return items.isEmpty
    }
}

// part 3: Address and Order

// Shipping address
struct Address {
    let street: String
    let city: String
    let zipCode: String
    let country: String
    
    // Formatted for display
    var formattedAddress: String {
        "\(street)\n\(city), \(zipCode)\n\(country)"
    }
}

// Represents a finalized order created from a shopping cart
struct Order {
    let orderId: String
    let items: [CartItem]
    let subtotal: Double
    let discountAmount: Double
    let total: Double
    let timestamp: Date
    let ShippingAddress: Address
    
    // Create order based on cart data
    init(from cart: ShoppingCart, shippingAddress: Address) {
        self.orderId = UUID().uuidString
        self.items = cart.items
        self.subtotal = cart.subtotal
        self.discountAmount = cart.DiscountAmount
        self.total = cart.total
        self.timestamp = Date()
        self.ShippingAddress = shippingAddress
    }
    
    // Count items in the order
    var itemCount: Int {
        var count: Int = 0
        for item in items {
            count += item.quantity
        }
        return count
    }
}

// part 4: Example usage

// Create products
let laptop = Product(id: "01", name: "MacBook", price: 1999.9, category: .electronics, description: "macbook air 13")!
let book = Product(id: "02", name: "Book", price: 199.9, category: .books, description: "cool book")!
let headphones = Product(id: "03", name: "Headphones", price: 599.9, category: .electronics, description: "wireless headphones")!

// Create a cart and add items
let cart = ShoppingCart()
cart.addItem(product: laptop, quantity: 1)
cart.addItem(product: book, quantity: 2)
cart.addItem(product: laptop, quantity: 1)
print(cart.items[0].quantity)

// Show subtotal and item count
print("Subtotal: \(cart.subtotal)")
print("Item count: \(cart.itemCount)")

// Apply discount
cart.discountCode = "SAVE10"
print("Total with discount: \(cart.total)")

// Remove book from cart
cart.removeItem(productId: book.id)

// Modify cart asynchronously
@MainActor
func modifyCart(_ cart: ShoppingCart) {
    cart.addItem(product: headphones, quantity: 1)
}
modifyCart(cart)
print(cart.itemCount)

// Demonstrate struct copy behavior
let item1 = CartItem(product: laptop, quantity: 1)
var item2 = item1!
item2.updateQuantity(5)
item1 // item1 remains unchanged because structs are value types

// Create an order from cart
let address = Address(street: "Tolebi 59", city: "Almaty", zipCode: "100000", country: "Kazakhstan")
let order = Order(from: cart, shippingAddress: address)

// Clear cart after order
cart.clearCart()
print("Order items count: \(order.itemCount)")
print("Cart items count: \(cart.itemCount)")
