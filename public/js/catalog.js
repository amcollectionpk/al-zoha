/* Al-Zoha — built-in catalog (fallback only).
   Live catalog API (/api/products) is used first when the deployed database
   has products. This file only carries the CATEGORIES so the category bar
   still renders if the API is briefly unreachable; products are NEVER
   hard-coded here — the shop shows only what the database holds. */
window.AMC_CATALOG = {
 "categories": [
  {
   "image": "/assets/watches/wheel-watch-1.jpg",
   "name": "Men's Watches",
   "slug": "mens-watches",
   "sort_order": 1
  },
  {
   "image": "/assets/watches/digital-bracelet-1.jpg",
   "name": "Women's Watches",
   "slug": "womens-watches",
   "sort_order": 2
  },
  {
   "image": "/assets/hoodies/bomber-track-black-1.jpg",
   "name": "Hoodies / Track Suits",
   "slug": "hoodies",
   "sort_order": 3
  }
 ],
 "products": []
};
