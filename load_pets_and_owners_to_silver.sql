CREATE MATERIALIZED VIEW data_quality.owners_silver (
  owner_id INT PRIMARY KEY,
  first_name STRING,
  last_name STRING,
  birth_date DATE,
  CONSTRAINT owner_min_age EXPECT (
    birth_date <= date_add(current_date(), -10 * 365)
  ) ON VIOLATION DROP ROW
)
AS SELECT * FROM data_quality.owners_brz;

CREATE MATERIALIZED VIEW data_quality.pets_silver (
  pet_id INT PRIMARY KEY,
  owner_id INT,
  pet_name STRING,
  species STRING,
  birth_date DATE,
  CONSTRAINT pet_name_no_special EXPECT (
    pet_name RLIKE '^[A-Za-z0-9 ]+$'
  ) ON VIOLATION DROP ROW
)
AS SELECT * FROM data_quality.pets_brz;