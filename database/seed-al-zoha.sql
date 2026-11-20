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

INSERT INTO categories (name, slug, description, image_url, sort_order) VALUES
    ('Toys', 'toys', 'Toys for kids at Al-Zoha.', '/assets/toys/lcd-tablet-1.jpg', 4)
ON CONFLICT (slug) DO UPDATE SET image_url = EXCLUDED.image_url, description = EXCLUDED.description, sort_order = EXCLUDED.sort_order;

INSERT INTO categories (name, slug, description, image_url, sort_order) VALUES
    ('Dress', 'dress', 'Dresses and night suits at Al-Zoha.', '/assets/dress/penguin-nightsuit-1.jpg', 5)
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

-- ============================================================================
-- TOYS (added 2026-11-20 — real products sent by the user)
-- ============================================================================

-- 9) 6.5" LCD Drawing Tablet for Kids 3-6 Years — Rs. 999
INSERT INTO products (category_id, name, slug, sku, description, price, discount_price, image_url, stock_qty, is_featured, is_active)
SELECT id, '6.5" LCD Drawing Tablet for Kids 3-6 Years', '6-5-inch-lcd-drawing-tablet-for-kids', 'AZ-T-001', 'Looking for a fun, educational, and durable drawing tool for your little one? This premium quality LCD writing tablet is the perfect choice for kids aged 3 to 6, offering hours of creative fun without the mess of traditional art supplies. Designed with a stylish, child-friendly design, it is ideal for home, school, or playtime use.

The tablet is made from high-grade, durable plastic that withstands daily use and rough handling by energetic children. Its 6.5-inch screen is large enough for easy drawing and writing, while the smooth, responsive surface ensures a satisfying doodling experience. The included stylus is easy to grip and perfect for developing fine motor skills.

- 6.5-inch LCD screen for clear, vibrant drawing
- Durable plastic construction for long-lasting use
- Ideal for ages 3 to 6 years
- Comes with one stylus for easy writing and drawing
- Perfect for arts and crafts, school projects, or home play

Material: Plastic. Age: Suitable for 3 - 6 Years old Girls and Boys. Package Includes: 1 x LCD Writing Tablet. Product Code: MZ85420019ZMZMSR. Cash on Delivery available across Pakistan; delivery Rs. 200 (free on orders of Rs. 5,000 or more).', 999, NULL, '/assets/toys/lcd-tablet-1.jpg', 10, true, true FROM categories WHERE slug = 'toys'
ON CONFLICT (slug) DO UPDATE SET category_id = EXCLUDED.category_id, price = EXCLUDED.price, discount_price = EXCLUDED.discount_price, image_url = EXCLUDED.image_url, description = EXCLUDED.description, is_featured = EXCLUDED.is_featured;
INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, '/assets/toys/lcd-tablet-1.jpg', '6.5" LCD Drawing Tablet for Kids 3-6 Years', 0, true FROM products WHERE slug = '6-5-inch-lcd-drawing-tablet-for-kids'
AND NOT EXISTS (SELECT 1 FROM product_images pi WHERE pi.product_id = products.id AND pi.image_url = '/assets/toys/lcd-tablet-1.jpg');

-- 10) HD Projection Flashlight for Kids 90° Rotating Animal Patterns — Rs. 1,099
INSERT INTO products (category_id, name, slug, sku, description, price, discount_price, image_url, stock_qty, is_featured, is_active)
SELECT id, 'HD Projection Flashlight for Kids 90° Rotating Animal Patterns', 'hd-projection-flashlight-for-kids', 'AZ-T-002', 'This adorable HD projection flashlight is the perfect way to turn any room into a magical storytelling zone for your little ones. Designed with soft, rounded edges and made from durable ABS plastic, it is built to withstand the rough-and-tumble play of Pakistani kids without breaking or scratching. The stylish, multicolor design in green, purple, and pink makes it a favorite for birthdays and Christmas gifts. With its 90-degree rotating lens and 8 charming animal patterns, it projects vivid images onto walls or ceilings, helping children develop visual imagination and cognitive skills while having fun.

- Rotating 90-degree projection lens for adjustable focus
- 8 different animal-themed patterns for endless entertainment
- Made from durable, child-safe ABS plastic
- Compact and lightweight design for easy handling
- Perfect for wall or ceiling projection in dark rooms
- Ideal gift for kids aged 3 years and up

