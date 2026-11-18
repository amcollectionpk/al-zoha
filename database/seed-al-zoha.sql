-- ============================================================================
-- AL-ZOHA — Product Seed (8 test products)
-- Run AFTER database/schema.sql:  psql "$DATABASE_URL" -f database/seed-al-zoha.sql
-- (Uppcoder par ye file scripts/init-db.js se build ke waqt khud chal jati hai.)
-- Idempotent: safe to run more than once (existing slugs are skipped/updated).
-- Schema-matched: products.stock_qty + products.image_url seedha products
-- table mein jate hain (server.js yehi columns parhta/likhta hai), aur har
-- product ki photo product_images mein bhi record hoti hai.
-- Photos are served by the website itself from public/assets/.
-- Prices below are the SELLING prices. No discount percent is shown on the
-- store (discount_price is NULL for all 8 products).
-- ============================================================================
BEGIN;

INSERT INTO categories (name, slug, description, image_url, sort_order) VALUES
    ('Men''s Watches', 'mens-watches', 'Watches at Al-Zoha — Men''s Watches.', '/assets/watches/wheel-watch-1.jpg', 1)
ON CONFLICT (slug) DO UPDATE SET image_url = EXCLUDED.image_url, description = EXCLUDED.description, sort_order = EXCLUDED.sort_order;

INSERT INTO categories (name, slug, description, image_url, sort_order) VALUES
    ('Women''s Watches', 'womens-watches', 'Watches at Al-Zoha — Women''s Watches.', '/assets/watches/digital-bracelet-1.jpg', 2)
ON CONFLICT (slug) DO UPDATE SET image_url = EXCLUDED.image_url, description = EXCLUDED.description, sort_order = EXCLUDED.sort_order;

INSERT INTO categories (name, slug, description, image_url, sort_order) VALUES
    ('Hoodies / Track Suits', 'hoodies', 'Track suits and hoodies at Al-Zoha.', '/assets/hoodies/bomber-track-black-1.jpg', 3)
ON CONFLICT (slug) DO UPDATE SET image_url = EXCLUDED.image_url, description = EXCLUDED.description, sort_order = EXCLUDED.sort_order;

-- 1) Men's Black Wheel Watch (Green Accent) — Rs. 2,499
INSERT INTO products (category_id, name, slug, sku, description, price, discount_price, image_url, stock_qty, is_featured, is_active)
SELECT id, 'Men''s Black Wheel Watch (Green Accent)', 'mens-black-wheel-watch-green-accent', 'AZ-W-001', 'Men''s Black Wheel Watch with Green Accent — a stylish wristwatch, shown exactly as pictured. Cash on Delivery available across Pakistan; delivery Rs. 200 (free on orders of Rs. 5,000 or more).', 2499, NULL, '/assets/watches/wheel-watch-1.jpg', 10, true, true FROM categories WHERE slug = 'mens-watches'
ON CONFLICT (slug) DO UPDATE SET category_id = EXCLUDED.category_id, price = EXCLUDED.price, discount_price = EXCLUDED.discount_price, image_url = EXCLUDED.image_url, description = EXCLUDED.description, is_featured = EXCLUDED.is_featured;
INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, '/assets/watches/wheel-watch-1.jpg', 'Men''s Black Wheel Watch (Green Accent)', 0, true FROM products WHERE slug = 'mens-black-wheel-watch-green-accent'
AND NOT EXISTS (SELECT 1 FROM product_images pi WHERE pi.product_id = products.id AND pi.image_url = '/assets/watches/wheel-watch-1.jpg');

-- 2) Women's Digital Bracelet Watch — Rs. 1,999 (Rose Gold / Black / Gold / Silver)
INSERT INTO products (category_id, name, slug, sku, description, price, discount_price, image_url, stock_qty, is_featured, is_active)
SELECT id, 'Women''s Digital Bracelet Watch', 'womens-digital-bracelet-watch', 'AZ-W-002', 'Women''s Digital Bracelet Watch — available in Rose Gold, Black, Gold and Silver, shown exactly as pictured. Cash on Delivery available across Pakistan; delivery Rs. 200 (free on orders of Rs. 5,000 or more).', 1999, NULL, '/assets/watches/digital-bracelet-1.jpg', 10, true, true FROM categories WHERE slug = 'womens-watches'
ON CONFLICT (slug) DO UPDATE SET category_id = EXCLUDED.category_id, price = EXCLUDED.price, discount_price = EXCLUDED.discount_price, image_url = EXCLUDED.image_url, description = EXCLUDED.description, is_featured = EXCLUDED.is_featured;
INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, '/assets/watches/digital-bracelet-1.jpg', 'Women''s Digital Bracelet Watch', 0, true FROM products WHERE slug = 'womens-digital-bracelet-watch'
AND NOT EXISTS (SELECT 1 FROM product_images pi WHERE pi.product_id = products.id AND pi.image_url = '/assets/watches/digital-bracelet-1.jpg');

