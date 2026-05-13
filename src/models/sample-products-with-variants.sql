-- Sample Products with Variants
-- Execute this after running add-product-variants.sql
-- Adds 20 products across different categories with multiple variants each

-- STEP 1: Clean existing products and variants
-- This will remove all existing data before inserting new products
TRUNCATE TABLE product_variants CASCADE;
TRUNCATE TABLE products CASCADE;

-- Category IDs Reference:
-- Atta, Rice & Dal: e2ad8385-d746-4726-b58d-878ae2936c68
-- Dairy, Bread & Eggs: 1cd6f3c4-2bec-43c3-b085-5e5f6f634e57
-- Fruits & Vegetables: d5686831-13de-41a2-aef5-6521fb632c96
-- Cold Drinks & Juices: a4285e10-e4e7-4d97-b373-4f21e14bad72
-- Snacks & Munchies: 14446517-cf2b-4d75-9659-43b6ac754e88
-- Breakfast & Instant Food: 6dae1c33-d005-4863-855c-cb7ce6312f55
-- Sweet Tooth: ffa76e17-98f5-4591-8bb2-d74b7eb82390
-- Bakery & Biscuits: 6c2bc401-8259-44c8-b063-8636ff4d5656
-- Tea, Coffee & Milk Drinks: 424e4638-266c-4271-936b-cc7b10674550
-- Masala, Oil & More: 29cb1a04-16f4-4d33-b570-00eaa39ec966
-- Sauces & Spreads: 22543779-6898-4c55-84c6-cfbd0ce3b413
-- Organic & Healthy Living: 27d7a14e-4692-4cef-83b3-baa197422c3e

-- 1. Basmati Rice
INSERT INTO products (name, description, category_id, image_url, rating, is_featured, is_active)
VALUES ('Premium Basmati Rice', 'Long grain aromatic basmati rice', 'e2ad8385-d746-4726-b58d-878ae2936c68', 'https://images.unsplash.com/photo-1586201375761-83865001e31c', 4.5, true, true)
RETURNING id;

-- Add variants (replace 'product-id' with the returned id)
INSERT INTO product_variants (product_id, weight, unit, price, original_price, stock_quantity, is_default, sku)
VALUES 
  ((SELECT id FROM products WHERE name = 'Premium Basmati Rice'), 1, 'kg', 5.99, 7.99, 100, true, 'RICE-1KG'),
  ((SELECT id FROM products WHERE name = 'Premium Basmati Rice'), 5, 'kg', 28.99, 35.99, 50, false, 'RICE-5KG'),
  ((SELECT id FROM products WHERE name = 'Premium Basmati Rice'), 10, 'kg', 55.99, 68.99, 25, false, 'RICE-10KG');

-- 2. Fresh Milk
INSERT INTO products (name, description, category_id, image_url, rating, is_featured, is_active)
VALUES ('Fresh Full Cream Milk', 'Farm fresh full cream milk', '1cd6f3c4-2bec-43c3-b085-5e5f6f634e57', 'https://images.unsplash.com/photo-1550583724-b2692b85b150', 4.7, true, true)
RETURNING id;

INSERT INTO product_variants (product_id, weight, unit, price, original_price, stock_quantity, is_default, sku)
VALUES 
  ((SELECT id FROM products WHERE name = 'Fresh Full Cream Milk'), 500, 'ml', 1.99, 2.49, 200, true, 'MILK-500ML'),
  ((SELECT id FROM products WHERE name = 'Fresh Full Cream Milk'), 1, 'l', 3.49, 3.99, 150, false, 'MILK-1L'),
  ((SELECT id FROM products WHERE name = 'Fresh Full Cream Milk'), 2, 'l', 6.49, 7.49, 80, false, 'MILK-2L');

-- 3. Organic Eggs
INSERT INTO products (name, description, category_id, image_url, rating, is_featured, is_active)
VALUES ('Organic Free Range Eggs', 'Farm fresh organic eggs', '1cd6f3c4-2bec-43c3-b085-5e5f6f634e57', 'https://images.unsplash.com/photo-1582722872445-44dc5f7e3c8f', 4.6, true, true)
RETURNING id;