Material: ABS Plastic. Color: Green/Purple/Pink. Size: 11.5 x 4.3 cm. Age: 3Y+. Projection distance: 50-150 cm. Product Code: MZ59400000069OEKI. Adult supervision is recommended as this toy may contain small parts that could pose a choking hazard. Cash on Delivery available across Pakistan; delivery Rs. 200 (free on orders of Rs. 5,000 or more).', 1099, NULL, '/assets/toys/flashlight-1.jpg', 10, true, true FROM categories WHERE slug = 'toys'
ON CONFLICT (slug) DO UPDATE SET category_id = EXCLUDED.category_id, price = EXCLUDED.price, discount_price = EXCLUDED.discount_price, image_url = EXCLUDED.image_url, description = EXCLUDED.description, is_featured = EXCLUDED.is_featured;
INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, '/assets/toys/flashlight-1.jpg', 'HD Projection Flashlight for Kids', 0, true FROM products WHERE slug = 'hd-projection-flashlight-for-kids'
AND NOT EXISTS (SELECT 1 FROM product_images pi WHERE pi.product_id = products.id AND pi.image_url = '/assets/toys/flashlight-1.jpg');

-- 11) Wooden ABC Puzzle for Kids Learning & Play — Rs. 999
INSERT INTO products (category_id, name, slug, sku, description, price, discount_price, image_url, stock_qty, is_featured, is_active)
SELECT id, 'Wooden ABC Puzzle for Kids Learning & Play', 'wooden-abc-puzzle-for-kids', 'AZ-T-003', 'Perfect for Pakistani homes, this colorful wooden ABC puzzle helps your child learn letters and numbers while keeping them entertained for hours. Ideal for early learners, it is designed to match local educational needs and is safe for little hands.

Made from premium quality, durable wood, this puzzle withstands daily play and rough handling. Its multicolor design captures attention and encourages visual learning, making it a stylish addition to any child''s playroom.

- Made from 100% natural wood for long-lasting use
- Features capital letters for early literacy
- Multicolor design to boost visual engagement
- Single-piece puzzle for easy storage and play
- Safe, non-toxic material suitable for kids

Material: Wood. Color: Multicolor. Package Includes: 1 x ABC Puzzle. Product Code: MZ55800000036KISS. Adult supervision is recommended due to small parts. Cash on Delivery available across Pakistan; delivery Rs. 200 (free on orders of Rs. 5,000 or more).', 999, NULL, '/assets/toys/abc-puzzle-1.jpg', 10, true, true FROM categories WHERE slug = 'toys'
ON CONFLICT (slug) DO UPDATE SET category_id = EXCLUDED.category_id, price = EXCLUDED.price, discount_price = EXCLUDED.discount_price, image_url = EXCLUDED.image_url, description = EXCLUDED.description, is_featured = EXCLUDED.is_featured;
INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, '/assets/toys/abc-puzzle-1.jpg', 'Wooden ABC Puzzle for Kids', 0, true FROM products WHERE slug = 'wooden-abc-puzzle-for-kids'
AND NOT EXISTS (SELECT 1 FROM product_images pi WHERE pi.product_id = products.id AND pi.image_url = '/assets/toys/abc-puzzle-1.jpg');

-- 12) Pack of 2 Magic Water Coloring Books for Kids — Rs. 999
INSERT INTO products (category_id, name, slug, sku, description, price, discount_price, image_url, stock_qty, is_featured, is_active)
SELECT id, 'Pack of 2 Magic Water Coloring Books for Kids', 'pack-of-2-magic-water-coloring-books-for-kids', 'AZ-T-004', 'Magic Water Coloring Books for Kids — Pack of 2. Just fill the pen with water and color — the pictures appear like magic, then fade away in a few minutes so the pages can be used again and again. No mess, no ink, no stains. Reusable pages, boosts creativity, and safe for kids.

