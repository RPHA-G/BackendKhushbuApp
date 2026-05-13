-- Migration: Create Products with Variants Feature from Scratch
-- Execute this entire SQL file in your Supabase SQL Editor
-- WARNING: This will DROP existing products table and recreate with variants support

-- STEP 1: Drop existing tables (CASCADE will drop all dependent tables)
DROP TABLE IF EXISTS product_variants CASCADE;
DROP TABLE IF EXISTS products CASCADE;

-- STEP 2: Create ENUM type for units
DO $$ BEGIN
    CREATE TYPE unit AS ENUM ('g', 'kg', 'ml', 'l', 'pc', 'dozen', 'pack', 'box');
EXCEPTION
    WHEN duplicate_object THEN null;
END $$;

-- STEP 3: Create products table with complete schema
CREATE TABLE products (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  description TEXT,
  category_id UUID REFERENCES categories(id) ON DELETE SET NULL,
  subcategory_id UUID REFERENCES subcategories(id) ON DELETE SET NULL,
  image_url TEXT,
  rating DECIMAL(3, 2) DEFAULT 0,
  is_featured BOOLEAN DEFAULT false,
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- STEP 4: Create product_variants table
CREATE TABLE product_variants (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  product_id UUID NOT NULL REFERENCES products(id) ON DELETE CASCADE,
  weight DECIMAL(10, 2) NOT NULL,
  unit unit NOT NULL DEFAULT 'pc',
  price DECIMAL(10, 2) NOT NULL,
  original_price DECIMAL(10, 2),
  stock_quantity INTEGER DEFAULT 0,
  sku VARCHAR(100),
  is_default BOOLEAN DEFAULT false,
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  CONSTRAINT unique_product_weight_unit UNIQUE(product_id, weight, unit)
);

-- STEP 5: Create indexes for products
CREATE INDEX idx_products_category ON products(category_id);
CREATE INDEX idx_products_subcategory ON products(subcategory_id);
CREATE INDEX idx_products_active ON products(is_active);
CREATE INDEX idx_products_featured ON products(is_featured);

-- STEP 6: Create indexes for product_variants
CREATE INDEX idx_product_variants_product ON product_variants(product_id);
CREATE INDEX idx_product_variants_active ON product_variants(is_active);
CREATE INDEX idx_product_variants_default ON product_variants(is_default);
CREATE INDEX idx_product_variants_sku ON product_variants(sku);

-- STEP 7: Create updated_at triggers
CREATE TRIGGER update_products_updated_at BEFORE UPDATE ON products
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_product_variants_updated_at BEFORE UPDATE ON product_variants
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- STEP 8: Create helper function to get default variant price
CREATE OR REPLACE FUNCTION get_product_default_price(prod_id UUID)
RETURNS DECIMAL AS $$
DECLARE
    default_price DECIMAL;
BEGIN
    SELECT price INTO default_price
    FROM product_variants
    WHERE product_id = prod_id AND is_default = true AND is_active = true
    LIMIT 1;
    
    IF default_price IS NULL THEN
        SELECT price INTO default_price
        FROM product_variants
        WHERE product_id = prod_id AND is_active = true
        ORDER BY price ASC
        LIMIT 1;
    END IF;
    
    RETURN COALESCE(default_price, 0);
END;
$$ LANGUAGE plpgsql;

-- STEP 9: Create helper function to get product with all variants
CREATE OR REPLACE FUNCTION get_product_with_variants(prod_id UUID)
RETURNS JSON AS $$
DECLARE
    result JSON;
BEGIN
    SELECT json_build_object(
        'id', p.id,
        'name', p.name,
        'description', p.description,
        'category_id', p.category_id,
        'subcategory_id', p.subcategory_id,
        'image_url', p.image_url,
        'rating', p.rating,
        'is_featured', p.is_featured,
        'is_active', p.is_active,
        'created_at', p.created_at,
        'updated_at', p.updated_at,
        'variants', (
            SELECT json_agg(json_build_object(
                'id', pv.id,
                'weight', pv.weight,
                'unit', pv.unit,
                'price', pv.price,
                'original_price', pv.original_price,
                'stock_quantity', pv.stock_quantity,
                'sku', pv.sku,
                'is_default', pv.is_default,
                'is_active', pv.is_active
            ))
            FROM product_variants pv
            WHERE pv.product_id = p.id AND pv.is_active = true
            ORDER BY pv.is_default DESC, pv.price ASC
        )
    ) INTO result
    FROM products p
    WHERE p.id = prod_id;
    
    RETURN result;
END;
$$ LANGUAGE plpgsql;

-- STEP 10: Update cart_items to support variants
ALTER TABLE cart_items ADD COLUMN IF NOT EXISTS variant_id UUID REFERENCES product_variants(id) ON DELETE CASCADE;
CREATE INDEX IF NOT EXISTS idx_cart_items_variant ON cart_items(variant_id);

ALTER TABLE cart_items DROP CONSTRAINT IF EXISTS cart_items_user_id_product_id_key;
ALTER TABLE cart_items DROP CONSTRAINT IF EXISTS cart_items_user_product_variant_unique;
ALTER TABLE cart_items ADD CONSTRAINT cart_items_user_product_variant_unique 
    UNIQUE(user_id, product_id, variant_id);

-- STEP 11: Update order_items to support variants
ALTER TABLE order_items ADD COLUMN IF NOT EXISTS variant_id UUID REFERENCES product_variants(id) ON DELETE SET NULL;
ALTER TABLE order_items ADD COLUMN IF NOT EXISTS variant_weight DECIMAL(10, 2);
ALTER TABLE order_items ADD COLUMN IF NOT EXISTS variant_unit VARCHAR(20);
CREATE INDEX IF NOT EXISTS idx_order_items_variant ON order_items(variant_id);

-- STEP 12: Enable RLS for products
ALTER TABLE products ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Anyone can view active products" ON products;
CREATE POLICY "Anyone can view active products" ON products
    FOR SELECT USING (is_active = true);

DROP POLICY IF EXISTS "Admins can manage products" ON products;
CREATE POLICY "Admins can manage products" ON products
    FOR ALL USING (
        EXISTS (
            SELECT 1 FROM users 
            WHERE users.id::text = auth.uid()::text 
            AND users.role = 'admin'
        )
    );

-- STEP 13: Enable RLS for product_variants
ALTER TABLE product_variants ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Anyone can view active product variants" ON product_variants;
CREATE POLICY "Anyone can view active product variants" ON product_variants
    FOR SELECT USING (is_active = true);

DROP POLICY IF EXISTS "Admins can manage product variants" ON product_variants;
CREATE POLICY "Admins can manage product variants" ON product_variants
    FOR ALL USING (
        EXISTS (
            SELECT 1 FROM users 
            WHERE users.id::text = auth.uid()::text 
            AND users.role = 'admin'
        )
    );

-- STEP 14: Create view for products with default variant info
CREATE OR REPLACE VIEW products_with_default_variant AS
SELECT 
    p.id,
    p.name,
    p.description,
    p.category_id,
    p.subcategory_id,
    p.image_url,
    p.rating,
    p.is_featured,
    p.is_active,
    p.created_at,
    p.updated_at,
    pv.id as default_variant_id,
    pv.weight as default_weight,
    pv.unit as default_unit,
    pv.price as default_price,
    pv.original_price as default_original_price,
    pv.stock_quantity as default_stock_quantity,
    pv.sku as default_sku
FROM products p
LEFT JOIN product_variants pv ON p.id = pv.product_id AND pv.is_default = true AND pv.is_active = true;

-- MIGRATION COMPLETED SUCCESSFULLY!
-- 
-- USAGE EXAMPLES:
-- 
-- 1. Insert a product with variants:
--    INSERT INTO products (name, description, category_id, image_url)
--    VALUES ('Premium Rice', 'High quality basmati rice', 'category-uuid', 'image-url')
--    RETURNING id;
--    
--    INSERT INTO product_variants (product_id, weight, unit, price, stock_quantity, is_default)
--    VALUES 
--      ('product-uuid', 1, 'kg', 10.99, 100, true),
--      ('product-uuid', 5, 'kg', 48.99, 50, false),
--      ('product-uuid', 10, 'kg', 95.99, 20, false);
--
-- 2. Query products with default variant:
--    SELECT * FROM products_with_default_variant WHERE is_active = true;
--
-- 3. Get product with all variants:
--    SELECT * FROM get_product_with_variants('product-uuid');