INSERT INTO product_variants (product_id, weight, unit, price, original_price, stock_quantity, is_default, sku)
VALUES 
  ((SELECT id FROM products WHERE name = 'Organic Free Range Eggs'), 6, 'pc', 3.99, 4.99, 120, true, 'EGG-6PC'),
  ((SELECT id FROM products WHERE name = 'Organic Free Range Eggs'), 12, 'pc', 7.49, 8.99, 80, false, 'EGG-12PC'),
  ((SELECT id FROM products WHERE name = 'Organic Free Range Eggs'), 30, 'pc', 17.99, 21.99, 40, false, 'EGG-30PC');

-- 4. Fresh Tomatoes
INSERT INTO products (name, description, category_id, image_url, rating, is_featured, is_active)
VALUES ('Fresh Red Tomatoes', 'Locally sourced fresh tomatoes', 'd5686831-13de-41a2-aef5-6521fb632c96', 'https://images.unsplash.com/photo-1546470427-e26264be0b0d', 4.3, false, true)
RETURNING id;

INSERT INTO product_variants (product_id, weight, unit, price, original_price, stock_quantity, is_default, sku)
VALUES 
  ((SELECT id FROM products WHERE name = 'Fresh Red Tomatoes'), 500, 'g', 2.49, 2.99, 150, true, 'TOM-500G'),
  ((SELECT id FROM products WHERE name = 'Fresh Red Tomatoes'), 1, 'kg', 4.49, 5.49, 100, false, 'TOM-1KG'),
  ((SELECT id FROM products WHERE name = 'Fresh Red Tomatoes'), 2, 'kg', 8.49, 10.49, 60, false, 'TOM-2KG');

-- 5. Orange Juice
INSERT INTO products (name, description, category_id, image_url, rating, is_featured, is_active)
VALUES ('Freshly Squeezed Orange Juice', '100% pure orange juice', 'a4285e10-e4e7-4d97-b373-4f21e14bad72', 'https://images.unsplash.com/photo-1600271886742-f049cd451bba', 4.8, true, true)
RETURNING id;

INSERT INTO product_variants (product_id, weight, unit, price, original_price, stock_quantity, is_default, sku)
VALUES 
  ((SELECT id FROM products WHERE name = 'Freshly Squeezed Orange Juice'), 250, 'ml', 2.99, 3.49, 100, true, 'OJ-250ML'),
  ((SELECT id FROM products WHERE name = 'Freshly Squeezed Orange Juice'), 500, 'ml', 4.99, 5.99, 80, false, 'OJ-500ML'),
  ((SELECT id FROM products WHERE name = 'Freshly Squeezed Orange Juice'), 1, 'l', 8.99, 10.49, 50, false, 'OJ-1L');

-- 6. Whole Wheat Bread
INSERT INTO products (name, description, category_id, image_url, rating, is_featured, is_active)
VALUES ('100% Whole Wheat Bread', 'Soft and nutritious whole wheat bread', '6c2bc401-8259-44c8-b063-8636ff4d5656', 'https://images.unsplash.com/photo-1509440159596-0249088772ff', 4.4, false, true)
RETURNING id;

INSERT INTO product_variants (product_id, weight, unit, price, original_price, stock_quantity, is_default, sku)
VALUES 
  ((SELECT id FROM products WHERE name = '100% Whole Wheat Bread'), 400, 'g', 2.49, 2.99, 80, true, 'BREAD-400G'),
  ((SELECT id FROM products WHERE name = '100% Whole Wheat Bread'), 800, 'g', 4.49, 5.49, 50, false, 'BREAD-800G');

-- 7. Peanut Butter
INSERT INTO products (name, description, category_id, image_url, rating, is_featured, is_active)
VALUES ('Creamy Peanut Butter', 'Natural creamy peanut butter', '22543779-6898-4c55-84c6-cfbd0ce3b413', 'https://images.unsplash.com/photo-1607623488938-b46e79943070', 4.6, false, true)
RETURNING id;

INSERT INTO product_variants (product_id, weight, unit, price, original_price, stock_quantity, is_default, sku)
VALUES 
  ((SELECT id FROM products WHERE name = 'Creamy Peanut Butter'), 340, 'g', 4.99, 5.99, 90, true, 'PB-340G'),
  ((SELECT id FROM products WHERE name = 'Creamy Peanut Butter'), 510, 'g', 6.99, 8.49, 60, false, 'PB-510G'),
  ((SELECT id FROM products WHERE name = 'Creamy Peanut Butter'), 1, 'kg', 12.99, 15.99, 30, false, 'PB-1KG');