Material: Plastic. Gender: Girl''s, Boy''s. Preferred Ages: 1-5 Years. Number Of Pieces: 2 Pcs. Product Feature: Animals. Color: Multicolor. Package Includes: 2 x Magic Water Canvas. Product Code: MZ3457200004VESE. Adult supervision is recommended as this toy may contain small parts that could pose a choking hazard. Cash on Delivery available across Pakistan; delivery Rs. 200 (free on orders of Rs. 5,000 or more).', 999, NULL, '/assets/toys/waterbook-1.jpg', 10, true, true FROM categories WHERE slug = 'toys'
ON CONFLICT (slug) DO UPDATE SET category_id = EXCLUDED.category_id, price = EXCLUDED.price, discount_price = EXCLUDED.discount_price, image_url = EXCLUDED.image_url, description = EXCLUDED.description, is_featured = EXCLUDED.is_featured;
INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, '/assets/toys/waterbook-1.jpg', 'Pack of 2 Magic Water Coloring Books for Kids', 0, true FROM products WHERE slug = 'pack-of-2-magic-water-coloring-books-for-kids'
AND NOT EXISTS (SELECT 1 FROM product_images pi WHERE pi.product_id = products.id AND pi.image_url = '/assets/toys/waterbook-1.jpg');

-- 13) Wooden Number Puzzle for Kids 123 Multicolor Educational Toy — Rs. 999
INSERT INTO products (category_id, name, slug, sku, description, price, discount_price, image_url, stock_qty, is_featured, is_active)
SELECT id, 'Wooden Number Puzzle for Kids 123 Multicolor Educational Toy', 'wooden-number-puzzle-for-kids-123', 'AZ-T-005', 'Give your child the perfect blend of fun and learning with our Fun Multicolor Wooden Number (123) Puzzles — ideal for early education and perfect for Pakistani homes where kids love to explore. Designed for local playtime, this sturdy wooden puzzle helps develop fine motor skills and number recognition without the hassle of fragile plastic toys.

Made from premium quality, eco-friendly wood, this puzzle is built to last through daily play and rough handling. The vibrant multicolor design captures attention and encourages cognitive growth while keeping little hands busy. Unlike flimsy alternatives, our puzzle is durable, safe, and crafted to withstand the active energy of Pakistani kids. It is not just a toy — it is a smart educational tool that grows with your child.

- Made from premium quality, durable wood
- Multicolor design to spark curiosity and learning
- Single-piece puzzle for easy assembly and play
- Perfect for early education and cognitive development
- Safe for kids with no toxic finishes or sharp edges
- Ideal for home, daycare, or classroom use

Material: Wood. Color: Multicolor. Size: 20 x 20 cm. Package Includes: 1 x Number Puzzle. Product Code: MZ55800000037KISS. Adult supervision is recommended as this toy may contain small parts that could pose a choking hazard. Cash on Delivery available across Pakistan; delivery Rs. 200 (free on orders of Rs. 5,000 or more).', 999, NULL, '/assets/toys/number-puzzle-1.jpg', 10, true, true FROM categories WHERE slug = 'toys'
ON CONFLICT (slug) DO UPDATE SET category_id = EXCLUDED.category_id, price = EXCLUDED.price, discount_price = EXCLUDED.discount_price, image_url = EXCLUDED.image_url, description = EXCLUDED.description, is_featured = EXCLUDED.is_featured;
INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, '/assets/toys/number-puzzle-1.jpg', 'Wooden Number Puzzle for Kids 123', 0, true FROM products WHERE slug = 'wooden-number-puzzle-for-kids-123'
AND NOT EXISTS (SELECT 1 FROM product_images pi WHERE pi.product_id = products.id AND pi.image_url = '/assets/toys/number-puzzle-1.jpg');

-- 14) Infrared Helicopter Toy for Kids 1-12 Years — Rs. 1,450
INSERT INTO products (category_id, name, slug, sku, description, price, discount_price, image_url, stock_qty, is_featured, is_active)
SELECT id, 'Infrared Helicopter Toy for Kids 1-12 Years', 'infrared-helicopter-toy-for-kids', 'AZ-T-006', 'This sleek infrared induction helicopter is the perfect gift for any young boy in Pakistan who loves thrilling aerial adventures. Designed for easy use, it takes off automatically with just a wave of your hand, making it ideal for kids who are just learning to fly. Its stylish design comes in vibrant colors like yellow, blue, and red, ensuring your child stands out while playing.

