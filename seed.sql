-- seed.sql
-- Populates the simplified database with initial data for testing.

-- Insert roles (only what's needed for the scope)
INSERT INTO roles (role_name) VALUES ('Customer'), ('KitchenStaff'), ('Admin');

-- Insert users (a kitchen user for the KOS, an admin to manage menu)
-- In a real app, passwords must be hashed before insertion.
INSERT INTO users (role_id, username, password_hash) VALUES
((SELECT role_id from roles WHERE role_name = 'KitchenStaff'), 'chef1', 'hashed_password_for_chef1'),
((SELECT role_id from roles WHERE role_name = 'Admin'), 'admin', 'hashed_password_for_admin');


-- Insert restaurant tables
INSERT INTO restaurant_tables (table_number, status) VALUES (1, 'Available'), (2, 'Available'), (3, 'Occupied');

-- Insert menu categories 
INSERT INTO menu_categories (name) VALUES
('Appetizers'),
('Main Courses'),
('Desserts');

-- Insert sample menu items 
INSERT INTO menu_items (category_id, name, description, price, customization_options, allergen_info) VALUES
((SELECT category_id from menu_categories WHERE name = 'Appetizers'), 'Bruschetta', 'Toasted bread with fresh tomatoes, garlic, and basil.', 8.50, '{"add_ons": ["feta cheese", "olives"]}', '{gluten, dairy-free option}'),
((SELECT category_id from menu_categories WHERE name = 'Main Courses'), 'Spaghetti Carbonara', 'Classic pasta with pancetta, eggs, and parmesan cheese.', 15.00, '{"size": ["regular", "large"], "extra": ["chicken", "bacon"]}', '{gluten, dairy, eggs}'),
((SELECT category_id from menu_categories WHERE name = 'Desserts'), 'Chocolate Lava Cake', 'Warm chocolate cake with a gooey molten center.', 7.00, '{"serving_style": ["with ice cream", "with berries"]}', '{gluten, dairy}');

-- Insert a sample order to test the KOS 
-- This assumes table 3 has placed an order
INSERT INTO orders (table_id, status) VALUES (3, 'Received');

-- Add items to the sample order
-- NOTE: In a real app, you would get the order_id programmatically. For seeding, we assume it's 1.
INSERT INTO order_items (order_id, item_id, quantity, customizations) VALUES
(1, 2, 1, '{"size": "large", "extra": "chicken"}'),
(1, 1, 1, '{"add_ons": ["feta cheese"]}');