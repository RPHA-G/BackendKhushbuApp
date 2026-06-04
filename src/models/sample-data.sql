-- Sample Data for Khushi Glossary Store
-- Run this AFTER running the database-schema.sql

-- Insert Sample Users (password is 'password123' hashed with bcrypt)
INSERT INTO users (id, phone, name, email, password, role) VALUES
('550e8400-e29b-41d4-a716-446655440001', '+919876543210', 'Rajesh Kumar', 'rajesh@example.com', '$2a$10$YourHashedPasswordHere1', 'user'),
('550e8400-e29b-41d4-a716-446655440002', '+919876543211', 'Priya Sharma', 'priya@example.com', '$2a$10$YourHashedPasswordHere2', 'user'),
('550e8400-e29b-41d4-a716-446655440003', '+919876543212', 'Amit Patel', 'amit@example.com', '$2a$10$YourHashedPasswordHere3', 'user'),
('550e8400-e29b-41d4-a716-446655440004', '+919876543213', 'Neha Singh', 'neha@example.com', '$2a$10$YourHashedPasswordHere4', 'user'),
('550e8400-e29b-41d4-a716-446655440005', '+919876543214', 'Admin User', 'admin@khushi.com', '$2a$10$YourHashedPasswordHere5', 'admin');

-- Get category IDs for reference (assuming categories were already inserted)
-- We'll use the first few categories that were inserted

-- Insert Subcategories
INSERT INTO subcategories (category_id, name, icon, display_order) VALUES
((SELECT id FROM categories WHERE name = 'Dairy, Bread & Eggs' LIMIT 1), 'Milk', '🥛', 1),
((SELECT id FROM categories WHERE name = 'Dairy, Bread & Eggs' LIMIT 1), 'Bread & Pav', '🍞', 2),
((SELECT id FROM categories WHERE name = 'Dairy, Bread & Eggs' LIMIT 1), 'Eggs', '🥚', 3),
((SELECT id FROM categories WHERE name = 'Fruits & Vegetables' LIMIT 1), 'Fresh Vegetables', '🥕', 1),
((SELECT id FROM categories WHERE name = 'Fruits & Vegetables' LIMIT 1), 'Fresh Fruits', '🍎', 2),
((SELECT id FROM categories WHERE name = 'Cold Drinks & Juices' LIMIT 1), 'Soft Drinks', '🥤', 1),
((SELECT id FROM categories WHERE name = 'Cold Drinks & Juices' LIMIT 1), 'Juices', '🧃', 2),
((SELECT id FROM categories WHERE name = 'Snacks & Munchies' LIMIT 1), 'Chips & Namkeen', '🥔', 1),
((SELECT id FROM categories WHERE name = 'Snacks & Munchies' LIMIT 1), 'Biscuits', '🍪', 2);

-- Insert Sample Products
INSERT INTO products (name, description, price, original_price, category_id, image_url, unit, weight, stock_quantity, rating, is_featured) VALUES
-- Dairy Products
('Amul Taaza Toned Milk', 'Fresh toned milk, rich in calcium and protein', 28.00, 30.00, 
 (SELECT id FROM categories WHERE name = 'Dairy, Bread & Eggs' LIMIT 1), 
 'https://example.com/amul-milk.jpg', 'Pouch', '500 ml', 100, 4.5, true),

('Mother Dairy Full Cream Milk', 'Pure and fresh full cream milk', 32.00, 35.00,
 (SELECT id FROM categories WHERE name = 'Dairy, Bread & Eggs' LIMIT 1),
 'https://example.com/mother-dairy-milk.jpg', 'Pouch', '500 ml', 80, 4.7, true),

('Britannia Bread - White', 'Soft and fresh white bread', 40.00, 45.00,
 (SELECT id FROM categories WHERE name = 'Dairy, Bread & Eggs' LIMIT 1),
 'https://example.com/britannia-bread.jpg', 'Pack', '400 g', 50, 4.3, false),

