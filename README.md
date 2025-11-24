# Motorcycle Store Simulation (Swift)

## Overview

This project is a console-based motorcycle store simulation built in Swift. It showcases core programming concepts such as enumerations, structures, protocols, classes, error handling, and polymorphism. The application models a virtual dealership where different motorcycle categories can be listed and purchased.

⸻

## Features

✅ Categorized motorcycle inventory (Cruisers, Sport Bikes, Touring Bikes)
✅ Price formatting and preparation time calculation
✅ Purchase system with optional discounts
✅ Error handling for unavailable inventory
✅ Ability to buy single or multiple motorcycles
✅ Protocol-oriented design for flexible server types

⸻

## Core Components

### Category

#### Defines the three motorcycle types:
	•	Cruiser
	•	Sport Bike
	•	Touring Bike

### Motorcycle (Struct)

#### Represents a motorcycle with:
	•	Name
	•	Engine size (cc)
	•	Base price
	•	Preparation time per cc

#### Includes computed properties:
	•	prepTime – Estimated prep time based on engine size
	•	formattedPrice – Adjusted price rounded to the nearest thousand-plus pricing format (e.g., 15,000 → 14,999)

### MotorcycleServer (Protocol)

#### Defines the required functionality for each category server:
	•	A category type
	•	Ability to list motorcycles
	•	A purchase method that returns cost and preparation time (or throws an error)

### Concrete Servers

#### Each category has its own server with unique inventory:
	•	CruiserServer
	•	SportBikeServer
	•	TouringBikeServer

### Store

#### Manages:
	•	Displaying all inventory across servers
	•	Purchasing individual motorcycles
	•	Purchasing multiple motorcycles and handling out-of-stock results

⸻

### How It Works
	1.	Each server holds an inventory of motorcycles in its category.
	2.	The store can:
	•	Print all available bikes
	•	Handle purchases with or without discounts
	•	Attempt multi-bike purchases and report unavailable items
	3.	Successful purchases display:
	•	Bike name
	•	Prep time (rounded)
	•	Final cost after discount

⸻

### Running the Program
	1.	Open the project in Xcode or a Swift-compatible environment.
	2.	Run the file containing the main execution code.
	3.	The console will:
	•	Display all available motorcycles
	•	Attempt several sample purchases
	•	Show processed results

⸻

### Example Output (Simplified)

#### Available Cruisers:
Harley Low Rider - Engine Size: 1746cc, Price: $17999
Indian Scout - Engine Size: 1133cc, Price: $14999
--------------------
Purchased Harley Low Rider.
Prep Time: 17.46 mins
Cost: $17099


⸻

#### Skills Demonstrated
	•	Protocol-oriented architecture
	•	Object-oriented design
	•	Error handling with throws
	•	Computed properties and enums
	•	Inventory and cost management logic
