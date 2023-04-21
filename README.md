---

# VIPER-iTunesSearch

This project demonstrates an iOS application developed using the VIPER architecture and managing the network layer using `URLProtocol`. The application allows users to search for books, movies, and more using the open API from https://itunes.apple.com/. It has been developed with integration and unit tests in mind.

## About the Project

This project is a simple search application developed using the VIPER architecture. The application fetches books, movies, and other media from the iTunes API and displays the results on the screen. The network layer utilizes `URLProtocol` to manage API requests, enabling easy mocking of network requests for testing purposes.

## VIPER Architecture Components

VIPER consists of **View**, **Interactor**, **Presenter**, **Entity**, and **Router** components.

- **View**: Manages user interactions and interface updates. The View communicates with the Presenter.
- **Interactor**: Manages the application's business logic. API calls, database operations, and other actions are performed here.
- **Presenter**: Facilitates communication between the View and Interactor. The Presenter directs user actions and reflects the results on the screen.
- **Entity**: Represents the data models of the application.
- **Router**: Manages screen transitions within the application.

## URLProtocol Usage

`URLProtocol` allows for the customization and mocking of network requests for use in tests. In this project, a `NetworkManager` class has been developed that uses `URLProtocol` to manage API requests. This approach makes the network layer suitable for testing.

## Tests

The project has been prepared for both integration and unit tests. These tests include:

- **Integration Tests**: Test how different components of the application work together. In these tests, API requests are mocked using `URLProtocol`, and no real network connection is used.
- **Unit Tests**: Test the independent components of the application. In these tests, Presenter and Interactor operations are tested separately.

## Setup

1. Clone or download the project to your local machine.
2. Navigate to the project folder in the terminal and run `pod install` to install dependencies.
3. Open `VIPER-URLProtocol-iTunesSearch.xcworkspace` in Xcode.
4. Build and run the project on an iOS simulator or physical device.

## Usage

1. Launch the application.
2. Use the search bar at the top of the screen to search for books, movies, or other media.
3. The application will display search results from the iTunes API, including titles, artwork, and additional information.
4. Tap on a search result to view more details about the item.
