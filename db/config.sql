CREATE TABLE short_urls(
  id INTEGER PRIMARY KEY,
  full_url TEXT,
  short_url varchar(40),
  created_at timestamp,
  modified_at timestamp
);