('Farm Fresh Eggs', 'Brown eggs, protein rich', 60.00, 65.00,
 (SELECT id FROM categories WHERE name = 'Dairy, Bread & Eggs' LIMIT 1),
 'https://example.com/eggs.jpg', 'Tray', '6 pieces', 200, 4.6, true),

-- Fruits & Vegetables
('Fresh Tomatoes', 'Red, ripe and fresh tomatoes', 30.00, 35.00,
 (SELECT id FROM categories WHERE name = 'Fruits & Vegetables' LIMIT 1),
 'https://example.com/tomatoes.jpg', 'kg', '1 kg', 150, 4.4, false),

('Fresh Onions', 'Indian red onions', 25.00, 28.00,
 (SELECT id FROM categories WHERE name = 'Fruits & Vegetables' LIMIT 1),
 'https://example.com/onions.jpg', 'kg', '1 kg', 180, 4.2, false),

('Royal Gala Apples', 'Sweet and crispy apples', 180.00, 200.00,
 (SELECT id FROM categories WHERE name = 'Fruits & Vegetables' LIMIT 1),
 'https://example.com/apples.jpg', 'kg', '1 kg', 90, 4.8, true),

('Fresh Bananas', 'Ripe yellow bananas', 50.00, 55.00,
 (SELECT id FROM categories WHERE name = 'Fruits & Vegetables' LIMIT 1),
 'https://example.com/bananas.jpg', 'Dozen', '12 pieces', 120, 4.5, false),

-- Cold Drinks & Juices
('Coca Cola', 'Classic cola soft drink', 40.00, 45.00,
 (SELECT id FROM categories WHERE name = 'Cold Drinks & Juices' LIMIT 1),
 'https://example.com/coca-cola.jpg', 'Bottle', '750 ml', 200, 4.6, true),

('Pepsi', 'Refreshing cola drink', 40.00, 45.00,
 (SELECT id FROM categories WHERE name = 'Cold Drinks & Juices' LIMIT 1),
 'https://example.com/pepsi.jpg', 'Bottle', '750 ml', 180, 4.5, false),

('Real Fruit Juice - Orange', '100% natural orange juice', 110.00, 120.00,
 (SELECT id FROM categories WHERE name = 'Cold Drinks & Juices' LIMIT 1),
 'https://example.com/real-juice.jpg', 'Bottle', '1 L', 100, 4.7, true),

('Tropicana Mixed Fruit Juice', 'Mixed fruit juice with no added sugar', 125.00, 135.00,
 (SELECT id FROM categories WHERE name = 'Cold Drinks & Juices' LIMIT 1),
 'https://example.com/tropicana.jpg', 'Bottle', '1 L', 80, 4.6, false),

-- Snacks & Munchies
('Lays Classic Salted', 'Crispy potato chips', 20.00, 25.00,
 (SELECT id FROM categories WHERE name = 'Snacks & Munchies' LIMIT 1),
 'https://example.com/lays.jpg', 'Pack', '52 g', 250, 4.4, true),

('Kurkure Masala Munch', 'Spicy masala snack', 20.00, 25.00,
 (SELECT id FROM categories WHERE name = 'Snacks & Munchies' LIMIT 1),
 'https://example.com/kurkure.jpg', 'Pack', '55 g', 220, 4.5, false),

('Haldirams Aloo Bhujia', 'Traditional Indian namkeen', 80.00, 90.00,
 (SELECT id FROM categories WHERE name = 'Snacks & Munchies' LIMIT 1),
 'https://example.com/haldirams.jpg', 'Pack', '200 g', 150, 4.7, true),

-- Atta, Rice & Dal
('Aashirvaad Atta', 'Whole wheat flour', 280.00, 300.00,
 (SELECT id FROM categories WHERE name = 'Atta, Rice & Dal' LIMIT 1),
 'https://example.com/aashirvaad.jpg', 'Pack', '5 kg', 120, 4.8, true),