Made from durable plastic, this toy is built to withstand rough play and outdoor fun. The electric drive system ensures smooth, responsive flight, while the infrared sensor technology lets your child control it without needing complex remote controls. Perfect for local weather conditions, it is a safe and exciting way to keep kids entertained indoors or out.

- Infrared induction for hands-free flying
- Automatic 3-second takeoff for easy use
- Durable plastic construction for long-lasting play
- Stylish color options: yellow, blue, and red
- Safe for ages 1-12 with adult supervision

Material: Plastic. Gender: Boy''s. Preferred Ages: 1-12 Years. Number Of Pieces: 1 Pc. Product Feature: Electric Drive Set. Color: Yellow / Blue / Red (shipped as per availability). Size: 18 x 16 x 11 cm. Package Includes: 1 x Hand Sensor Toy. Product Code: MZ1773200030BROOKS. Adult supervision is recommended as this toy may contain small parts that could pose a choking hazard. Cash on Delivery available across Pakistan; delivery Rs. 200 (free on orders of Rs. 5,000 or more).', 1450, NULL, '/assets/toys/helicopter-1.jpg', 10, true, true FROM categories WHERE slug = 'toys'
ON CONFLICT (slug) DO UPDATE SET category_id = EXCLUDED.category_id, price = EXCLUDED.price, discount_price = EXCLUDED.discount_price, image_url = EXCLUDED.image_url, description = EXCLUDED.description, is_featured = EXCLUDED.is_featured;
INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, '/assets/toys/helicopter-1.jpg', 'Infrared Helicopter Toy for Kids', 0, true FROM products WHERE slug = 'infrared-helicopter-toy-for-kids'
AND NOT EXISTS (SELECT 1 FROM product_images pi WHERE pi.product_id = products.id AND pi.image_url = '/assets/toys/helicopter-1.jpg');

-- 15) Rechargeable Panda Table Lamp Multicolor — Rs. 1,599
INSERT INTO products (category_id, name, slug, sku, description, price, discount_price, image_url, stock_qty, is_featured, is_active)
SELECT id, 'Rechargeable Panda Table Lamp Multicolor', 'rechargeable-panda-table-lamp-multicolor', 'AZ-T-007', 'Rechargeable Panda Table Lamp — a cute, soft silicone night light for kids and home. Tap to change colors: Golden, White, Red, Blue and more. USB rechargeable, up to 5 hours standby. Soft glow, safe for kids'' rooms and bedside tables.

Material: Silicone. Connectivity: USB. Product Feature: Rechargeable. Size: Medium (20 x 5 x 5 cm). Light Color: Golden, White, Red, Blue. Color: Blue, Red, White, Yellow, Golden, Multicolor. Package Includes: 1 x Table Lamp. Battery Capacity: 20 mAh. Standby Time: 5 Hours. Voltage: 12 Volts. Watts: 20 Watt. Weight: 400 Gram. Product Code: MZ3147200027DAZZIN. Cash on Delivery available across Pakistan; delivery Rs. 200 (free on orders of Rs. 5,000 or more).', 1599, NULL, '/assets/toys/lamp-1.jpg', 10, true, true FROM categories WHERE slug = 'toys'
ON CONFLICT (slug) DO UPDATE SET category_id = EXCLUDED.category_id, price = EXCLUDED.price, discount_price = EXCLUDED.discount_price, image_url = EXCLUDED.image_url, description = EXCLUDED.description, is_featured = EXCLUDED.is_featured;
INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, '/assets/toys/lamp-1.jpg', 'Rechargeable Panda Table Lamp', 0, true FROM products WHERE slug = 'rechargeable-panda-table-lamp-multicolor'
AND NOT EXISTS (SELECT 1 FROM product_images pi WHERE pi.product_id = products.id AND pi.image_url = '/assets/toys/lamp-1.jpg');

-- 16) Plush Dancing Cactus Toy for Kids 1+ with 120 English Songs — Rs. 1,599
INSERT INTO products (category_id, name, slug, sku, description, price, discount_price, image_url, stock_qty, is_featured, is_active)
SELECT id, 'Plush Dancing Cactus Toy for Kids 1+ with 120 English Songs', 'plush-dancing-cactus-toy-for-kids', 'AZ-T-008', 'This adorable plush dancing cactus is the perfect gift for your little one in Pakistan. It is designed to entertain and engage kids with its lively movements and cheerful tunes, making it ideal for playtime at home or during family gatherings. The soft, plush material is gentle on delicate skin and safe for children aged one year and above, ensuring hours of fun without worry.

