# Al-Zoha — Mother Care & Baby Products Store

Database-backed e-commerce website (storefront + admin dashboard) for **Al-Zoha**,
a mother care & baby products brand in Pakistan. Same design as AM Collection, in
Al-Zoha's own colours: **black + gold + cream** (no red).

- Storefront: product search/filter, product pages with photo galleries,
  M/L/XL/XXL size selector + Size Guide on track suits, cart, checkout
  (COD / JazzCash / Easypaisa — Transaction ID required for wallet orders),
  order tracking, reviews (admin-approved only), complaints.
- Delivery: **Rs. 200**, **FREE on orders of Rs. 5,000+**, remote provinces
  (Balochistan, Gilgit-Baltistan) **+Rs. 100**.
- Order numbers: **AZ-YYYYMMDD-001**.
- Admin dashboard (`/admin`): products, orders, payments, reviews, complaints,
  customers, inventory, reports, settings, About-page picture.
- Prices shown are the selling prices. No discount percent is displayed
  (no discount is confirmed for Al-Zoha yet).

## Tech

Node.js + Express + PostgreSQL. `server.js` serves the API and the static
storefront from `public/`. Database schema: `database/schema.sql`;
launch products: `database/seed-al-zoha.sql` (8 test products, stock 10 each).
`scripts/init-db.js` runs both files (idempotent — safe to run on every deploy).

## Deploy on Uppcoder (free Spark plan)

1. Create a **Stack** from this GitHub repo (`amcollectionpk/al-zoha`):
   Express app + its own PostgreSQL database.
2. Set these **Environment variables** on the Uppcoder stack:

| Variable | Value |
|---|---|
| `DATABASE_URL` | Uppcoder Postgres connection string (the stack links it automatically) |
| `JWT_SECRET` | a long random string (login tokens) |
| `ADMIN_USER` | `admin` |
| `ADMIN_PASSWORD` | the admin password (set by the owner — never commit it) |
| `PORT` | Uppcoder provides it — do **not** set it by hand |
| `PGSSL` | `true` if the Uppcoder database needs SSL, else `false` |
| `DELIVERY_BASE` | `200` |
| `DELIVERY_FREE_ABOVE` | `5000` |
| `STORE_CITY` | `Bahawalnagar` |
| `STORE_PAYMENT_NUMBER` | *(leave empty for now)* — JazzCash/Easypaisa account number; when the owner provides it, set it here and the checkout will show it. Until then the checkout tells customers the account number will be shared on the confirmation call. |
| `CORS_ORIGINS` | your public Uppcoder URL, e.g. `https://al-zoha.uppcoder.app` |

   Optional (WhatsApp order notifications — leave empty to skip):
   `WHATSAPP_PHONE_NUMBER_ID`, `WHATSAPP_ACCESS_TOKEN`, `WHATSAPP_NOTIFY_TO`,
   `WHATSAPP_TEMPLATE_NAME`, `WHATSAPP_TEMPLATE_LANG`.

3. **Build command:** `npm install && node scripts/init-db.js`
   (creates the tables and seeds the 8 test products)
4. **Start command:** `npm start` (runs `node server.js`)
5. Open the public URL. Check `/health` — it should return
   `{"ok": true, "service": "Al-Zoha API", ...}`.
6. Admin login: open `/admin` (or Account → Login on the storefront) and
   sign in with `ADMIN_USER` / `ADMIN_PASSWORD` from the environment.

## Local run

```bash
npm install
cp .env.example .env   # fill in DATABASE_URL, JWT_SECRET, ADMIN_PASSWORD
node scripts/init-db.js
npm start              # http://localhost:4000
```

## Still to provide (owner)

- JazzCash/Easypaisa **account number + account title** → set
  `STORE_PAYMENT_NUMBER` (and the title in `public/js/api.js`) when received.
- Al-Zoha **WhatsApp number** → set `WHATSAPP_LINK` in `public/js/api.js`
  (enables the WhatsApp order button + floating button) and the footer
  social **usernames/links** when ready.
- Real products replace the 8 test products (add via Admin → Products,
  or send photos one by one to be added).