('India Gate Basmati Rice', 'Premium basmati rice', 180.00, 200.00,
 (SELECT id FROM categories WHERE name = 'Atta, Rice & Dal' LIMIT 1),
 'https://example.com/basmati.jpg', 'Pack', '1 kg', 100, 4.7, true),

('Toor Dal', 'Yellow pigeon peas', 130.00, 140.00,
 (SELECT id FROM categories WHERE name = 'Atta, Rice & Dal' LIMIT 1),
 'https://example.com/toor-dal.jpg', 'Pack', '1 kg', 90, 4.5, false),

-- Masala, Oil & More
('Fortune Sunflower Oil', 'Refined sunflower oil', 180.00, 195.00,
 (SELECT id FROM categories WHERE name = 'Masala, Oil & More' LIMIT 1),
 'https://example.com/fortune-oil.jpg', 'Bottle', '1 L', 80, 4.6, false),

('MDH Chana Masala', 'Spice mix for chickpeas', 45.00, 50.00,
 (SELECT id FROM categories WHERE name = 'Masala, Oil & More' LIMIT 1),
 'https://example.com/mdh-masala.jpg', 'Box', '100 g', 150, 4.7, false),

('Tata Salt', 'Iodized table salt', 20.00, 22.00,
 (SELECT id FROM categories WHERE name = 'Masala, Oil & More' LIMIT 1),
 'https://example.com/tata-salt.jpg', 'Pack', '1 kg', 200, 4.5, false),

-- Bakery & Biscuits
('Parle-G Biscuits', 'Classic glucose biscuits', 10.00, 12.00,
 (SELECT id FROM categories WHERE name = 'Bakery & Biscuits' LIMIT 1),
 'https://example.com/parle-g.jpg', 'Pack', '100 g', 300, 4.8, true),

('Britannia Good Day', 'Butter cookies', 30.00, 35.00,
 (SELECT id FROM categories WHERE name = 'Bakery & Biscuits' LIMIT 1),
 'https://example.com/good-day.jpg', 'Pack', '150 g', 180, 4.6, false),

('Oreo Original', 'Chocolate sandwich cookies', 40.00, 45.00,
 (SELECT id FROM categories WHERE name = 'Bakery & Biscuits' LIMIT 1),
 'https://example.com/oreo.jpg', 'Pack', '120 g', 200, 4.7, true),

-- Tea, Coffee & Milk Drinks
('Tata Tea Gold', 'Premium black tea', 220.00, 240.00,
 (SELECT id FROM categories WHERE name = 'Tea, Coffee & Milk Drinks' LIMIT 1),
 'https://example.com/tata-tea.jpg', 'Pack', '500 g', 100, 4.7, true),

('Nescafe Classic', 'Instant coffee', 180.00, 200.00,
 (SELECT id FROM categories WHERE name = 'Tea, Coffee & Milk Drinks' LIMIT 1),
 'https://example.com/nescafe.jpg', 'Jar', '100 g', 90, 4.6, true),

('Horlicks Classic Malt', 'Health drink for all ages', 350.00, 380.00,
 (SELECT id FROM categories WHERE name = 'Tea, Coffee & Milk Drinks' LIMIT 1),
 'https://example.com/horlicks.jpg', 'Jar', '500 g', 80, 4.5, false);

-- Insert Sample Addresses
INSERT INTO addresses (user_id, address_line1, area, city, state, pincode, landmark, address_type, is_default) VALUES
('550e8400-e29b-41d4-a716-446655440001', 'Flat 201, Shanti Apartments', 'Near City Mall', 'Mumbai', 'Maharashtra', '400001', 'Opposite SBI Bank', 'home', true),
('550e8400-e29b-41d4-a716-446655440001', 'Building 5, Tech Park', 'Andheri East', 'Mumbai', 'Maharashtra', '400069', 'Near Metro Station', 'work', false),
('550e8400-e29b-41d4-a716-446655440002', 'House No 45, Green Valley', 'Sector 12', 'Delhi', 'Delhi', '110001', 'Behind Market', 'home', true),
('550e8400-e29b-41d4-a716-446655440003', '3rd Floor, Rose Apartment', 'MG Road', 'Bangalore', 'Karnataka', '560001', 'Near Coffee Day', 'home', true),
('550e8400-e29b-41d4-a716-446655440004', 'B-204, Sunrise Heights', 'Wakad', 'Pune', 'Maharashtra', '411057', 'Near Phoenix Mall', 'home', true);

