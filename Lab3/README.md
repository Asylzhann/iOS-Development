# Shopping Cart Assignment

This project implements a shopping cart system in Swift. It is divided into several parts:

* **Product** (struct) represents items in the catalog.
* **CartItem** (struct) links a product with a quantity.
* **ShoppingCart** (class) manages the cart’s items and discount codes.
* **Address** (struct) stores shipping information.
* **Order** (struct) is created from a shopping cart and represents a snapshot of a purchase.

The project also includes example usage showing adding/removing items, applying discounts, and creating an order.

---

## Why did you choose class for ShoppingCart?

I chose `ShoppingCart` as a **class** because it represents a shared container that can change over time. A cart should behave as one consistent entity, no matter where it is referenced. In my code, when I call `modifyCart(_:)` and pass in the cart, the function adds headphones. Since `ShoppingCart` is a class, those changes are reflected in the original cart after the function finishes. This shared, mutable state is a natural fit for reference semantics.

---

## Why did you choose struct for Product and Order?

`Product` is a **struct** because products are immutable values. A laptop or book has a fixed identity (id, name, price, description) that does not change once defined. Using a struct prevents accidental modification and ensures safe copying.

`Order` is also a **struct** because it captures a snapshot of the cart at checkout. Once created, an order should not change. Value semantics guarantee that the order remains independent of any later cart modifications. For example, after I clear the cart, the order still holds the original items.

---

## Example of reference semantics

Reference semantics matter in `ShoppingCart`. For instance, I add items to the cart, then pass it into `modifyCart(_:)`. Inside the function, a new product is added, and when I print the cart afterwards, the change is still visible. This works because both the function and the main code are referencing the same cart instance.

---

## Example of value semantics

Value semantics are shown with `CartItem`. In my test code, I create `item1` and assign it to `item2`. Then I update the quantity of `item2` to 5. When I print `item1`, its quantity has not changed. This demonstrates that `CartItem` is a struct and is copied by value, so each variable has its own independent data.

---

## Challenges faced and solutions

One challenge was handling invalid data, like negative prices or quantities. I solved this by using **failable initializers** in both `Product` and `CartItem`, combined with `guard` statements to reject invalid inputs.

Another challenge was choosing between structs and classes. At first, I considered making everything a class, but that caused problems for orders, which should remain fixed after checkout. Switching `Order` to a struct solved the issue by giving it value semantics.

Finally, ensuring the discount system worked correctly required careful testing. I solved this by writing multiple scenarios (with and without codes) and verifying that the `subtotal`, `discountAmount`, and `total` properties calculated correctly.

---
