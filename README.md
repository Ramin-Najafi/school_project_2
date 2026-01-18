# Motorcycle Store Simulation - Swift Playground

A console-based motorcycle dealership simulation demonstrating protocol-oriented programming, object-oriented design, and Swift language fundamentals. The application models a virtual store where customers can browse and purchase motorcycles from different categories with dynamic pricing and inventory management.

**Built with Swift to demonstrate:** Protocol-Oriented Programming, Enums, Structs, Classes, Error Handling, and Computed Properties

---

## 🏍️ Overview

This Swift playground simulates a motorcycle dealership that manages inventory across three categories: Cruisers, Sport Bikes, and Touring Bikes. Each category is managed by a dedicated server that handles inventory, pricing, and purchase transactions. The system includes features like discount pricing, preparation time calculations, and multi-motorcycle purchasing with inventory availability checking.

**Platform:** iOS (Swift Playground)  
**Swift Version:** 6.0  
**Type:** Educational Project

---

## ✨ Key Features

### Motorcycle Categories
- **Cruisers:** Classic heavy bikes (Harley, Indian)
  - Harley Low Rider (1746cc, $18,000)
  - Indian Scout (1133cc, $15,000)

- **Sport Bikes:** High-performance racing bikes (Yamaha, Kawasaki)
  - Yamaha R1 (998cc, $16,500)
  - Kawasaki Ninja ZX-10R (998cc, $16,200)

- **Touring Bikes:** Long-distance comfort bikes (Honda, BMW)
  - Honda Gold Wing (1833cc, $23,000)
  - BMW K1600 (1649cc, $25,500)

### Purchase System
- **Dynamic Pricing:** Prices formatted to nearest thousand (e.g., $18,000 → $17,999)
- **Discount Support:** Optional discount percentage on purchases
- **Preparation Time:** Calculated based on engine size and category
- **Inventory Validation:** Error handling for unavailable motorcycles
- **Batch Purchasing:** Buy multiple bikes with availability reporting

### Business Logic
- **Realistic Pricing:** Dealership-style price formatting (ends in 999)
- **Prep Time Calculation:** Different rates per category
  - Cruisers: 0.01 min/cc
  - Sport Bikes: 0.008 min/cc
  - Touring Bikes: 0.012 min/cc
- **Random Inventory Simulation:** Bikes may randomly be "out of stock"

---

## 🛠️ Swift Concepts Demonstrated

### 1. Enumerations
```swift
enum Category: String {
    case cruiser = "Cruisers"
    case sport = "Sport Bikes"
    case touring = "Touring Bikes"
}
```
**Purpose:** Type-safe category management with raw string values for display

### 2. Structures
```swift
struct Motorcycle: Equatable {
    let name: String
    let engineSize: Int
    let price: Double
    let prepTimePerCC: Double
    
    var prepTime: Double {
        (Double(engineSize) * prepTimePerCC * 100).rounded() / 100
    }
}
```
**Features:**
- **Value type** (copied when passed)
- **Computed properties** (prepTime, formattedPrice)
- **Equatable protocol** for comparison

### 3. Protocols (Protocol-Oriented Programming)
```swift
protocol MotorcycleServer {
    var category: Category { get }
    func listMotorcycles() -> [Motorcycle]
    func purchase(_ bike: Motorcycle, discount: Double) throws -> (prepTime: Double, cost: Double)
}
```
**Benefits:**
- Defines contract for all server types
- Enables polymorphism
- Allows flexible server implementations

### 4. Classes
```swift
class CruiserServer: MotorcycleServer {
    var category: Category { .cruiser }
    private var inventory: [Motorcycle] = [...]
    
    func purchase(_ bike: Motorcycle, discount: Double = 0) throws -> (prepTime: Double, cost: Double) {
        guard inventory.contains(bike) else { 
            throw PurchaseError.notAvailable 
        }
        let cost = bike.formattedPrice * (1 - discount)
        return (bike.prepTime, cost)
    }
}
```
**Features:**
- **Reference type** (shared when passed)
- **Inheritance** (protocol conformance)
- **Encapsulation** (private inventory)
- **Default parameters** (discount: Double = 0)

### 5. Error Handling
```swift
enum PurchaseError: Error {
    case notAvailable
}

do {
    let result = try server.purchase(bike, discount: discount)
    print("Purchased \(bike.name)")
} catch {
    print("Purchase failed")
}
```
**Demonstrates:** Swift's type-safe error handling with `throws`, `try`, `do-catch`

### 6. Computed Properties
```swift
var prepTime: Double {
    (Double(engineSize) * prepTimePerCC * 100).rounded() / 100
}

var formattedPrice: Double {
    let thousands = Int(price / 1000)
    return Double(thousands * 1000 + 999)
}
```
**Purpose:** Dynamic value calculation without storing duplicate data