-- 8. Potato Chips
INSERT INTO products (name, description, category_id, image_url, rating, is_featured, is_active)
VALUES ('Crispy Potato Chips', 'Salted potato chips', '14446517-cf2b-4d75-9659-43b6ac754e88', 'https://images.unsplash.com/photo-1566478989037-eec170784d0b', 4.2, false, true)
RETURNING id;

INSERT INTO product_variants (product_id, weight, unit, price, original_price, stock_quantity, is_default, sku)
VALUES 
  ((SELECT id FROM products WHERE name = 'Crispy Potato Chips'), 50, 'g', 1.49, 1.99, 200, true, 'CHIPS-50G'),
  ((SELECT id FROM products WHERE name = 'Crispy Potato Chips'), 150, 'g', 3.49, 4.49, 120, false, 'CHIPS-150G'),
  ((SELECT id FROM products WHERE name = 'Crispy Potato Chips'), 300, 'g', 5.99, 7.49, 80, false, 'CHIPS-300G');

-- 9. Green Tea
INSERT INTO products (name, description, category_id, image_url, rating, is_featured, is_active)
VALUES ('Organic Green Tea', 'Premium organic green tea leaves', '424e4638-266c-4271-936b-cc7b10674550', 'https://images.unsplash.com/photo-1556679343-c7306c1976bc', 4.7, true, true)
RETURNING id;

INSERT INTO product_variants (product_id, weight, unit, price, original_price, stock_quantity, is_default, sku)
VALUES 
  ((SELECT id FROM products WHERE name = 'Organic Green Tea'), 25, 'pc', 4.99, 5.99, 100, true, 'TEA-25PC'),
  ((SELECT id FROM products WHERE name = 'Organic Green Tea'), 50, 'pc', 8.99, 10.99, 70, false, 'TEA-50PC'),
  ((SELECT id FROM products WHERE name = 'Organic Green Tea'), 100, 'pc', 16.99, 19.99, 40, false, 'TEA-100PC');

-- 10. Dark Chocolate
INSERT INTO products (name, description, category_id, image_url, rating, is_featured, is_active)
VALUES ('70% Dark Chocolate', 'Rich and smooth dark chocolate', 'ffa76e17-98f5-4591-8bb2-d74b7eb82390', 'https://images.unsplash.com/photo-1511381939415-e44015466834', 4.8, true, true)
RETURNING id;

INSERT INTO product_variants (product_id, weight, unit, price, original_price, stock_quantity, is_default, sku)
VALUES 
  ((SELECT id FROM products WHERE name = '70% Dark Chocolate'), 100, 'g', 3.99, 4.99, 150, true, 'CHOC-100G'),
  ((SELECT id FROM products WHERE name = '70% Dark Chocolate'), 200, 'g', 7.49, 8.99, 100, false, 'CHOC-200G'),
  ((SELECT id FROM products WHERE name = '70% Dark Chocolate'), 500, 'g', 17.99, 21.99, 50, false, 'CHOC-500G');

-- 11. Olive Oil
INSERT INTO products (name, description, category_id, image_url, rating, is_featured, is_active)
VALUES ('Extra Virgin Olive Oil', 'Cold pressed extra virgin olive oil', '29cb1a04-16f4-4d33-b570-00eaa39ec966', 'https://images.unsplash.com/photo-1474979266404-7eaacbcd87c5', 4.9, true, true)
RETURNING id;

INSERT INTO product_variants (product_id, weight, unit, price, original_price, stock_quantity, is_default, sku)
VALUES 
  ((SELECT id FROM products WHERE name = 'Extra Virgin Olive Oil'), 250, 'ml', 8.99, 10.99, 80, true, 'OIL-250ML'),
  ((SELECT id FROM products WHERE name = 'Extra Virgin Olive Oil'), 500, 'ml', 15.99, 18.99, 60, false, 'OIL-500ML'),
  ((SELECT id FROM products WHERE name = 'Extra Virgin Olive Oil'), 1, 'l', 29.99, 35.99, 40, false, 'OIL-1L');

-- 12. Bananas
INSERT INTO products (name, description, category_id, image_url, rating, is_featured, is_active)
VALUES ('Fresh Bananas', 'Ripe yellow bananas', 'd5686831-13de-41a2-aef5-6521fb632c96', 'https://images.unsplash.com/photo-1571771894821-ce9b6c11b08e', 4.3, false, true)
RETURNING id;