-- 3) Men's Bomber Zip Track Suit (Black + Grey) — Rs. 2,999
INSERT INTO products (category_id, name, slug, sku, description, price, discount_price, image_url, stock_qty, is_featured, is_active)
SELECT id, 'Men''s Bomber Zip Track Suit (Black + Grey)', 'mens-bomber-zip-hoodie-track-suit-black-grey', 'AZ-H-001', 'Men''s Bomber Zip Track Suit in Black and Grey — winter warm, shown exactly as pictured. Sizes M / L / XL / XXL. Cash on Delivery available across Pakistan; delivery Rs. 200 (free on orders of Rs. 5,000 or more).', 2999, NULL, '/assets/hoodies/bomber-track-black-1.jpg', 10, true, true FROM categories WHERE slug = 'hoodies'
ON CONFLICT (slug) DO UPDATE SET category_id = EXCLUDED.category_id, price = EXCLUDED.price, discount_price = EXCLUDED.discount_price, image_url = EXCLUDED.image_url, description = EXCLUDED.description, is_featured = EXCLUDED.is_featured;
INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, '/assets/hoodies/bomber-track-black-1.jpg', 'Men''s Bomber Zip Track Suit (Black)', 0, true FROM products WHERE slug = 'mens-bomber-zip-hoodie-track-suit-black-grey'
AND NOT EXISTS (SELECT 1 FROM product_images pi WHERE pi.product_id = products.id AND pi.image_url = '/assets/hoodies/bomber-track-black-1.jpg');
INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, '/assets/hoodies/bomber-track-grey-1.jpg', 'Men''s Bomber Zip Track Suit (Grey)', 1, false FROM products WHERE slug = 'mens-bomber-zip-hoodie-track-suit-black-grey'
AND NOT EXISTS (SELECT 1 FROM product_images pi WHERE pi.product_id = products.id AND pi.image_url = '/assets/hoodies/bomber-track-grey-1.jpg');

-- 4) Men's Brown Winter Track Suit — Rs. 2,999
INSERT INTO products (category_id, name, slug, sku, description, price, discount_price, image_url, stock_qty, is_featured, is_active)
SELECT id, 'Men''s Brown Winter Track Suit', 'mens-brown-winter-hoodie-track-suit', 'AZ-H-002', 'Men''s Brown Winter Track Suit — warm winter wear, shown exactly as pictured. Sizes M / L / XL / XXL. Cash on Delivery available across Pakistan; delivery Rs. 200 (free on orders of Rs. 5,000 or more).', 2999, NULL, '/assets/hoodies/brown-track-1.jpg', 10, true, true FROM categories WHERE slug = 'hoodies'
ON CONFLICT (slug) DO UPDATE SET category_id = EXCLUDED.category_id, price = EXCLUDED.price, discount_price = EXCLUDED.discount_price, image_url = EXCLUDED.image_url, description = EXCLUDED.description, is_featured = EXCLUDED.is_featured;
INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, '/assets/hoodies/brown-track-1.jpg', 'Men''s Brown Winter Track Suit', 0, true FROM products WHERE slug = 'mens-brown-winter-hoodie-track-suit'
AND NOT EXISTS (SELECT 1 FROM product_images pi WHERE pi.product_id = products.id AND pi.image_url = '/assets/hoodies/brown-track-1.jpg');

-- 5) Men's Color Block Hoodie Track Suit (Red + Tan) — Rs. 2,999
INSERT INTO products (category_id, name, slug, sku, description, price, discount_price, image_url, stock_qty, is_featured, is_active)
SELECT id, 'Men''s Color Block Hoodie Track Suit (Red + Tan)', 'mens-color-block-hoodie-track-suit-red-tan', 'AZ-H-003', 'Men''s Color Block Hoodie Track Suit in Red and Tan — shown exactly as pictured. Sizes M / L / XL / XXL. Cash on Delivery available across Pakistan; delivery Rs. 200 (free on orders of Rs. 5,000 or more).', 2999, NULL, '/assets/hoodies/colorblock-track-red-1.jpg', 10, true, true FROM categories WHERE slug = 'hoodies'
ON CONFLICT (slug) DO UPDATE SET category_id = EXCLUDED.category_id, price = EXCLUDED.price, discount_price = EXCLUDED.discount_price, image_url = EXCLUDED.image_url, description = EXCLUDED.description, is_featured = EXCLUDED.is_featured;
INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, '/assets/hoodies/colorblock-track-red-1.jpg', 'Men''s Color Block Hoodie Track Suit (Red)', 0, true FROM products WHERE slug = 'mens-color-block-hoodie-track-suit-red-tan'
AND NOT EXISTS (SELECT 1 FROM product_images pi WHERE pi.product_id = products.id AND pi.image_url = '/assets/hoodies/colorblock-track-red-1.jpg');
INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, '/assets/hoodies/colorblock-track-tan-1.jpg', 'Men''s Color Block Hoodie Track Suit (Tan)', 1, false FROM products WHERE slug = 'mens-color-block-hoodie-track-suit-red-tan'
AND NOT EXISTS (SELECT 1 FROM product_images pi WHERE pi.product_id = products.id AND pi.image_url = '/assets/hoodies/colorblock-track-tan-1.jpg');

