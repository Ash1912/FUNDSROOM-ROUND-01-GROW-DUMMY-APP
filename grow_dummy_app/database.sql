CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100),
  email VARCHAR(100) UNIQUE
);

CREATE TABLE investments (
  id SERIAL PRIMARY KEY,
  user_id INTEGER REFERENCES users(id),
  type VARCHAR(50), -- e.g., 'Stock', 'Mutual Fund', 'Gold'
  name VARCHAR(100),
  initial_value DECIMAL,
  current_value DECIMAL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE transactions (
  id SERIAL PRIMARY KEY,
  investment_id INTEGER REFERENCES investments(id),
  amount DECIMAL,
  transaction_type VARCHAR(50), -- e.g., 'Buy', 'Sell'
  transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