Made with durable, high-quality plush fabric, this cactus toy withstands daily play and rough handling. Its stylish green design and glowing lights add a touch of magic to any room, while the built-in speaker delivers 120 English songs that keep kids smiling.

- Can Dance
- Can Sing
- Can Record
- 120 English Songs
- Durable Plush Material
- Safe for Kids 1 Year and Above

Material: Plush. Color: Green. Size: 12.6 x 4.7 inch. Package Includes: 1 x Dancing Cactus. Product Code: MZ691200011AIBSFD. Adult supervision is recommended as this toy may contain small parts that could pose a choking hazard. Cash on Delivery available across Pakistan; delivery Rs. 200 (free on orders of Rs. 5,000 or more).', 1599, NULL, '/assets/toys/cactus-1.jpg', 10, true, true FROM categories WHERE slug = 'toys'
ON CONFLICT (slug) DO UPDATE SET category_id = EXCLUDED.category_id, price = EXCLUDED.price, discount_price = EXCLUDED.discount_price, image_url = EXCLUDED.image_url, description = EXCLUDED.description, is_featured = EXCLUDED.is_featured;
INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, '/assets/toys/cactus-1.jpg', 'Plush Dancing Cactus Toy for Kids', 0, true FROM products WHERE slug = 'plush-dancing-cactus-toy-for-kids'
AND NOT EXISTS (SELECT 1 FROM product_images pi WHERE pi.product_id = products.id AND pi.image_url = '/assets/toys/cactus-1.jpg');

-- 17) Penguin Print 2-Piece Night Suit for Boys 1-6Y — Rs. 1,199
INSERT INTO products (category_id, name, slug, sku, description, price, discount_price, image_url, stock_qty, is_featured, is_active)
SELECT id, 'Penguin Print 2-Piece Night Suit for Boys 1-6Y', 'penguin-print-2-piece-night-suit-for-boys-1-6y', 'AZ-D-001', 'This adorable 2-piece night suit is perfect for your little one''s cozy nights and playful days. Designed with a trendy penguin print that''s sure to delight, it''s ideal for summer nights and casual wear. Made from premium quality cotton jersey, it''s breathable, soft, and gentle on sensitive skin, ensuring your child stays comfortable all day long. The stylish design and durable construction make it a smart choice for parents who want both fashion and function.

The grey t-shirt features a fun dabbing penguin graphic, while the navy shorts are printed with matching penguin patterns for a cohesive look. This set is crafted for durability and everyday wear, making it a practical addition to any boy''s wardrobe. The cotton material keeps your child cool and comfortable, even during the hottest months. It''s a stylish, new arrival that combines comfort with modern design.

- Premium quality cotton jersey for softness and breathability
- Stylish penguin print design that''s trendy and fun
- Durable construction for long-lasting wear
- Perfect for boys aged 1-6 years
- Ideal for daily wear, sleep, or casual outings
- New arrival with best price in Pakistan

Material: Cotton Jersey. Pattern: Printed. Gender: Boy''s. Available Sizes: 1-2 Years, 3-4 Years, 5-6 Years. Number Of Pieces: 2 Pcs. Package Includes: 1 x Shirt, 1 x Shorts. Color: Grey. Product Code: MZ1276200172ILWR. Note: There might be an error of 1-3 cm due to manual measurement, and slight color differences may occur as a result of varying lighting and monitor effects. Cash on Delivery available across Pakistan; delivery Rs. 200 (free on orders of Rs. 5,000 or more).', 1199, NULL, '/assets/dress/penguin-nightsuit-1.jpg', 10, true, true FROM categories WHERE slug = 'dress'
ON CONFLICT (slug) DO UPDATE SET category_id = EXCLUDED.category_id, price = EXCLUDED.price, discount_price = EXCLUDED.discount_price, image_url = EXCLUDED.image_url, description = EXCLUDED.description, is_featured = EXCLUDED.is_featured;
INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, '/assets/dress/penguin-nightsuit-1.jpg', 'Penguin Print 2-Piece Night Suit for Boys', 0, true FROM products WHERE slug = 'penguin-print-2-piece-night-suit-for-boys-1-6y'
AND NOT EXISTS (SELECT 1 FROM product_images pi WHERE pi.product_id = products.id AND pi.image_url = '/assets/dress/penguin-nightsuit-1.jpg');

