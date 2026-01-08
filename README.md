
# food-delivery-sql-project
A SQL-based Food Delivery Management System showcasing database design, relational modeling, and analytical queries for customer, order, restaurant, and sales insights.
# Food Delivery SQL Database Project

## 📌 Project Overview

This project demonstrates the design and implementation of a **Food Delivery Management System** using SQL. It covers database creation, table relationships, constraints, data insertion, and a wide range of analytical queries to extract meaningful business insights.

The project is suitable for **SQL practice, academic submission, and data analyst portfolio projects**.

---

## 🛠️ Technologies Used

* **Database:** MySQL
* **Language:** SQL

---

## 🗂️ Database Structure

The database consists of the following tables:

### 1. Customers

Stores customer details such as name, contact, and city.

### 2. Restaurants

Contains restaurant information and their locations.

### 3. Menu_Items

Stores menu items offered by restaurants along with prices.

### 4. Orders

Maintains order details including customer, date, and total amount.

### 5. OrderItems

Acts as a bridge table between orders and menu items, tracking quantities.

### 6. Payments

Stores payment details and payment status for each order.

---

## 🔗 Relationships

* Customers → Orders (One-to-Many)
* Restaurants → Menu_Items (One-to-Many)
* Orders → OrderItems (One-to-Many)
* Menu_Items → OrderItems (One-to-One per order item)
* Orders → Payments (One-to-One)

---

## 📊 Key Features & Queries

### Basic Analytics

* Total number of customers
* Total revenue generated
* Average, maximum, and minimum order values
* Minimum item price

### Customer Analysis

* Orders per customer
* Customers from a specific city
* Customers with no orders
* Customers ordering from multiple restaurants
* Customers whose latest order value exceeds their average

### Restaurant & Sales Analysis

* Total sales per restaurant
* Restaurant with the highest sales
* Restaurants with sales above a specific amount
* Peak sales day of the week

### Order & Time-Based Analysis

* Latest orders
* Orders above a certain value
* Orders placed today
* Orders in the last 7 days
* Orders by year and month

### Payment Analysis

* Completed payments count
* Pending vs paid payment tracking

### Advanced Queries

* Customers with order value above average
* Items priced above the average
* Order with the maximum total amount
* Customers with higher-than-average order frequency

---

## 📈 Business Insights Enabled

* Identify top-performing restaurants
* Understand customer purchasing behavior
* Track payment completion trends
* Analyze peak demand periods
* Support data-driven business decisions

---

## ✅ Data Integrity & Constraints

* Primary and foreign keys for relational integrity
* CHECK constraint on item price
* UNIQUE constraint on customer phone numbers
* Default payment status handling

---

## 🚀 How to Run the Project

1. Create the database using the provided SQL script.
2. Execute table creation queries in order.
3. Insert sample data into each table.
4. Run analytical queries to explore insights.

---

## 📌 Use Cases

* SQL learning and practice
* Academic database projects
* Data analyst portfolio demonstration
* Interview preparation

---

## 👤 Author

**Bala Kiruthika**
SQL & Data Analytics Enthusiast

---

## 📄 License

This project is for educational and learning purposes.
