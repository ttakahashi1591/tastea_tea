# Tastea Tea API

Tastea Tea is an API which provides a platform built on Rails for managing tea subscriptions. Users can subscribe to tea services, cancel subscriptions, and view a comprehensive list of their active and canceled subscriptions through dedicated endpoints. The API aims for simplicity, emphasizing a strong understanding of Rails, RESTful routes, organized Object-Oriented Programming (OOP) code, Test Driven Development (TDD) practices, and clear documentation. The API models include Tea (with attributes such as Title, Description, Temperature, Brew Time), Customer (including First Name, Last Name, Email, Address), and Subscription (with Title, Price, Status, Frequency).

## Versions
- `Ruby 3.2.2`
- `Rails 7.1.3`

## Set-Up Instructions
- Fork and clone this GitHub Reposistory:
  - [Tastea Tea Repo](https://github.com/ttakahashi1591/tastea_tea)

- Install necessary gems: 
  - `bundle exec install`

- Create & Migrate the Database: 
  - `rails db:{create,migrate}`

- Run the tests suite and all tests should be passing:
  - `bundle exec rspec`

## Endpoints
- Subscribe a new Tastea Tea Customer
- Cancel a current Tastea Tea Customer's Subscription
- See all exisiting Customer's Subscriptions (Admin)

## Tastea Tea Database
![Tastea Tea Databse](image.png)