-- Insert Cart Items (for active shopping carts)
INSERT INTO cart_items (user_id, product_id, quantity) VALUES
('550e8400-e29b-41d4-a716-446655440001', 
 (SELECT id FROM products WHERE name = 'Amul Taaza Toned Milk' LIMIT 1), 2),
('550e8400-e29b-41d4-a716-446655440001', 
 (SELECT id FROM products WHERE name = 'Britannia Bread - White' LIMIT 1), 1),
('550e8400-e29b-41d4-a716-446655440001', 
 (SELECT id FROM products WHERE name = 'Farm Fresh Eggs' LIMIT 1), 1),
('550e8400-e29b-41d4-a716-446655440002', 
 (SELECT id FROM products WHERE name = 'Royal Gala Apples' LIMIT 1), 2),
('550e8400-e29b-41d4-a716-446655440002', 
 (SELECT id FROM products WHERE name = 'Real Fruit Juice - Orange' LIMIT 1), 1),
('550e8400-e29b-41d4-a716-446655440003', 
 (SELECT id FROM products WHERE name = 'Lays Classic Salted' LIMIT 1), 5),
('550e8400-e29b-41d4-a716-446655440003', 
 (SELECT id FROM products WHERE name = 'Coca Cola' LIMIT 1), 2);

-- Insert Sample Orders
INSERT INTO orders (id, user_id, order_number, address_id, subtotal, delivery_fee, small_cart_charge, total, status, payment_method, payment_status) VALUES
('650e8400-e29b-41d4-a716-446655440001', 
 '550e8400-e29b-41d4-a716-446655440001',
 'ORD-2025-001',
 (SELECT id FROM addresses WHERE user_id = '550e8400-e29b-41d4-a716-446655440001' AND is_default = true LIMIT 1),
 396.00, 40.00, 0.00, 436.00, 'delivered', 'cod', 'completed'),

('650e8400-e29b-41d4-a716-446655440002',
 '550e8400-e29b-41d4-a716-446655440002',
 'ORD-2025-002',
 (SELECT id FROM addresses WHERE user_id = '550e8400-e29b-41d4-a716-446655440002' LIMIT 1),
 580.00, 40.00, 0.00, 620.00, 'out_for_delivery', 'online', 'completed'),

('650e8400-e29b-41d4-a716-446655440003',
 '550e8400-e29b-41d4-a716-446655440003',
 'ORD-2025-003',
 (SELECT id FROM addresses WHERE user_id = '550e8400-e29b-41d4-a716-446655440003' LIMIT 1),
 240.00, 40.00, 40.00, 320.00, 'processing', 'cod', 'pending'),

('650e8400-e29b-41d4-a716-446655440004',
 '550e8400-e29b-41d4-a716-446655440004',
 'ORD-2025-004',
 (SELECT id FROM addresses WHERE user_id = '550e8400-e29b-41d4-a716-446655440004' LIMIT 1),
 810.00, 40.00, 0.00, 850.00, 'confirmed', 'wallet', 'completed'),

('650e8400-e29b-41d4-a716-446655440005',
 '550e8400-e29b-41d4-a716-446655440001',
 'ORD-2025-005',
 (SELECT id FROM addresses WHERE user_id = '550e8400-e29b-41d4-a716-446655440001' AND is_default = true LIMIT 1),
 156.00, 40.00, 40.00, 236.00, 'pending', 'cod', 'pending');

-- Insert Order Items
INSERT INTO order_items (order_id, product_id, quantity, price, subtotal) VALUES
-- Order 1 items
('650e8400-e29b-41d4-a716-446655440001',
 (SELECT id FROM products WHERE name = 'Amul Taaza Toned Milk' LIMIT 1), 2, 28.00, 56.00),
