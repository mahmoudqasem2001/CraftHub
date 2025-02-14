
# Craft Hub Flutter App Development

## Project Description

Craft Hub is a Flutter-based platform that connects artists and customers, allowing users to manage and interact with various art projects. The project utilizes the MVVM (Model-View-ViewModel) pattern and Cubit for state management to ensure a scalable and maintainable codebase.

## Features

### 1. Comments for Each Item
- **Comment Details:**
  - ID
  - User (regular user or artist)
  - Comment text
  - Timestamp
- **Retrieval:**
  - User's profile picture
  - User's name
  - Comment text
  - Sorted from newest to oldest

### 2. Item Likes
- Each item will have a specific number of likes.
- The count will be stored as a variable within the item table.

### 3. Orders for Artists
- **Order Details:**
  - ID
  - Status (Recently Arrived, Processing, Complete)
  - Order date
  - Total price
  - Shipping address (may differ from the user's address)
- **Items in Order:**
  - Item name
  - Price per unit
  - Item image
  - Quantity ordered
- **Retrieval:**
  - Order ID
  - Status
  - Order date
  - Total price
  - Allow filtering by status specified by the artist
  - Sorting options: newest to oldest, oldest to newest, most expensive to least expensive, least expensive to most expensive
  - User's name
  - Shipping address
  - User's phone number
  - User's email
  - List of items in the order

### 4. Category Management
- **Category Suggestions:**
  - When an artist registers their project and finds no suitable category, they can select "Others."
  - Artists can enter their project's category in a text field.
  - Suggestions will be stored in a list accessible only to the Admin.
  - Admin can review and add acceptable suggestions to the predefined list of categories or ignore them.
  - The predefined list of categories and their representative images are stored in the code since there is currently no API for them.

### 5. User Types
- The system will support three types of users:
  - Super Admin
  - Artists
  - Customers

## Architecture

### MVVM Pattern
The project follows the MVVM (Model-View-ViewModel) pattern to ensure a clear separation of concerns and promote maintainability. This architecture helps in managing the UI logic separately from the business logic.

### State Management with Cubit
Cubit, a lightweight state management solution, is used to manage the state of the application. It simplifies the process of managing and updating state, making the code more predictable and easier to test.

## Predefined Categories
The list of predefined categories and their representative images are stored in the code. These categories are used for initial project classification and can be updated by the Admin based on suggestions.
