-- 1. Customers Table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50),
    email VARCHAR(50)
);

-- 2. Products Table
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    category VARCHAR(30),
    price INT,
    stock INT
);

-- 3. Orders Table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- DUMMY DATA
INSERT INTO customers VALUES 
(1, 'Budi Santoso', 'Jakarta', 'budi@email.com'),
(2, 'Siti Aminah', 'Surabaya', 'siti@email.com'),
(3, 'Andi Wijaya', 'Bandung', 'andi@email.com'),
(4, 'Dewi Lestari', 'Jakarta', 'dewi@email.com'),
(5, 'Rian Hidayat', 'Medan', 'rian@email.com');

INSERT INTO products VALUES 
(101, 'Asus Laptop', 'Electronics', 8000000, 15),
(102, 'Samsung Smartphone', 'Gadget', 5000000, 20),
(103, 'Logitech Mouse', 'Accessories', 250000, 50),
(104, 'Mechanical Keyboard', 'Accessories', 750000, 30),
(105, 'LG Monitor 24 Inch', 'Electronics', 2000000, 10);

INSERT INTO orders VALUES 
(201, 1, 101, 1, '2026-05-01'),
(202, 1, 103, 2, '2026-05-02'),
(203, 2, 102, 1, '2026-05-03'),
(204, 3, 104, 1, '2026-05-04'),
(205, 4, 101, 1, '2026-05-05'),
(206, 2, 103, 4, '2026-05-06'),
(207, 5, 105, 2, '2026-05-07'),
(208, 3, 102, 1, '2026-05-08'),
(209, 1, 104, 1, '2026-05-09'),
(210, 4, 105, 1, '2026-05-10');