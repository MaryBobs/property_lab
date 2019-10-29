DROP TABLE IF EXISTS property_listings;

CREATE TABLE property_listings (
  id SERIAL4 PRIMARY KEY,
  address VARCHAR(255),
  beds INT2,
  year_built INT2,
  buy_let_status VARCHAR(255)
);
