-- Table: public.properties
--DROP TABLE IF EXISTS public.properties;
/*
CREATE TABLE IF NOT EXISTS public.properties
(
    id serial NOT NULL,
	airbnb_id VARCHAR,
    night_price_native VARCHAR,
    night_price VARCHAR,
    weekly_price VARCHAR,
    monthly_price VARCHAR,
    cleaning_fee_native_price VARCHAR,
    num_of_baths VARCHAR,
    num_of_rooms VARCHAR,
    occupancy VARCHAR,
    nights_booked VARCHAR,
    rental_income VARCHAR,
    airbnb_neighborhood_id VARCHAR,
    airbnb_city varchar,
    capacity_of_people VARCHAR,
    zip "char",
    property_type varchar,
    room_type varchar,
    reviews_count varchar,
    num_of_beds VARCHAR,
    lat VARCHAR,
    lon VARCHAR,
    star_rating VARCHAR,
    CONSTRAINT properties_pkey PRIMARY KEY (id)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.properties
    OWNER to postgres;	

*/

/*
UPDATE PROPERTIES
SET night_price_native = RTRIM(night_price_native, '.0'),
    night_price = RTRIM(night_price, '.0'),
    weekly_price = RTRIM(weekly_price, '.0'),
    monthly_price = RTRIM(monthly_price, '.0'),
    cleaning_fee_native_price = RTRIM(cleaning_fee_native_price, '.0'),
    num_of_baths = RTRIM(num_of_baths, '.0'),
    num_of_rooms = RTRIM(num_of_rooms, '.0'),
    occupancy = RTRIM(occupancy, '.0'),
    nights_booked = RTRIM(nights_booked, '.0'),
    rental_income = RTRIM(rental_income, '.0'),
    capacity_of_people = RTRIM(capacity_of_people, '.0'),
    reviews_count = RTRIM(reviews_count, '.0'),
    num_of_beds = RTRIM(num_of_beds, '.0'),
    star_rating = RTRIM(star_rating, '.0');
*/

--There are a bunch of fields that have '' as the value. Can't convert these columns to integer until this is fixed
UPDATE PROPERTIES
SET  weekly_price = 0
WHERE weekly_price = '';

UPDATE PROPERTIES
SET  monthly_price = 0
WHERE monthly_price = '';

UPDATE PROPERTIES
SET  cleaning_fee_native_price = 0
WHERE cleaning_fee_native_price = '';

-- Had to take an extra step to deal with NULLs, should have been caught in EDA
UPDATE PROPERTIES
SET  cleaning_fee_native_price = 0
WHERE cleaning_fee_native_price IS NULL;

UPDATE PROPERTIES
SET  num_of_rooms = 0
WHERE num_of_rooms = '';

UPDATE PROPERTIES
SET  num_of_beds = 0
WHERE num_of_beds = '';

UPDATE PROPERTIES
SET  num_of_baths = 0
WHERE num_of_baths = '';

UPDATE PROPERTIES
SET  occupancy = 0
WHERE occupancy = '';

UPDATE PROPERTIES
SET  nights_booked = 0
WHERE nights_booked = '';

UPDATE PROPERTIES
SET  rental_income = 0
WHERE rental_income = '';

UPDATE PROPERTIES
SET  star_rating = 0
WHERE star_rating IS NULL;

ALTER TABLE PROPERTIES
ALTER COLUMN night_price_native TYPE INTEGER
USING night_price_native::integer;

ALTER TABLE PROPERTIES
ALTER COLUMN weekly_price TYPE INTEGER
USING weekly_price::integer;

ALTER TABLE PROPERTIES
ALTER COLUMN monthly_price TYPE INTEGER
USING monthly_price::integer;

ALTER TABLE PROPERTIES
ALTER COLUMN night_price_native TYPE INTEGER
USING night_price_native::integer;

ALTER TABLE PROPERTIES
ALTER COLUMN nights_booked TYPE INTEGER
USING nights_booked::integer;

ALTER TABLE PROPERTIES
ALTER COLUMN rental_income TYPE INTEGER
USING rental_income::integer;

ALTER TABLE PROPERTIES
ALTER COLUMN night_price_native TYPE INTEGER
USING night_price_native::integer;

ALTER TABLE PROPERTIES
ALTER COLUMN night_price TYPE INTEGER
USING night_price::integer;

ALTER TABLE PROPERTIES
ALTER COLUMN cleaning_fee_native_price TYPE INTEGER
USING cleaning_fee_native_price::integer;

ALTER TABLE PROPERTIES
ALTER COLUMN num_of_baths TYPE decimal(3,1)
USING num_of_baths::decimal;

ALTER TABLE PROPERTIES
ALTER COLUMN num_of_rooms TYPE INTEGER
USING num_of_rooms::integer;

ALTER TABLE PROPERTIES
ALTER COLUMN occupancy TYPE INTEGER
USING occupancy::integer;

ALTER TABLE PROPERTIES
ALTER COLUMN capacity_of_people TYPE INTEGER
USING capacity_of_people::integer;

ALTER TABLE PROPERTIES
ALTER COLUMN reviews_count TYPE INTEGER
USING reviews_count::integer;

ALTER TABLE PROPERTIES
ALTER COLUMN num_of_beds TYPE INTEGER
USING num_of_beds::integer;

ALTER TABLE PROPERTIES
ALTER COLUMN star_rating TYPE INTEGER
USING star_rating::integer;


-- Table: public.property_locations
--DROP TABLE IF EXISTS public.property_locations;

CREATE TABLE IF NOT EXISTS public.property_locations
(
    id serial NOT NULL,
	properties_id INTEGER,
	airbnb_city VARCHAR,
    lat VARCHAR,
    lon VARCHAR,
	star_rating INTEGER,
    CONSTRAINT property_locations_pkey PRIMARY KEY (id)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.property_locations
    OWNER to postgres;	
	
ALTER TABLE "property_locations" ADD CONSTRAINT "fk_properties_id" FOREIGN KEY("properties_id")
REFERENCES "properties" ("id");

CREATE SEQUENCE property_locations_serial START 1;
INSERT INTO property_locations
SELECT nextval('property_locations_serial'), properties.id, airbnb_city, lat, lon, star_rating
FROM properties;

--DROP TABLE IF EXISTS public.success_indicators;

CREATE TABLE IF NOT EXISTS public.success_indicators
(
    id serial NOT NULL,
	properties_id INTEGER,
	nights_booked INTEGER,
	occupancy INTEGER,
	rental_income INTEGER,
	star_rating INTEGER,
    CONSTRAINT success_indicators_pkey PRIMARY KEY (id)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.success_indicators
    OWNER to postgres;	
	
ALTER TABLE "success_indicators" ADD CONSTRAINT "fk_properties_success_id" FOREIGN KEY("properties_id")
REFERENCES "properties" ("id");

CREATE SEQUENCE success_indicators_serial START 1;
INSERT INTO success_indicators
SELECT nextval('success_indicators_serial'), properties.id, nights_booked, occupancy, rental_income, star_rating
FROM properties;




	