INSERT INTO product_variants (product_id, weight, unit, price, original_price, stock_quantity, is_default, sku)
VALUES 
  ((SELECT id FROM products WHERE name = 'Fresh Bananas'), 6, 'pc', 2.99, 3.49, 200, true, 'BAN-6PC'),
  ((SELECT id FROM products WHERE name = 'Fresh Bananas'), 12, 'pc', 5.49, 6.49, 150, false, 'BAN-12PC'),
  ((SELECT id FROM products WHERE name = 'Fresh Bananas'), 1, 'dozen', 5.49, 6.49, 150, false, 'BAN-DOZ');

-- 13. Almonds
INSERT INTO products (name, description, category_id, image_url, rating, is_featured, is_active)
VALUES ('Raw Almonds', 'Premium quality raw almonds', '14446517-cf2b-4d75-9659-43b6ac754e88', 'https://images.unsplash.com/photo-1508747703725-719777637510', 4.6, false, true)
RETURNING id;

INSERT INTO product_variants (product_id, weight, unit, price, original_price, stock_quantity, is_default, sku)
VALUES 
  ((SELECT id FROM products WHERE name = 'Raw Almonds'), 200, 'g', 6.99, 8.49, 100, true, 'ALM-200G'),
  ((SELECT id FROM products WHERE name = 'Raw Almonds'), 500, 'g', 15.99, 18.99, 70, false, 'ALM-500G'),
  ((SELECT id FROM products WHERE name = 'Raw Almonds'), 1, 'kg', 29.99, 35.99, 40, false, 'ALM-1KG');

-- 14. Greek Yogurt
INSERT INTO products (name, description, category_id, image_url, rating, is_featured, is_active)
VALUES ('Greek Yogurt Plain', 'Thick and creamy Greek yogurt', '1cd6f3c4-2bec-43c3-b085-5e5f6f634e57', 'https://images.unsplash.com/photo-1488477181946-6428a0291777', 4.7, true, true)
RETURNING id;

INSERT INTO product_variants (product_id, weight, unit, price, original_price, stock_quantity, is_default, sku)
VALUES 
  ((SELECT id FROM products WHERE name = 'Greek Yogurt Plain'), 200, 'g', 2.99, 3.49, 120, true, 'YOG-200G'),
  ((SELECT id FROM products WHERE name = 'Greek Yogurt Plain'), 500, 'g', 6.49, 7.99, 80, false, 'YOG-500G'),
  ((SELECT id FROM products WHERE name = 'Greek Yogurt Plain'), 1, 'kg', 11.99, 14.99, 50, false, 'YOG-1KG');

-- 15. Pasta
INSERT INTO products (name, description, category_id, image_url, rating, is_featured, is_active)
VALUES ('Penne Pasta', 'Durum wheat penne pasta', '6dae1c33-d005-4863-855c-cb7ce6312f55', 'https://images.unsplash.com/photo-1551462147-37c8e3812e7d', 4.4, false, true)
RETURNING id;

INSERT INTO product_variants (product_id, weight, unit, price, original_price, stock_quantity, is_default, sku)
VALUES 
  ((SELECT id FROM products WHERE name = 'Penne Pasta'), 500, 'g', 2.99, 3.49, 150, true, 'PASTA-500G'),
  ((SELECT id FROM products WHERE name = 'Penne Pasta'), 1, 'kg', 5.49, 6.49, 100, false, 'PASTA-1KG'),
  ((SELECT id FROM products WHERE name = 'Penne Pasta'), 2, 'kg', 9.99, 11.99, 60, false, 'PASTA-2KG');

-- 16. Coffee Beans
INSERT INTO products (name, description, category_id, image_url, rating, is_featured, is_active)
VALUES ('Arabica Coffee Beans', 'Premium roasted arabica beans', '424e4638-266c-4271-936b-cc7b10674550', 'https://images.unsplash.com/photo-1559056199-641a0ac8b55e', 4.8, true, true)
RETURNING id;

INSERT INTO product_variants (product_id, weight, unit, price, original_price, stock_quantity, is_default, sku)
VALUES 
  ((SELECT id FROM products WHERE name = 'Arabica Coffee Beans'), 250, 'g', 9.99, 11.99, 90, true, 'COFFEE-250G'),
  ((SELECT id FROM products WHERE name = 'Arabica Coffee Beans'), 500, 'g', 18.99, 21.99, 60, false, 'COFFEE-500G'),
  ((SELECT id FROM products WHERE name = 'Arabica Coffee Beans'), 1, 'kg', 35.99, 42.99, 30, false, 'COFFEE-1KG');

