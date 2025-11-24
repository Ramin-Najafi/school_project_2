enum Category: String {
    case cruiser = "Cruisers"
    case sport = "Sport Bikes"
    case touring = "Touring Bikes"
}

struct Motorcycle: Equatable {
    let name: String
    let engineSize: Int
    let price: Double
    let prepTimePerCC: Double
    
    var prepTime: Double {
        (Double(engineSize) * prepTimePerCC * 100).rounded() / 100
    }
    
    var formattedPrice: Double {
        let thousands = Int(price / 1000)
        return Double(thousands * 1000 + 999)
    }
}

enum PurchaseError: Error {
    case notAvailable
}

protocol MotorcycleServer {
    var category: Category { get }
    func listMotorcycles() -> [Motorcycle]
    func purchase(_ bike: Motorcycle, discount: Double) throws -> (prepTime: Double, cost: Double)
}

class CruiserServer: MotorcycleServer {
    var category: Category { .cruiser }
    private var inventory: [Motorcycle] = [
        Motorcycle(name: "Harley Low Rider",
                   engineSize: 1746,
                   price: 18000,
                   prepTimePerCC: 0.01),
        Motorcycle(name: "Indian Scout",
                   engineSize: 1133,
                   price: 15000,
                   prepTimePerCC: 0.01)
    ]
    func listMotorcycles() -> [Motorcycle] { inventory }
    func purchase(_ bike: Motorcycle, discount: Double = 0) throws -> (prepTime: Double, cost: Double) {
        guard inventory.contains(bike) else { throw PurchaseError.notAvailable }
        let cost = bike.formattedPrice * (1 - discount)
        return (bike.prepTime, cost)
    }
}

class SportBikeServer: MotorcycleServer {
    var category: Category { .sport }
    private var inventory: [Motorcycle] = [
        Motorcycle(name: "Yamaha R1",
                   engineSize: 998,
                   price: 16500,
                   prepTimePerCC: 0.008),
        Motorcycle(name: "Kawasaki Ninja ZX-10R",
                   engineSize: 998,
                   price: 16200,
                   prepTimePerCC: 0.008)
    ]
    func listMotorcycles() -> [Motorcycle] { inventory }
    func purchase(_ bike: Motorcycle, discount: Double = 0) throws -> (prepTime: Double, cost: Double) {
        guard inventory.contains(bike) else { throw PurchaseError.notAvailable }
        let cost = bike.formattedPrice * (1 - discount)
        return (bike.prepTime, cost)
    }
}

class TouringBikeServer: MotorcycleServer {
    var category: Category { .touring }
    private var inventory: [Motorcycle] = [
        Motorcycle(name: "Honda Gold Wing",
                   engineSize: 1833,
                   price: 23000,
                   prepTimePerCC: 0.012),
        Motorcycle(name: "BMW K1600",
                   engineSize: 1649,
                   price: 25500,
                   prepTimePerCC: 0.012)
    ]
    func listMotorcycles() -> [Motorcycle] { inventory }
    func purchase(_ bike: Motorcycle, discount: Double = 0) throws -> (prepTime: Double, cost: Double) {
        guard inventory.contains(bike) else { throw PurchaseError.notAvailable }
        let cost = bike.formattedPrice * (1 - discount)
        return (bike.prepTime, cost)
    }
}

class Store {
    private var servers: [MotorcycleServer]
    
    init(servers: [MotorcycleServer]) {
        self.servers = servers
    }
    
    func showInventory() {
        for server in servers {
            print("Available \(server.category.rawValue):")
            for bike in server.listMotorcycles() {
                print("\(bike.name) - Engine Size: \(bike.engineSize)cc, Price: $\(Int(bike.formattedPrice))")
            }
            print("--------------------")
        }
    }
    
    func buy(_ bike: Motorcycle, from server: MotorcycleServer, discount: Double = 0) -> Bool {
        if !server.listMotorcycles().contains(bike) {
            return false
        }
        do {
            let result = try server.purchase(bike, discount: discount)
            let roundedPrep = (result.prepTime * 100).rounded() / 100
            print("Purchased \(bike.name).")
            print("Prep Time: \(roundedPrep) mins")
            print("Cost: $\(Int(result.cost))\n") // Added newline for spacing
            return true
        } catch {
            return false
        }
    }
    
    func buyMultiple(_ bikes: [Motorcycle], from server: MotorcycleServer, discount: Double = 0) {
        var soldBikes: [Motorcycle] = []
        var outOfInventory: [Motorcycle] = []
        
        for bike in bikes {
            if Bool.random() && server.listMotorcycles().contains(bike) {
                outOfInventory.append(bike)
            } else if buy(bike, from: server, discount: discount) {
                soldBikes.append(bike)
            } else {
                outOfInventory.append(bike)
            }
        }
        
        if !soldBikes.isEmpty && !outOfInventory.isEmpty {
            print("--------------------")
        }
        
        for bike in outOfInventory {
            print("\(bike.name) is out of our inventory.")
        }
        print("--------------------")
    }
}

let cruiserServer = CruiserServer()
let sportBikeServer = SportBikeServer()
let touringBikeServer = TouringBikeServer()

let store = Store(servers: [cruiserServer, sportBikeServer, touringBikeServer])

store.showInventory()

if let firstCruiser = cruiserServer.listMotorcycles().first {
    store.buy(firstCruiser, from: cruiserServer, discount: 0.05)
}

if let firstSportBike = sportBikeServer.listMotorcycles().first {
    store.buy(firstSportBike, from: sportBikeServer)
}

if let firstTouringBike = touringBikeServer.listMotorcycles().first {
    store.buy(firstTouringBike, from: touringBikeServer, discount: 0.1)
}

store.buyMultiple(
    [cruiserServer.listMotorcycles()[1], touringBikeServer.listMotorcycles()[1]],
    from: touringBikeServer
)
