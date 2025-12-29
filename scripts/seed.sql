-- Seed data for local development and testing

-- Insert test users
INSERT INTO user (email) VALUES 
  ('test@example.com'),
  ('demo@example.com');

-- Insert test companies
INSERT INTO company (user_id, ticker, name, exchange, country, currency, fiscal_year_end_month) VALUES 
  (1, 'VNM', 'Vinamilk', 'HOSE', 'VN', 'VND', 12),
  (1, 'VCB', 'Vietcombank', 'HOSE', 'VN', 'VND', 12),
  (2, 'HPG', 'Hoa Phat Group', 'HOSE', 'VN', 'VND', 12);

-- Insert canonical metrics for Income Statement
INSERT INTO metric (code, name, statement, unit_hint) VALUES 
  ('REV', 'Revenue', 'IS', 'VND'),
  ('COGS', 'Cost of Goods Sold', 'IS', 'VND'),
  ('GP', 'Gross Profit', 'IS', 'VND'),
  ('OPEX', 'Operating Expenses', 'IS', 'VND'),
  ('EBIT', 'Earnings Before Interest and Tax', 'IS', 'VND'),
  ('INT_EXP', 'Interest Expense', 'IS', 'VND'),
  ('EBT', 'Earnings Before Tax', 'IS', 'VND'),
  ('TAX', 'Income Tax', 'IS', 'VND'),
  ('NPAT', 'Net Profit After Tax', 'IS', 'VND'),
  ('EPS', 'Earnings Per Share', 'IS', 'VND');

-- Insert canonical metrics for Balance Sheet
INSERT INTO metric (code, name, statement, unit_hint) VALUES 
  ('CASH', 'Cash and Cash Equivalents', 'BS', 'VND'),
  ('AR', 'Accounts Receivable', 'BS', 'VND'),
  ('INV', 'Inventory', 'BS', 'VND'),
  ('CA', 'Current Assets', 'BS', 'VND'),
  ('PPE', 'Property, Plant & Equipment', 'BS', 'VND'),
  ('TA', 'Total Assets', 'BS', 'VND'),
  ('AP', 'Accounts Payable', 'BS', 'VND'),
  ('DEBT_ST', 'Short-term Debt', 'BS', 'VND'),
  ('CL', 'Current Liabilities', 'BS', 'VND'),
  ('DEBT_LT', 'Long-term Debt', 'BS', 'VND'),
  ('TL', 'Total Liabilities', 'BS', 'VND'),
  ('EQUITY', 'Total Equity', 'BS', 'VND');

-- Insert canonical metrics for Cash Flow Statement
INSERT INTO metric (code, name, statement, unit_hint) VALUES 
  ('CFO', 'Cash Flow from Operations', 'CF', 'VND'),
  ('CFI', 'Cash Flow from Investing', 'CF', 'VND'),
  ('CFF', 'Cash Flow from Financing', 'CF', 'VND'),
  ('FCF', 'Free Cash Flow', 'CF', 'VND');

-- Insert canonical metrics for Ratios
INSERT INTO metric (code, name, statement, unit_hint) VALUES 
  ('ROE', 'Return on Equity', 'RATIO', 'PERCENT'),
  ('ROA', 'Return on Assets', 'RATIO', 'PERCENT'),
  ('PM', 'Profit Margin', 'RATIO', 'PERCENT'),
  ('CR', 'Current Ratio', 'RATIO', 'RATIO'),
  ('DE', 'Debt to Equity', 'RATIO', 'RATIO');

-- Insert test periods for VNM (Vinamilk)
INSERT INTO period (company_id, kind, year, quarter, label, start_date, end_date) VALUES 
  (1, 'QUARTER', 2023, 1, '2023Q1', '2023-01-01', '2023-03-31'),
  (1, 'QUARTER', 2023, 2, '2023Q2', '2023-04-01', '2023-06-30'),
  (1, 'QUARTER', 2023, 3, '2023Q3', '2023-07-01', '2023-09-30'),
  (1, 'QUARTER', 2023, 4, '2023Q4', '2023-10-01', '2023-12-31'),
  (1, 'FY', 2023, NULL, 'FY2023', '2023-01-01', '2023-12-31'),
  (1, 'QUARTER', 2024, 1, '2024Q1', '2024-01-01', '2024-03-31'),
  (1, 'QUARTER', 2024, 2, '2024Q2', '2024-04-01', '2024-06-30'),
  (1, 'QUARTER', 2024, 3, '2024Q3', '2024-07-01', '2024-09-30');