-- 18) Navy Blue Whale Print 2-Piece Night Suit for Boys 1-6Y — Rs. 1,199
INSERT INTO products (category_id, name, slug, sku, description, price, discount_price, image_url, stock_qty, is_featured, is_active)
SELECT id, 'Navy Blue Whale Print 2-Piece Night Suit for Boys 1-6Y', 'navy-blue-whale-print-2-piece-night-suit-for-boys-1-6y', 'AZ-D-002', 'This adorable 2-piece night suit is perfect for your little one''s summer nights and daily wear. Designed with a charming whale print on the navy blue shirt and stylish black-and-white striped shorts, it''s both playful and practical. Made from premium quality cotton jersey, it ensures maximum comfort and breathability, making it ideal for Pakistan''s warm climate. The durable stitching and soft fabric guarantee long-lasting wear, even with active toddlers.

The set is stylish enough for casual outings and cozy enough for bedtime. Its trendy design appeals to modern Pakistani parents who want their kids to look fashionable without compromising on comfort. The cotton material is gentle on sensitive skin and easy to care for, ensuring durability through frequent washing.

- Premium quality cotton jersey for softness and breathability
- Stylish whale print on shirt and striped shorts for trendy appeal
- Durable stitching for long-lasting wear
- Perfect fit for boys aged 1-6 years
- Ideal for summer nights and daily wear
- Best price in Pakistan for this quality and design

Material: Cotton Jersey. Pattern: Printed. Gender: Boy''s. Available Sizes: 1-2 Years, 3-4 Years, 5-6 Years. Number Of Pieces: 2 Pcs. Package Includes: 1 x Shirt, 1 x Shorts. Color: Blue. Product Code: MZ1276200171ILWR. Note: There might be an error of 1-3 cm due to manual measurement, and slight color differences may occur as a result of varying lighting and monitor effects. Cash on Delivery available across Pakistan; delivery Rs. 200 (free on orders of Rs. 5,000 or more).', 1199, NULL, '/assets/dress/whale-nightsuit-1.jpg', 10, true, true FROM categories WHERE slug = 'dress'
ON CONFLICT (slug) DO UPDATE SET category_id = EXCLUDED.category_id, price = EXCLUDED.price, discount_price = EXCLUDED.discount_price, image_url = EXCLUDED.image_url, description = EXCLUDED.description, is_featured = EXCLUDED.is_featured;
INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, '/assets/dress/whale-nightsuit-1.jpg', 'Navy Blue Whale Print 2-Piece Night Suit for Boys', 0, true FROM products WHERE slug = 'navy-blue-whale-print-2-piece-night-suit-for-boys-1-6y'
AND NOT EXISTS (SELECT 1 FROM product_images pi WHERE pi.product_id = products.id AND pi.image_url = '/assets/dress/whale-nightsuit-1.jpg');

-- 19) 2 Pcs Women's Stitched Jersey Printed Night Suit — Rs. 1,999
INSERT INTO products (category_id, name, slug, sku, description, price, discount_price, image_url, stock_qty, is_featured, is_active)
SELECT id, '2 Pcs Women''s Stitched Jersey Printed Night Suit', '2-pcs-womens-stitched-jersey-printed-night-suit', 'AZ-D-003', '2 Pcs Women''s Stitched Jersey Printed Night Suit — a soft, comfortable sleep set with a round-neck printed shirt and matching trousers. Available in eight lovely prints: Spread Happiness butterfly, live your dreams butterflies, a festive bow, a golden bow, a Rose Butterfly print, Hello Kitty, a Cute & Lovely kitten, and a Fall in Love teddy bear. Jersey fabric is breathable and gentle on skin, perfect for a good night''s sleep.