-- 17. Honey
INSERT INTO products (name, description, category_id, image_url, rating, is_featured, is_active)
VALUES ('Pure Organic Honey', '100% pure organic honey', '27d7a14e-4692-4cef-83b3-baa197422c3e', 'https://images.unsplash.com/photo-1587049352846-4a222e784769', 4.9, true, true)
RETURNING id;

INSERT INTO product_variants (product_id, weight, unit, price, original_price, stock_quantity, is_default, sku)
VALUES 
  ((SELECT id FROM products WHERE name = 'Pure Organic Honey'), 250, 'g', 7.99, 9.49, 100, true, 'HON-250G'),
  ((SELECT id FROM products WHERE name = 'Pure Organic Honey'), 500, 'g', 14.99, 17.99, 70, false, 'HON-500G'),
  ((SELECT id FROM products WHERE name = 'Pure Organic Honey'), 1, 'kg', 27.99, 32.99, 40, false, 'HON-1KG');

-- 18. Mineral Water
INSERT INTO products (name, description, category_id, image_url, rating, is_featured, is_active)
VALUES ('Natural Mineral Water', 'Pure natural mineral water', 'a4285e10-e4e7-4d97-b373-4f21e14bad72', 'https://images.unsplash.com/photo-1548839140-29a749e1cf4d', 4.5, false, true)
RETURNING id;

INSERT INTO product_variants (product_id, weight, unit, price, original_price, stock_quantity, is_default, sku)
VALUES 
  ((SELECT id FROM products WHERE name = 'Natural Mineral Water'), 500, 'ml', 0.99, 1.49, 300, true, 'WATER-500ML'),
  ((SELECT id FROM products WHERE name = 'Natural Mineral Water'), 1, 'l', 1.49, 1.99, 200, false, 'WATER-1L'),
  ((SELECT id FROM products WHERE name = 'Natural Mineral Water'), 5, 'l', 4.99, 5.99, 100, false, 'WATER-5L');

-- 19. Cheddar Cheese
INSERT INTO products (name, description, category_id, image_url, rating, is_featured, is_active)
VALUES ('Sharp Cheddar Cheese', 'Aged sharp cheddar cheese', '1cd6f3c4-2bec-43c3-b085-5e5f6f634e57', 'https://images.unsplash.com/photo-1486297678162-eb2a19b0a32d', 4.7, true, true)
RETURNING id;

INSERT INTO product_variants (product_id, weight, unit, price, original_price, stock_quantity, is_default, sku)
VALUES 
  ((SELECT id FROM products WHERE name = 'Sharp Cheddar Cheese'), 200, 'g', 4.99, 5.99, 80, true, 'CHE-200G'),
  ((SELECT id FROM products WHERE name = 'Sharp Cheddar Cheese'), 500, 'g', 11.99, 13.99, 60, false, 'CHE-500G'),
  ((SELECT id FROM products WHERE name = 'Sharp Cheddar Cheese'), 1, 'kg', 22.99, 26.99, 30, false, 'CHE-1KG');

-- 20. Oats
INSERT INTO products (name, description, category_id, image_url, rating, is_featured, is_active)
VALUES ('Rolled Oats', 'Organic rolled oats', '6dae1c33-d005-4863-855c-cb7ce6312f55', 'https://images.unsplash.com/photo-1517673132405-a56a62b18caf', 4.6, false, true)
RETURNING id;

INSERT INTO product_variants (product_id, weight, unit, price, original_price, stock_quantity, is_default, sku)
VALUES 
  ((SELECT id FROM products WHERE name = 'Rolled Oats'), 500, 'g', 3.99, 4.99, 120, true, 'OATS-500G'),
  ((SELECT id FROM products WHERE name = 'Rolled Oats'), 1, 'kg', 7.49, 8.99, 80, false, 'OATS-1KG'),
  ((SELECT id FROM products WHERE name = 'Rolled Oats'), 2, 'kg', 13.99, 16.99, 50, false, 'OATS-2KG');

-- PRODUCTS INSERTED SUCCESSFULLY!
-- Total: 20 products with 2-3 variants each (60 total variants)
