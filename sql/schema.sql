-- schema.sql
-- This simplified schema is for the core ordering and KOS modules.

-- Drop existing tables in reverse order of dependency
DROP TABLE IF EXISTS order_items CASCADE;
DROP TABLE IF EXISTS orders CASCADE;
DROP TABLE IF EXISTS menu_items CASCADE;
DROP TABLE IF EXISTS menu_categories CASCADE;
DROP TABLE IF EXISTS restaurant_tables CASCADE;
DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS roles CASCADE;

-- Roles for basic access control (e.g., Kitchen Staff) 
CREATE TABLE roles (
    role_id SERIAL PRIMARY KEY,
    role_name VARCHAR(50) UNIQUE NOT NULL
);

-- Users table, primarily for staff logins to the KOS
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    role_id INTEGER NOT NULL REFERENCES roles(role_id),
    username VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL
);

-- Table to represent physical tables in the restaurant
CREATE TABLE restaurant_tables (
    table_id SERIAL PRIMARY KEY,
    table_number INTEGER UNIQUE NOT NULL,
    status VARCHAR(50) NOT NULL DEFAULT 'Available'
);

-- Table for menu categories to organize the menu display 
CREATE TABLE menu_categories (
    category_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- Table for menu items, including customizations and allergen info 
CREATE TABLE menu_items (
    item_id SERIAL PRIMARY KEY,
    category_id INTEGER NOT NULL REFERENCES menu_categories(category_id),
    name VARCHAR(150) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    image_url VARCHAR(255),
    customization_options JSONB, -- For requirement R2
    allergen_info TEXT[]         -- For requirement R14
);

-- Table for customer orders 
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    table_id INTEGER NOT NULL REFERENCES restaurant_tables(table_id),
    status VARCHAR(50) NOT NULL DEFAULT 'Received', -- e.g., 'Received', 'In Preparation', 'Ready for Pickup'
    order_timestamp TIMESTAMPTZ DEFAULT NOW()
);

-- Junction table for the specific items within each order
CREATE TABLE order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INTEGER NOT NULL REFERENCES orders(order_id) ON DELETE CASCADE,
    item_id INTEGER NOT NULL REFERENCES menu_items(item_id),
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    customizations JSONB -- Stores chosen customizations for an item 
);