---

## 📁 Code Structure

### Data Models
- **Category** (Enum): Motorcycle type categorization
- **Motorcycle** (Struct): Individual bike data model
- **PurchaseError** (Enum): Custom error type

### Services
- **MotorcycleServer** (Protocol): Server contract definition
- **CruiserServer** (Class): Cruiser inventory manager
- **SportBikeServer** (Class): Sport bike inventory manager
- **TouringBikeServer** (Class): Touring bike inventory manager

### Business Logic
- **Store** (Class): Main dealership coordinator
  - `showInventory()`: Display all bikes across categories
  - `buy(_:from:discount:)`: Single purchase with validation
  - `buyMultiple(_:from:discount:)`: Batch purchase with reporting

---

## 🎮 How It Works

### 1. Initialization
```swift
let cruiserServer = CruiserServer()
let sportBikeServer = SportBikeServer()
let touringBikeServer = TouringBikeServer()

let store = Store(servers: [cruiserServer, sportBikeServer, touringBikeServer])
```
Three category servers are created and passed to the main store.

### 2. Display Inventory
```swift
store.showInventory()
```
Iterates through all servers and displays available motorcycles.

### 3. Single Purchase
```swift
store.buy(firstCruiser, from: cruiserServer, discount: 0.05)
```
Attempts to purchase a specific bike with optional discount.

### 4. Batch Purchase
```swift
store.buyMultiple(
    [cruiserServer.listMotorcycles()[1], touringBikeServer.listMotorcycles()[1]],
    from: touringBikeServer
)
```
Attempts multiple purchases and reports successes/failures.

### 5. Purchase Flow
```
1. Validate bike exists in server inventory
2. Apply discount to formatted price
3. Calculate preparation time
4. Process purchase or throw error
5. Display results to console
```

---

## 💻 Running the Project

### Prerequisites
- macOS with Xcode 14+ installed
- Swift 6.0 or later
- iOS Simulator or Swift Playground app

### Setup & Execution

**Option 1: Xcode Playground**
1. Open Xcode
2. Create new Playground (File → New → Playground)
3. Select "iOS" platform
4. Copy the Swift code into the playground
5. Run the playground (Cmd + Shift + Return)

**Option 2: Swift Playground App (iPad)**
1. Open Swift Playgrounds app
2. Create new playground
3. Paste the code
4. Run to see console output

**Option 3: Command Line (macOS)**
```bash
# Save code to file
nano MotorcycleStore.swift

# Run with Swift interpreter
swift MotorcycleStore.swift
```

---

## 📊 Example Output

```
Available Cruisers:
Harley Low Rider - Engine Size: 1746cc, Price: $17999
Indian Scout - Engine Size: 1133cc, Price: $14999
--------------------
Available Sport Bikes:
Yamaha R1 - Engine Size: 998cc, Price: $16999
Kawasaki Ninja ZX-10R - Engine Size: 998cc, Price: $16999
--------------------
Available Touring Bikes:
Honda Gold Wing - Engine Size: 1833cc, Price: $22999
BMW K1600 - Engine Size: 1649cc, Price: $25999
--------------------

Purchased Harley Low Rider.
Prep Time: 17.46 mins
Cost: $17099

Purchased Yamaha R1.
Prep Time: 7.98 mins
Cost: $16999

Purchased Honda Gold Wing.
Prep Time: 21.99 mins
Cost: $20699

Purchased Indian Scout.
Prep Time: 11.33 mins
Cost: $14999

BMW K1600 is out of our inventory.
--------------------
```

---

## 🎯 Design Patterns & Principles

### Protocol-Oriented Programming (POP)
Swift's POP paradigm is demonstrated through the `MotorcycleServer` protocol:
- **Polymorphism:** All servers conform to same interface
- **Flexibility:** Easy to add new motorcycle categories
- **Type Safety:** Compile-time checking of implementations

### Value vs Reference Types
- **Motorcycle (Struct):** Value type - copied when passed
  - Immutable bike data
  - No shared state issues
- **Servers (Class):** Reference type - shared when passed
  - Maintains mutable inventory
  - Shared state across store

### Encapsulation
```swift
private var inventory: [Motorcycle] = [...]
```
Inventory is private, accessible only through public methods.

### Separation of Concerns
- **Data:** Motorcycle struct
- **Business Logic:** Server classes
- **Coordination:** Store class
- **Error Handling:** PurchaseError enum

---

## 🧪 Purchase Logic Breakdown

### Price Formatting
```swift
var formattedPrice: Double {
    let thousands = Int(price / 1000)
    return Double(thousands * 1000 + 999)
}
```
**Example:** $18,000 → $17,999 (dealership pricing)