Fabric: Jersey. Pattern: Printed. Neck Type: Round Neck. Product Feature: Comes With Shorts. Available Sizes: Standard Size. Number Of Pieces: 2 Pcs. Package Includes: 1 x Sleep Shirt, 1 x Sleep Trouser. Shirt Length: 28 Inches. Shirt Chest: 22 Inches. Shirt Shoulder: 15 Inches. Arm Length: 11 Inches. Trouser Length: 39 Inches. Trouser Waist: 36 Inches. Trouser Hip: 23 Inches. Product Code: MZ2098204574DK. Note: There might be an error of 1-3 cm due to manual measurement, and slight color differences may occur as a result of varying lighting and monitor effects. Cash on Delivery available across Pakistan; delivery Rs. 200 (free on orders of Rs. 5,000 or more).', 1999, NULL, '/assets/dress/womens-nightsuit-1.jpg', 10, true, true FROM categories WHERE slug = 'dress'
ON CONFLICT (slug) DO UPDATE SET category_id = EXCLUDED.category_id, price = EXCLUDED.price, discount_price = EXCLUDED.discount_price, image_url = EXCLUDED.image_url, description = EXCLUDED.description, is_featured = EXCLUDED.is_featured;
INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, '/assets/dress/womens-nightsuit-1.jpg', '2 Pcs Women''s Stitched Jersey Printed Night Suit', 0, true FROM products WHERE slug = '2-pcs-womens-stitched-jersey-printed-night-suit'
AND NOT EXISTS (SELECT 1 FROM product_images pi WHERE pi.product_id = products.id AND pi.image_url = '/assets/dress/womens-nightsuit-1.jpg');

-- 20) 2 Pcs Girl's Stitched Jersey Printed Pajama And Shirt — Rs. 1,699
INSERT INTO products (category_id, name, slug, sku, description, price, discount_price, image_url, stock_qty, is_featured, is_active)
SELECT id, '2 Pcs Girl''s Stitched Jersey Printed Pajama And Shirt', '2-pcs-girls-stitched-jersey-printed-pajama-and-shirt', 'AZ-D-004', '2 Pcs Girl''s Stitched Jersey Printed Pajama And Shirt — a comfy 2-piece set for girls with a printed jersey shirt and matching pajama. Available in five shirt colours (Yellow, Red, Blue, White, Black) with pink pajama trousers featuring cute bows. Soft jersey fabric, perfect for daily wear and sleep.

Material: Jersey. Pattern: Printed. Gender: Girl''s. Preferred Ages: 1-10 Years. Available Sizes: 1-2 Years, 3-4 Years, 5-6 Years, 7-8 Years, 8-10 Years. Number Of Pieces: 2 Pcs. Package Includes: 1 x Shirt, 1 x Pajama. Product Code: MZ2098204586DK. Note: There might be an error of 1-3 cm due to manual measurement, and slight color differences may occur as a result of varying lighting and monitor effects. Cash on Delivery available across Pakistan; delivery Rs. 200 (free on orders of Rs. 5,000 or more).', 1699, NULL, '/assets/dress/barbie-pajama-1.jpg', 10, true, true FROM categories WHERE slug = 'dress'
ON CONFLICT (slug) DO UPDATE SET category_id = EXCLUDED.category_id, price = EXCLUDED.price, discount_price = EXCLUDED.discount_price, image_url = EXCLUDED.image_url, description = EXCLUDED.description, is_featured = EXCLUDED.is_featured;
INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, '/assets/dress/barbie-pajama-1.jpg', '2 Pcs Girl''s Stitched Jersey Printed Pajama And Shirt', 0, true FROM products WHERE slug = '2-pcs-girls-stitched-jersey-printed-pajama-and-shirt'
AND NOT EXISTS (SELECT 1 FROM product_images pi WHERE pi.product_id = products.id AND pi.image_url = '/assets/dress/barbie-pajama-1.jpg');

-- 21) 2 Pcs Women's Stitched Jersey Printed Night Suit (Loved Bow) — Rs. 1,999
INSERT INTO products (category_id, name, slug, sku, description, price, discount_price, image_url, stock_qty, is_featured, is_active)
SELECT id, '2 Pcs Women''s Stitched Jersey Printed Night Suit (Loved Bow)', '2-pcs-womens-stitched-jersey-printed-night-suit-loved', 'AZ-D-005', '2 Pcs Women''s Stitched Jersey Printed Night Suit — a soft jersey 2-piece set with a ''Loved'' bow print sleep shirt and matching bow-print sleep trouser. Available in five shirt colours (Lavender, Pink, Yellow, Grey, White). Round neck, comfortable fit, perfect for a good night''s sleep.