-- 6) Men's Silver Nautilus Watch — Rs. 2,999
INSERT INTO products (category_id, name, slug, sku, description, price, discount_price, image_url, stock_qty, is_featured, is_active)
SELECT id, 'Men''s Silver Nautilus Watch', 'mens-silver-nautilus-watch', 'AZ-W-003', 'Men''s Silver Nautilus Watch — shown exactly as pictured. Cash on Delivery available across Pakistan; delivery Rs. 200 (free on orders of Rs. 5,000 or more).', 2999, NULL, '/assets/watches/nautilus-1.jpg', 10, true, true FROM categories WHERE slug = 'mens-watches'
ON CONFLICT (slug) DO UPDATE SET category_id = EXCLUDED.category_id, price = EXCLUDED.price, discount_price = EXCLUDED.discount_price, image_url = EXCLUDED.image_url, description = EXCLUDED.description, is_featured = EXCLUDED.is_featured;
INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, '/assets/watches/nautilus-1.jpg', 'Men''s Silver Nautilus Watch', 0, true FROM products WHERE slug = 'mens-silver-nautilus-watch'
AND NOT EXISTS (SELECT 1 FROM product_images pi WHERE pi.product_id = products.id AND pi.image_url = '/assets/watches/nautilus-1.jpg');

-- 7) Men's LONGBO Silver Watch — Rs. 2,999
INSERT INTO products (category_id, name, slug, sku, description, price, discount_price, image_url, stock_qty, is_featured, is_active)
SELECT id, 'Men''s LONGBO Silver Watch', 'mens-longbo-silver-watch', 'AZ-W-004', 'Men''s LONGBO Silver Watch — shown exactly as pictured. Cash on Delivery available across Pakistan; delivery Rs. 200 (free on orders of Rs. 5,000 or more).', 2999, NULL, '/assets/watches/longbo-1.jpg', 10, true, true FROM categories WHERE slug = 'mens-watches'
ON CONFLICT (slug) DO UPDATE SET category_id = EXCLUDED.category_id, price = EXCLUDED.price, discount_price = EXCLUDED.discount_price, image_url = EXCLUDED.image_url, description = EXCLUDED.description, is_featured = EXCLUDED.is_featured;
INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, '/assets/watches/longbo-1.jpg', 'Men''s LONGBO Silver Watch', 0, true FROM products WHERE slug = 'mens-longbo-silver-watch'
AND NOT EXISTS (SELECT 1 FROM product_images pi WHERE pi.product_id = products.id AND pi.image_url = '/assets/watches/longbo-1.jpg');

-- 8) Men's Black DENVOSI Watch — Rs. 2,499
INSERT INTO products (category_id, name, slug, sku, description, price, discount_price, image_url, stock_qty, is_featured, is_active)
SELECT id, 'Men''s Black DENVOSI Watch', 'mens-black-denvosi-watch', 'AZ-W-005', 'Men''s Black DENVOSI Watch — shown exactly as pictured. Cash on Delivery available across Pakistan; delivery Rs. 200 (free on orders of Rs. 5,000 or more).', 2499, NULL, '/assets/watches/denvosi-1.jpg', 10, true, true FROM categories WHERE slug = 'mens-watches'
ON CONFLICT (slug) DO UPDATE SET category_id = EXCLUDED.category_id, price = EXCLUDED.price, discount_price = EXCLUDED.discount_price, image_url = EXCLUDED.image_url, description = EXCLUDED.description, is_featured = EXCLUDED.is_featured;
INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, '/assets/watches/denvosi-1.jpg', 'Men''s Black DENVOSI Watch', 0, true FROM products WHERE slug = 'mens-black-denvosi-watch'
AND NOT EXISTS (SELECT 1 FROM product_images pi WHERE pi.product_id = products.id AND pi.image_url = '/assets/watches/denvosi-1.jpg');

COMMIT;