### Preparation Time Calculation
```swift
var prepTime: Double {
    (Double(engineSize) * prepTimePerCC * 100).rounded() / 100
}
```
**Example:** 1746cc × 0.01 = 17.46 minutes

### Discount Application
```swift
let cost = bike.formattedPrice * (1 - discount)
```
**Example:** $17,999 × (1 - 0.05) = $17,099.05 → $17,099

---

## 🎓 What I Learned

Through building this project, I gained hands-on experience with:

### Swift Language Features
- **Protocols:** Defining contracts and achieving polymorphism
- **Enums:** Type-safe categorization with raw values
- **Structs vs Classes:** Understanding value vs reference types
- **Computed Properties:** Dynamic calculations without storage
- **Error Handling:** Using `throws`, `try`, and `do-catch`
- **Guard Statements:** Early exit pattern for validation
- **Optionals:** Safe handling of optional values with `if let`
- **Default Parameters:** Flexible function signatures

### Software Design
- **Protocol-Oriented Programming:** Swift's preferred paradigm
- **Encapsulation:** Hiding implementation details
- **Single Responsibility:** Each class has one clear purpose
- **Immutability:** Using `let` for constants
- **Type Safety:** Leveraging Swift's strong type system

### Business Logic
- **Inventory Management:** Tracking available items
- **Pricing Strategies:** Realistic dealership pricing
- **Transaction Processing:** Purchase validation and calculation
- **Batch Operations:** Processing multiple items efficiently

---

## 🔄 Potential Enhancements

Future improvements could include:

- [ ] **Persistent Inventory:** Save/load inventory from files
- [ ] **Customer Accounts:** Track purchase history
- [ ] **Financing Options:** Calculate monthly payments
- [ ] **Search & Filter:** Find bikes by price, engine size, category
- [ ] **Comparison Tool:** Compare multiple bikes side-by-side
- [ ] **Graphical UI:** SwiftUI interface instead of console
- [ ] **More Categories:** Electric bikes, dirt bikes, scooters
- [ ] **Inventory Restocking:** Add bikes back to inventory
- [ ] **Trade-In System:** Exchange old bikes for new ones
- [ ] **Sales Reports:** Analytics on purchases and revenue
- [ ] **Multi-Store Support:** Manage multiple dealership locations
- [ ] **Reservation System:** Hold bikes for customers

---

## 🐛 Known Limitations

- **Console-Based:** No graphical user interface
- **Simulated Inventory:** Random out-of-stock behavior
- **Fixed Inventory:** Cannot add/remove bikes dynamically
- **No Persistence:** Data lost when playground ends
- **Single Session:** No multi-user support
- **Simplified Math:** Prep time formula is conceptual
- **No Real Transactions:** Simulated purchases only

---

## 📚 Swift Best Practices Demonstrated

### Naming Conventions
✅ **PascalCase** for types (Motorcycle, Store)  
✅ **camelCase** for properties and methods (engineSize, listMotorcycles)  
✅ **Descriptive names** (formattedPrice vs price2)

### Type Safety
✅ **Strong typing** throughout  
✅ **Enums** instead of string constants  
✅ **Protocols** for polymorphism  
✅ **Guard statements** for early validation

### Immutability
✅ **Prefer `let`** over `var` where possible  
✅ **Computed properties** instead of stored mutable values

### Error Handling
✅ **Custom error types** (PurchaseError)  
✅ **Throwing functions** for recoverable errors  
✅ **Do-catch** for error recovery

---

## 🤝 Contributing

This is a school project demonstrating Swift fundamentals and protocol-oriented programming. Feedback and suggestions for improvement are welcome!

---

## 📝 License

This project is open source and available for educational purposes.

---

## 👨‍💻 Author

**Ramin Najafi**
- Portfolio: [ramin-najafi.github.io](https://ramin-najafi.github.io/)
- GitHub: [@Ramin-Najafi](https://github.com/Ramin-Najafi)
- Email: rnajafi.dev@gmail.com

---

## 🙏 Acknowledgments

- **triOS College** for Swift development education
- **Apple Swift Documentation** for language reference
- **Protocol-Oriented Programming** paradigm for inspiring the architecture
- **Real-world dealership systems** for business logic inspiration

---

## 📖 Additional Resources

**Learn More About:**
- [Swift Programming Language Guide](https://docs.swift.org/swift-book/)
- [Protocol-Oriented Programming in Swift](https://developer.apple.com/videos/play/wwdc2015/408/)
- [Value Types vs Reference Types](https://developer.apple.com/swift/blog/?id=10)
- [Error Handling in Swift](https://docs.swift.org/swift-book/LanguageGuide/ErrorHandling.html)

---

**Built with 🍎 to demonstrate mastery of Swift and protocol-oriented programming**