Fabric: Jersey. Pattern: Printed. Neck Type: Round Neck. Product Feature: Size Chart Attached. Available Sizes: Medium, Large, X-Large. Number Of Pieces: 2 Pcs. Package Includes: 1 x Sleep Shirt, 1 x Sleep Trouser. Shirt Length: 30 Inches. Shirt Chest: 23 Inches. Shirt Shoulder: 15 Inches. Arm Length: 11 Inches. Trouser Length: 39 Inches. Trouser Waist: 36 Inches. Trouser Hip: 23 Inches. Product Code: MZ2098204608DK. Note: There might be an error of 1-3 cm due to manual measurement, and slight color differences may occur as a result of varying lighting and monitor effects. Cash on Delivery available across Pakistan; delivery Rs. 200 (free on orders of Rs. 5,000 or more).', 1999, NULL, '/assets/dress/loved-nightsuit-1.jpg', 10, true, true FROM categories WHERE slug = 'dress'
ON CONFLICT (slug) DO UPDATE SET category_id = EXCLUDED.category_id, price = EXCLUDED.price, discount_price = EXCLUDED.discount_price, image_url = EXCLUDED.image_url, description = EXCLUDED.description, is_featured = EXCLUDED.is_featured;
INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, '/assets/dress/loved-nightsuit-1.jpg', '2 Pcs Women''s Stitched Jersey Printed Night Suit (Loved Bow)', 0, true FROM products WHERE slug = '2-pcs-womens-stitched-jersey-printed-night-suit-loved'
AND NOT EXISTS (SELECT 1 FROM product_images pi WHERE pi.product_id = products.id AND pi.image_url = '/assets/dress/loved-nightsuit-1.jpg');

-- 22) 2 Pcs Women's Stitched Cotton Jersey Printed Night Suit — Rs. 1,999
INSERT INTO products (category_id, name, slug, sku, description, price, discount_price, image_url, stock_qty, is_featured, is_active)
SELECT id, '2 Pcs Women''s Stitched Cotton Jersey Printed Night Suit', '2-pcs-womens-stitched-cotton-jersey-printed-night-suit', 'AZ-D-006', '2 Pcs Women''s Stitched Cotton Jersey Printed Night Suit — a comfy cotton jersey 2-piece set with a black bow-print sleep shirt and black-and-white checkered smiley-print sleep trouser. Round neck, comfortable fit, perfect for a good night''s sleep.

Fabric: Cotton Jersey. Pattern: Printed. Neck Type: Round Neck. Product Feature: Size Chart Attached. Available Sizes: Medium, Large, X-Large. Number Of Pieces: 2 Pcs. Package Includes: 1 x Sleep Shirt, 1 x Sleep Trouser. Shirt Length: 30 Inches. Shirt Chest: 23 Inches. Shirt Shoulder: 15 Inches. Arm Length: 11 Inches. Trouser Length: 39 Inches. Trouser Waist: 36 Inches. Trouser Hip: 23 Inches. Product Code: MZ2098204610DK. Note: There might be an error of 1-3 cm due to manual measurement, and slight color differences may occur as a result of varying lighting and monitor effects. Cash on Delivery available across Pakistan; delivery Rs. 200 (free on orders of Rs. 5,000 or more).', 1999, NULL, '/assets/dress/checkered-nightsuit-1.jpg', 10, true, true FROM categories WHERE slug = 'dress'
ON CONFLICT (slug) DO UPDATE SET category_id = EXCLUDED.category_id, price = EXCLUDED.price, discount_price = EXCLUDED.discount_price, image_url = EXCLUDED.image_url, description = EXCLUDED.description, is_featured = EXCLUDED.is_featured;
INSERT INTO product_images (product_id, image_url, alt_text, sort_order, is_primary)
SELECT id, '/assets/dress/checkered-nightsuit-1.jpg', '2 Pcs Women''s Stitched Cotton Jersey Printed Night Suit', 0, true FROM products WHERE slug = '2-pcs-womens-stitched-cotton-jersey-printed-night-suit'
AND NOT EXISTS (SELECT 1 FROM product_images pi WHERE pi.product_id = products.id AND pi.image_url = '/assets/dress/checkered-nightsuit-1.jpg');

COMMIT;