('650e8400-e29b-41d4-a716-446655440001',
 (SELECT id FROM products WHERE name = 'Royal Gala Apples' LIMIT 1), 1, 180.00, 180.00),
('650e8400-e29b-41d4-a716-446655440001',
 (SELECT id FROM products WHERE name = 'Haldirams Aloo Bhujia' LIMIT 1), 2, 80.00, 160.00),

-- Order 2 items
('650e8400-e29b-41d4-a716-446655440002',
 (SELECT id FROM products WHERE name = 'Aashirvaad Atta' LIMIT 1), 1, 280.00, 280.00),
('650e8400-e29b-41d4-a716-446655440002',
 (SELECT id FROM products WHERE name = 'India Gate Basmati Rice' LIMIT 1), 1, 180.00, 180.00),
('650e8400-e29b-41d4-a716-446655440002',
 (SELECT id FROM products WHERE name = 'Toor Dal' LIMIT 1), 1, 130.00, 130.00),

-- Order 3 items
('650e8400-e29b-41d4-a716-446655440003',
 (SELECT id FROM products WHERE name = 'Lays Classic Salted' LIMIT 1), 4, 20.00, 80.00),
('650e8400-e29b-41d4-a716-446655440003',
 (SELECT id FROM products WHERE name = 'Coca Cola' LIMIT 1), 4, 40.00, 160.00),

-- Order 4 items
('650e8400-e29b-41d4-a716-446655440004',
 (SELECT id FROM products WHERE name = 'Tata Tea Gold' LIMIT 1), 2, 220.00, 440.00),
('650e8400-e29b-41d4-a716-446655440004',
 (SELECT id FROM products WHERE name = 'Nescafe Classic' LIMIT 1), 2, 180.00, 360.00),

-- Order 5 items
('650e8400-e29b-41d4-a716-446655440005',
 (SELECT id FROM products WHERE name = 'Britannia Bread - White' LIMIT 1), 2, 40.00, 80.00),
('650e8400-e29b-41d4-a716-446655440005',
 (SELECT id FROM products WHERE name = 'Farm Fresh Eggs' LIMIT 1), 1, 60.00, 60.00);

-- Insert Favorites
INSERT INTO favorites (user_id, product_id) VALUES
('550e8400-e29b-41d4-a716-446655440001', 
 (SELECT id FROM products WHERE name = 'Amul Taaza Toned Milk' LIMIT 1)),
('550e8400-e29b-41d4-a716-446655440001', 
 (SELECT id FROM products WHERE name = 'Royal Gala Apples' LIMIT 1)),
('550e8400-e29b-41d4-a716-446655440001', 
 (SELECT id FROM products WHERE name = 'Parle-G Biscuits' LIMIT 1)),
('550e8400-e29b-41d4-a716-446655440002', 
 (SELECT id FROM products WHERE name = 'Tata Tea Gold' LIMIT 1)),
('550e8400-e29b-41d4-a716-446655440002', 
 (SELECT id FROM products WHERE name = 'Oreo Original' LIMIT 1)),
('550e8400-e29b-41d4-a716-446655440003', 
 (SELECT id FROM products WHERE name = 'Coca Cola' LIMIT 1)),
('550e8400-e29b-41d4-a716-446655440003', 
 (SELECT id FROM products WHERE name = 'Lays Classic Salted' LIMIT 1));

-- Verify data insertion
SELECT 'Users' as table_name, COUNT(*) as count FROM users
UNION ALL
SELECT 'Products', COUNT(*) FROM products
UNION ALL
SELECT 'Addresses', COUNT(*) FROM addresses
UNION ALL
SELECT 'Cart Items', COUNT(*) FROM cart_items
UNION ALL
SELECT 'Orders', COUNT(*) FROM orders
UNION ALL
SELECT 'Order Items', COUNT(*) FROM order_items
UNION ALL
SELECT 'Favorites', COUNT(*) FROM favorites;
