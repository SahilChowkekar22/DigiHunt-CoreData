# DigiHunt

DigiHunt is a modern iOS application built with SwiftUI that allows users to explore and manage Digimon creatures. The app follows the MVVM (Model-View-ViewModel) architecture pattern and uses CoreData for local storage.

## Features

- Browse and search Digimon creatures
- Detailed view of each Digimon
- Local storage using CoreData
- Modern SwiftUI interface
- Clean MVVM architecture
- Background thread data operations
- Efficient data persistence
- Offline data access
- Smooth UI transitions
- Error handling and user feedback

## Requirements

- iOS 15.0+
- Xcode 13.0+
- Swift 5.5+

## Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/DigiHunt.git
```

2. Open the project in Xcode:
```bash
cd DigiHunt
open DigiHunt.xcodeproj
```

3. Build and run the project in Xcode

## Project Structure

```
DigiHunt/
├── APIService/        # API related services and networking
├── CoreData/         # CoreData configuration and models
├── Model/           # Data models
├── View/            # SwiftUI views
├── ViewModel/       # View models for business logic
└── Assets.xcassets/ # Project assets
```

## Detailed Architecture

### Model Layer
The Model layer consists of:

1. **Data Models**
   - `Digimon.swift`: Core data model representing a Digimon creature
   - Properties include name, image URL, and level
   - Conforms to Codable for JSON parsing

2. **CoreData Entities**
   - `DigimonEntity`: Persistent storage model
   - Managed by CoreData for local storage
   - Mirrors the structure of the Digimon model

### View Layer
The View layer is built with SwiftUI and includes:

1. **Main Views**
   - `DigimonListView`: Main list view showing all Digimon
   - `DigimonDetailView`: Detailed view of a single Digimon
   - `DigimonListCell`: Reusable cell for list items

2. **UI Features**
   - Modern SwiftUI components
   - Smooth animations and transitions
   - Responsive layout
   - Error state handling
   - Loading indicators

### ViewModel Layer
The ViewModel layer handles business logic:

1. **DigimonViewModel**
   - Manages data flow between Model and View
   - Handles API calls and data persistence
   - Provides data transformation
   - Manages state and user interactions

2. **Key Responsibilities**
   - Data fetching and caching
   - Error handling
   - State management
   - User input processing

## CoreData Implementation

The app uses CoreData for efficient local storage and data persistence. Here's a detailed breakdown of the CoreData implementation:

### CoreData Manager
The `CoreDataManager` class handles all database operations with the following features:

1. **Background Thread Operations**
   - All database operations are performed on background threads using `performBackgroundTask`
   - Prevents UI blocking during heavy database operations
   - Ensures smooth user experience
   - Thread-safe operations

2. **Data Operations**
   - `saveDataIntoDatabase`: Saves Digimon data to CoreData
     - Handles batch operations
     - Includes error handling
     - Supports data updates
   - `fetchDataFromDatabase`: Retrieves stored Digimon entities
     - Efficient querying
     - Supports filtering
     - Handles large datasets
   - `deleteAllData`: Cleans up the database when needed
     - Safe deletion process
     - Transaction management
     - Error recovery

3. **Entity Structure**
   - `DigimonEntity`: Stores Digimon information with properties:
     - name: String
     - img: String
     - level: String
   - Relationships and constraints
   - Indexed properties for better performance

4. **Error Handling**
   - Comprehensive error handling for database operations
   - Proper error propagation to the UI layer
   - Recovery mechanisms
   - User-friendly error messages

### CoreData Stack
The app uses a singleton `PersistenceController` for managing the CoreData stack:
- Shared container for consistent database access
- View context for main thread operations
- Background context for heavy operations
- Automatic migration support
- Data versioning

### Best Practices Implemented
- Background thread operations for better performance
- Proper context management
- Efficient data fetching
- Clean separation of concerns
- Protocol-oriented design for better testability
- Memory management
- Transaction handling
- Data consistency checks

## API Integration

The app integrates with the Digimon API:
- RESTful API communication
- JSON parsing
- Error handling
- Rate limiting
- Caching strategy

## Performance Optimizations

1. **Data Management**
   - Efficient CoreData operations
   - Background thread processing
   - Memory management
   - Cache optimization

2. **UI Performance**
   - Lazy loading
   - Image caching
   - Smooth scrolling
   - Efficient list rendering

## Testing

The project includes:
- Unit tests for business logic
- UI tests for user interactions
- CoreData testing utilities
- Mock data for testing

## Dependencies

- SwiftUI
- CoreData
- Foundation
- Combine (for reactive programming)
- 
