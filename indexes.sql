-- indexes.sql
-- Creates indexes on foreign keys and frequently queried columns.

-- Index for users table
CREATE INDEX idx_users_role_id ON users(role_id);

-- Index for menu_items table
CREATE INDEX idx_menu_items_category_id ON menu_items(category_id);

-- Indexes for orders table
CREATE INDEX idx_orders_table_id ON orders(table_id);
CREATE INDEX idx_orders_status ON orders(status); -- Crucial for the KOS to query orders efficiently 

-- Indexes for order_items table
CREATE INDEX idx_order_items_order_id ON order_items(order_id);
CREATE INDEX idx_order_items_item_id ON order_items(item_id);

-- GIN index for querying JSONB customization options in the menu 
CREATE INDEX idx_menu_items_custom_options ON menu_items USING GIN (customization_options);