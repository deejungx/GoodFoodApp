-- NOTE:
-- INSERT ALL requires a SELECT subquery. To get around that, 
-- SELECT 1 FROM DUAL is used to give a single row of dummy data.


-- Cuisine Table

INSERT ALL
    INTO cuisine (id, name, description) VALUES (1, 'Nepali', 'Nepali Cuisine')
    INTO cuisine (id, name, description) VALUES (2, 'Indian', 'Indian Cuisine')
    INTO cuisine (id, name, description) VALUES (3, 'Chinese', 'Chinese Cuisine')
    INTO cuisine (id, name, description) VALUES (4, 'Italian', 'Italian Cuisine')
    INTO cuisine (id, name, description) VALUES (5, 'French', 'French Cuisine')
SELECT 1 FROM DUAL;


-- Dish table

INSERT ALL
    INTO dish (id, code, name) VALUES (1, 'MOMO', 'MoMo')
    INTO dish (id, code, name) VALUES (2, 'THLI', 'Nepali Thali')
    INTO dish (id, code, name) VALUES (3, 'PIZA', 'Pizza')
    INTO dish (id, code, name) VALUES (4, 'PSTA', 'Pasta')
    INTO dish (id, code, name) VALUES (5, 'BRYA', 'Biryani')
    INTO dish (id, code, name) VALUES (6, 'ROTI', 'Roti')
    INTO dish (id, code, name) VALUES (7, 'NAAN', 'Naan')
    INTO dish (id, code, name) VALUES (8, 'NODL', 'Noodles')
    INTO dish (id, code, name) VALUES (9, 'FRRC', 'Fried Rice')
    INTO dish (id, code, name) VALUES (10, 'NSWZ', 'Nicoise')
    INTO dish (id, code, name) VALUES (11, 'CRPS', 'Crepes')
    INTO dish (id, code, name) VALUES (12, 'BISQ', 'Lobster Bisque')
SELECT 1 FROM DUAL;


-- Restaurant table

-- First, we create restaurant records with empty blob fields.
INSERT ALL
    INTO restaurant (id, name, branch, bio, phone, displayPhoto, costfortwo, city, street)
    VALUES
        (1, 'French Creperie Kathmandu', 'main', 
        'French restaurant : galettes, crêpes, cheese. Vegan and vegetarian friendly.',
        9843339062, empty_blob(), 600, 'Kathmandu', 'Thamel Marg')
        
    INTO restaurant (id, name, branch, bio, phone, displayPhoto, costfortwo, city, street)
    VALUES
        (2, 'The Village Cafe', 'main', 
        'Traditional and Authentic Nepalese cuisines prepared by women.',
        5540712, empty_blob(), 450, 'Lalitpur', 'Jhamsikhel')
        
    INTO restaurant (id, name, branch, bio, phone, displayPhoto, costfortwo, city, street)
    VALUES
        (3, 'Achaar Ghar', 'Jhamsikhel branch', 
        'Nepali cuisine, with the widest range of pickles, home made in Nepal.',
        5541952, empty_blob(), 580, 'Lalitpur', 'Jhamsikhel')
        
    INTO restaurant (id, name, branch, bio, phone, displayPhoto, costfortwo, city, street)
    VALUES
        (4, 'Hyderabad House', 'Dhobighat branch', 
        'The world-famous Indian Dum Biryani restaurant.',
        4443839, empty_blob(), 620, 'Kathmandu', 'Dhobighat')
        
    INTO restaurant (id, name, branch, bio, phone, displayPhoto, costfortwo, city, street)
    VALUES
        (5, 'Roadhouse Cafe', 'Thamel branch', 
        'The café serves multiple cuisines but is widely known for its wood fired Pizza.',
        5367885, empty_blob(), 800, 'Kathmandu', 'Thamel')
        
    INTO restaurant (id, name, branch, bio, phone, displayPhoto, costfortwo, city, street)
    VALUES
        (6, 'Piano B', 'Patan branch', 
        '100% authentic Italian restaurant in Patan.',
        9813014070, empty_blob(), 1000, 'Lalitpur', 'Bhanimandal')
    
    INTO restaurant (id, name, branch, bio, phone, displayPhoto, costfortwo, city, street)
    VALUES
        (7, 'Chow Bella', 'main', 
        'Chow Bella at Akama Hotel, the new rooftop restaurant is all set to give Kathmandu the food experience of a lifetime',
        9851276525, empty_blob(), 1000, 'Kathmandu', 'Dhumbarahi')
    
    INTO restaurant (id, name, branch, bio, phone, displayPhoto, costfortwo, city, street)
    VALUES
        (8, 'French House Restaurant', 'main', 
        'French house stands for new french-asian fusion in food.',
        4411955, empty_blob(), 650, 'Kathmandu', 'Naxal')
        
SELECT 1 FROM DUAL;


-- Add images to restaurant items
-- Reference: https://oracle-base.com/articles/8i/import-blob

-- First a directory object is created to point to the relevant filesystem directory.
CREATE OR REPLACE DIRECTORY BLOB_DIR AS 'C:\Users\Dee Jung\source\blobfiles';

-- Create procedure for importing the file into a BLOB datatype and 
-- insert it into the table.
CREATE OR REPLACE PROCEDURE file_to_blob (p_blob      IN OUT NOCOPY BLOB,
                                          p_dir       IN  VARCHAR2,
                                          p_filename  IN  VARCHAR2)
AS
  l_bfile  BFILE;

  l_dest_offset INTEGER := 1;
  l_src_offset  INTEGER := 1;
BEGIN
  l_bfile := BFILENAME(p_dir, p_filename);
  DBMS_LOB.fileopen(l_bfile, DBMS_LOB.file_readonly);
  DBMS_LOB.trim(p_blob, 0);
  IF DBMS_LOB.getlength(l_bfile) > 0 THEN
    DBMS_LOB.loadblobfromfile (
      dest_lob    => p_blob,
      src_bfile   => l_bfile,
      amount      => DBMS_LOB.lobmaxsize,
      dest_offset => l_dest_offset,
      src_offset  => l_src_offset);
  END IF;
  DBMS_LOB.fileclose(l_bfile);
END file_to_blob;


-- Call procedure for each restaurant.
DECLARE
  l_blob   BLOB;
BEGIN
  -- French Creperie Kathmandu
  SELECT displayPhoto
  INTO   l_blob
  FROM   restaurant
  WHERE  name = 'French Creperie Kathmandu'
  FOR UPDATE;

  file_to_blob (p_blob     => l_blob,
                p_dir      => 'BLOB_DIR',
                p_filename => 'frenchCreperie.jpg');

  -- The Village Cafe        
  SELECT displayPhoto
  INTO   l_blob
  FROM   restaurant
  WHERE  name = 'The Village Cafe'
  FOR UPDATE;

  file_to_blob (p_blob     => l_blob,
                p_dir      => 'BLOB_DIR',
                p_filename => 'villageCafe.jpg');

  -- Achaar Ghar                    
  SELECT displayPhoto
  INTO   l_blob
  FROM   restaurant
  WHERE  name = 'Achaar Ghar'
  FOR UPDATE;

  file_to_blob (p_blob     => l_blob,
                p_dir      => 'BLOB_DIR',
                p_filename => 'achaar-ghar.jpg');

  -- Hyderabad House Kathmandu
  SELECT displayPhoto
  INTO   l_blob
  FROM   restaurant
  WHERE  name = 'Hyderabad House'
  FOR UPDATE;

  file_to_blob (p_blob     => l_blob,
                p_dir      => 'BLOB_DIR',
                p_filename => 'hyderabad-house.jpg');

  -- Roadhouse Cafe Kathmandu
  SELECT displayPhoto
  INTO   l_blob
  FROM   restaurant
  WHERE  name = 'Roadhouse Cafe'
  FOR UPDATE;

  file_to_blob (p_blob     => l_blob,
                p_dir      => 'BLOB_DIR',
                p_filename => 'roadhouse-cafe.jpg');

  -- Piano B Kathmandu
  SELECT displayPhoto
  INTO   l_blob
  FROM   restaurant
  WHERE  name = 'Piano B'
  FOR UPDATE;

  file_to_blob (p_blob     => l_blob,
                p_dir      => 'BLOB_DIR',
                p_filename => 'pianob.jpg');

  -- Chow Bella Kathmandu
  SELECT displayPhoto
  INTO   l_blob
  FROM   restaurant
  WHERE  name = 'Chow Bella'
  FOR UPDATE;

  file_to_blob (p_blob     => l_blob,
                p_dir      => 'BLOB_DIR',
                p_filename => 'chowBella.png');

  -- French House Restaurant Kathmandu
  SELECT displayPhoto
  INTO   l_blob
  FROM   restaurant
  WHERE  name = 'French House Restaurant'
  FOR UPDATE;

  file_to_blob (p_blob     => l_blob,
                p_dir      => 'BLOB_DIR',
                p_filename => 'french-house-restaurant.jpg');
END;


-- Cuisine Item table

INSERT ALL
    INTO cuisineitem (id, restaurant_id, cuisine_id) VALUES (1, 1, 5)
    INTO cuisineitem (id, restaurant_id, cuisine_id) VALUES (2, 2, 1)
    INTO cuisineitem (id, restaurant_id, cuisine_id) VALUES (3, 3, 1)
    INTO cuisineitem (id, restaurant_id, cuisine_id) VALUES (4, 4, 2)
    INTO cuisineitem (id, restaurant_id, cuisine_id) VALUES (5, 5, 4)
    INTO cuisineitem (id, restaurant_id, cuisine_id) VALUES (6, 6, 4)
    INTO cuisineitem (id, restaurant_id, cuisine_id) VALUES (7, 6, 3)
    INTO cuisineitem (id, restaurant_id, cuisine_id) VALUES (8, 7, 3)
    INTO cuisineitem (id, restaurant_id, cuisine_id) VALUES (9, 8, 3)
    INTO cuisineitem (id, restaurant_id, cuisine_id) VALUES (10, 8, 5)
SELECT 1 FROM DUAL;

-- MenuItem table
SET ESCAPE '\'
INSERT ALL
    INTO menuitem (id, rate, displayname, dietcategory, description, displayphoto, isavailable, dish_id, restaurant_id)
    VALUES 
        (1, 450.00, 'Nutella Crêpe', 'Veg', 'Crêpe au Nutella',
        empty_blob(), 1, 11, 1)
    INTO menuitem (id, rate, displayname, dietcategory, description, displayphoto, isavailable, dish_id, restaurant_id)
    VALUES 
        (2, 300.00, 'Lemon sugar Crêpe', 'Veg', 'Crêpe au sucre et au citron',
        empty_blob(), 1, 11, 1)
    INTO menuitem (id, rate, displayname, dietcategory, description, displayphoto, isavailable, dish_id, restaurant_id)
    VALUES 
        (3, 1000.00, 'Lobster Bisque Bowl', 'Non-veg', 'Lobster tails, white wine, heavy cream, tomato paste, lobster',
        empty_blob(), 1, 12, 1)
    INTO menuitem (id, rate, displayname, dietcategory, description, displayphoto, isavailable, dish_id, restaurant_id)
    VALUES 
        (4, 200.00, 'Sugar Crêpe', 'Veg', 'Crêpe sucrée',
        empty_blob(), 1, 11, 1)
    INTO menuitem (id, rate, displayname, dietcategory, description, displayphoto, isavailable, dish_id, restaurant_id)
    VALUES 
        (5, 225.00, 'Chicken Momo', 'Non-veg', 'Momo is a type of steamed dumpling with some form of filling.',
        empty_blob(), 1, 1, 2)
    INTO menuitem (id, rate, displayname, dietcategory, description, displayphoto, isavailable, dish_id, restaurant_id)
    VALUES 
        (6, 225.00, 'Veg Momo', 'Veg', 'Momo is a type of steamed dumpling with some form of filling.',
        empty_blob(), 1, 1, 2)
    INTO menuitem (id, rate, displayname, dietcategory, description, displayphoto, isavailable, dish_id, restaurant_id)
    VALUES 
        (7, 50.00, 'Sel Roti', 'Veg', 'A traditional homemade ring-shaped rice bread originating from Nepal which is sweet in taste.',
        empty_blob(), 1, 6, 2)
    INTO menuitem (id, rate, displayname, dietcategory, description, displayphoto, isavailable, dish_id, restaurant_id)
    VALUES 
        (8, 695.00, 'Masu Dal Bhat', 'Non-veg', 'It consists of steamed rice and a cooked lentil soup called dal.',
        empty_blob(), 1, 2, 2)
    INTO menuitem (id, rate, displayname, dietcategory, description, displayphoto, isavailable, dish_id, restaurant_id)
    VALUES 
        (9, 300.00, 'Momo Chicken', 'Non-veg', 'Momo is a type of steamed dumpling with some form of filling.',
        empty_blob(), 1, 1, 3)
    INTO menuitem (id, rate, displayname, dietcategory, description, displayphoto, isavailable, dish_id, restaurant_id)
    VALUES 
        (10, 250.00, 'Momo Veg', 'Veg', 'Momo is a type of steamed dumpling with some form of filling.',
        empty_blob(), 1, 1, 3)
    INTO menuitem (id, rate, displayname, dietcategory, description, displayphoto, isavailable, dish_id, restaurant_id)
    VALUES 
        (11, 600.00, 'Mutton DBT', 'Non-veg', 'Served with Dessert ( Sikarni ) and Pickles',
        empty_blob(), 1, 2, 3)
    INTO menuitem (id, rate, displayname, dietcategory, description, displayphoto, isavailable, dish_id, restaurant_id)
    VALUES 
        (12, 500.00, 'Chicken DBT', 'Non-veg', 'Served with Dessert ( Sikarni ) and Pickles',
        empty_blob(), 1, 2, 3)
    INTO menuitem (id, rate, displayname, dietcategory, description, displayphoto, isavailable, dish_id, restaurant_id)
    VALUES 
        (13, 400.00, 'Vegetarian DBT', 'Veg', 'Served with Dessert ( Sikarni ) and Pickles',
        empty_blob(), 1, 2, 3)
    INTO menuitem (id, rate, displayname, dietcategory, description, displayphoto, isavailable, dish_id, restaurant_id)
    VALUES 
        (14, 675.00, 'Chicken Dumpukht Biryani Single', 'Non-veg', 'Traditional dumpukht biryani with the best of with bone chicken with basmati rice',
        empty_blob(), 1, 5, 4)
    INTO menuitem (id, rate, displayname, dietcategory, description, displayphoto, isavailable, dish_id, restaurant_id)
    VALUES 
        (15, 480.00, 'Egg Biryani Single', 'Veg', 'Traditional biryani preparation with egg and basmati rice.',
        empty_blob(), 1, 5, 4)
    INTO menuitem (id, rate, displayname, dietcategory, description, displayphoto, isavailable, dish_id, restaurant_id)
    VALUES 
        (16, 765.00, 'Gosht Dumpukht Biryani Single', 'Non-veg', 'Traditional dumpukht biryani with the best of tender mutton with basmati rice.',
        empty_blob(), 1, 5, 4)
    INTO menuitem (id, rate, displayname, dietcategory, description, displayphoto, isavailable, dish_id, restaurant_id)
    VALUES 
        (17, 90.00, 'Butter Naan', 'Veg', 'Naan is a leavened flatbread mostly cooked in a tandoor.',
        empty_blob(), 1, 7, 4)
    INTO menuitem (id, rate, displayname, dietcategory, description, displayphoto, isavailable, dish_id, restaurant_id)
    VALUES 
        (18, 115.00, 'Garlic Naan', 'Veg', 'Naan is a leavened flatbread mostly cooked in a tandoor.',
        empty_blob(), 1, 7, 4)
    INTO menuitem (id, rate, displayname, dietcategory, description, displayphoto, isavailable, dish_id, restaurant_id)
    VALUES 
        (19, 820.00, 'Barbequed Pulled Pork', 'Non-veg', 'Pulled pork, barbeque sauce, pineapple, jalapenos \& bell pepper',
        empty_blob(), 1, 3, 5)
    INTO menuitem (id, rate, displayname, dietcategory, description, displayphoto, isavailable, dish_id, restaurant_id)
    VALUES 
        (20, 870.00, 'Basilico Chicken', 'Non-veg', 'Rocket leaves, sundried tomatoes \& parmesan shaves',
        empty_blob(), 1, 3, 5)
    INTO menuitem (id, rate, displayname, dietcategory, description, displayphoto, isavailable, dish_id, restaurant_id)
    VALUES 
        (21, 720.00, 'Hawaiian', 'Non-veg', 'Tomato, mozzarella, ham \& pineapple',
        empty_blob(), 1, 3, 5)
    INTO menuitem (id, rate, displayname, dietcategory, description, displayphoto, isavailable, dish_id, restaurant_id)
    VALUES 
        (22, 810.00, 'Four Cheese', 'Veg', 'Mozzarella, yak cheese, Parmesan and cheddar cheese',
        empty_blob(), 1, 3, 5)
    INTO menuitem (id, rate, displayname, dietcategory, description, displayphoto, isavailable, dish_id, restaurant_id)
    VALUES 
        (23, 600.00, 'Spaghetti Tomato \& Basil Non Veg', 'Non-veg', 'Imported Tomato Sauce With Fresh Basil Or Smoked Chicken Topped With Parmesan Shaving \& Evoo',
        empty_blob(), 1, 4, 5)
    INTO menuitem (id, rate, displayname, dietcategory, description, displayphoto, isavailable, dish_id, restaurant_id)
    VALUES 
        (24, 600.00, 'Roadhouse Special Non Veg', 'Non-veg', 'Penne Pasta, Smoked Chicken, Sun Dried Tomatoes, Capers, Black Olives \& Feta Cheese',
        empty_blob(), 1, 4, 5)
    INTO menuitem (id, rate, displayname, dietcategory, description, displayphoto, isavailable, dish_id, restaurant_id)
    VALUES 
        (25, 715.00, 'Margherita Pizza', 'Veg', 'Mozzarella, yak cheese, Parmesan and cheddar cheese',
        empty_blob(), 1, 3, 6)
    INTO menuitem (id, rate, displayname, dietcategory, description, displayphoto, isavailable, dish_id, restaurant_id)
    VALUES 
        (26, 495.00, 'Vegetarian Mo:Mo', 'Veg', 'Spinach, roasted tomatoes, ricotta and mozzarella momo',
        empty_blob(), 1, 1, 6)
    INTO menuitem (id, rate, displayname, dietcategory, description, displayphoto, isavailable, dish_id, restaurant_id)
    VALUES 
        (27, 495.00, 'Chicken Mo:Mo', 'Non-veg', 'Chicken mince, ricotta and mozzarella momo',
        empty_blob(), 1, 1, 6)
    INTO menuitem (id, rate, displayname, dietcategory, description, displayphoto, isavailable, dish_id, restaurant_id)
    VALUES 
        (28, 1250.00, 'Pasta Al Salmone', 'Non-veg', 'Pasta with black olives, capers, roasted tomatoes and Norwegian salmon fillet',
        empty_blob(), 1, 4, 6)
    INTO menuitem (id, rate, displayname, dietcategory, description, displayphoto, isavailable, dish_id, restaurant_id)
    VALUES 
        (29, 495.00, 'Dal-Bhaat', 'Non-veg', 'Italian Carnaroli rice balls filled with saag, tarkari, dal, mushrooms or chicken curry',
        empty_blob(), 1, 2, 6)
    INTO menuitem (id, rate, displayname, dietcategory, description, displayphoto, isavailable, dish_id, restaurant_id)
    VALUES 
        (30, 450.00, 'Fried Rice Veg', 'Veg', 'Long grain basmati rice fried tempered with vegetables',
        empty_blob(), 1, 9, 7)
    INTO menuitem (id, rate, displayname, dietcategory, description, displayphoto, isavailable, dish_id, restaurant_id)
    VALUES 
        (31, 695.00, 'Fried Rice Non-Veg', 'Non-veg', 'Long grain basmati rice fried tempered with choice of prawns or chicken',
        empty_blob(), 1, 9, 7)
    INTO menuitem (id, rate, displayname, dietcategory, description, displayphoto, isavailable, dish_id, restaurant_id)
    VALUES 
        (32, 450.00, 'Hakka Fried Noodle Veg', 'Veg', 'Shredded vegetables \& noodle stir fried with vegetables',
        empty_blob(), 1, 8, 7)
    INTO menuitem (id, rate, displayname, dietcategory, description, displayphoto, isavailable, dish_id, restaurant_id)
    VALUES 
        (33, 695.00, 'Hakka Fried Noodle Non-veg', 'Non-veg', 'Shredded vegetables \& eggs noodle stir fried with choice of prawns or chicken',
        empty_blob(), 1, 8, 7)
    INTO menuitem (id, rate, displayname, dietcategory, description, displayphoto, isavailable, dish_id, restaurant_id)
    VALUES 
        (34, 250.00, 'Chicken Steam Momo', 'Non-veg', 'Chicken Momo',
        empty_blob(), 1, 1, 8)
    INTO menuitem (id, rate, displayname, dietcategory, description, displayphoto, isavailable, dish_id, restaurant_id)
    VALUES 
        (35, 250.00, 'Chicken Fry Rice', 'Non-veg', 'Chicken Fried Rice',
        empty_blob(), 1, 9, 8)
    INTO menuitem (id, rate, displayname, dietcategory, description, displayphoto, isavailable, dish_id, restaurant_id)
    VALUES 
        (36, 550.00, 'Classic Nicoise Salad', 'Non-veg', 'Tomatoes, hard-boiled eggs, Niçoise olives and anchovies or tuna, dressed with olive oil.',
        empty_blob(), 1, 10, 8)
SELECT 1 FROM DUAL;


-- User table

INSERT ALL
    INTO "User" (id, username, phone, email, password, redeemedloyalty)
    VALUES 
        (1, 'deejung', 9803824042, 'deejung.xyz@gmail.com', 'devpassword', 0)
        
    INTO "User" (id, username, phone, email, password, redeemedloyalty)
    VALUES 
        (2, 'lizasimpson', 9843321210, 'simpson.liza@gmail.com', 'bartsucks', 0)
    
    INTO "User" (id, username, phone, email, password, redeemedloyalty)
    VALUES 
        (3, 'mogwai', 98877889988, 'sundown@protonmail.com', 'countrysun', 0)
    
    INTO "User" (id, username, phone, email, password, redeemedloyalty)
    VALUES 
        (4, 'potato', 98456374885, 'mcwhiskey@gmail.com', 'civ32dde5y', 0)
    
    INTO "User" (id, username, phone, email, password, redeemedloyalty)
    VALUES 
        (5, 'timgolding', 98467888832, 'goldberg95@yahoo.com', 'goldsilver', 0)
SELECT 1 FROM DUAL;


-- User Address

INSERT ALL
    INTO useraddress (id, longitude, latitude, city, street, landmarks, user_id)
    VALUES 
        (1, 27.715452, 85.308811, 'Kathmandu', 'Paknajol Marg', 'Himalayan Arabica Beans Coffee', 1)
    INTO useraddress (id, longitude, latitude, city, street, landmarks, user_id)
    VALUES 
        (2, 27.6783848, 85.318499, 'Lalitpur', 'Jawalakhel', 'Herman Bakery', 2)
    INTO useraddress (id, longitude, latitude, city, street, landmarks, user_id)
    VALUES 
        (3, 27.7036139, 85.3512307, 'Kathmandu', 'Devkota Sadak', 'Global College International', 3)
    INTO useraddress (id, longitude, latitude, city, street, landmarks, user_id)
    VALUES 
        (4, 27.6782819, 85.3215574, 'Lalitpur', 'Patan Dhoka', 'Patan Book Shop', 4)
    INTO useraddress (id, longitude, latitude, city, street, landmarks, user_id)
    VALUES 
        (5, 27.701579, 85.310524, 'Kathmandu', 'Sundhara Marg', 'Kathmandu Mall', 5)
SELECT 1 FROM DUAL;

-- Loyalty Point

INSERT ALL
    INTO loyaltypoint (id, points, status, activefrom, activeuntil, menuitem_id)
    VALUES 
        (1, 100, 'active', CURRENT_TIMESTAMP, TIMESTAMP '2021-04-07 2:00:00', 3)
    INTO loyaltypoint (id, points, status, activefrom, activeuntil, menuitem_id)
    VALUES 
        (2, 25, 'active', CURRENT_TIMESTAMP, TIMESTAMP '2021-04-15 2:00:00', 9)
    INTO loyaltypoint (id, points, status, activefrom, activeuntil, menuitem_id)
    VALUES 
        (3, 50, 'active', CURRENT_TIMESTAMP, TIMESTAMP '2021-05-02 2:00:00', 16)
    INTO loyaltypoint (id, points, status, activefrom, activeuntil, menuitem_id)
    VALUES 
        (4, 60, 'archived', TIMESTAMP '2021-02-01 2:00:00', TIMESTAMP '2021-03-07 2:00:00', 24)
    INTO loyaltypoint (id, points, status, activefrom, activeuntil, menuitem_id)
    VALUES 
        (5, 10, 'active', TIMESTAMP '2021-03-04 2:00:00', TIMESTAMP '2021-04-01 2:00:00', 30)
SELECT 1 FROM DUAL;

-- Order

INSERT ALL
    INTO "Order" (id, serialnumber, ordertotal, orderstatus, paymentstatus, creationdate, loyaltyscore, user_id)
    VALUES 
        (1, 120, 1225.00, 'completed', 'completed', TIMESTAMP '2021-03-05 16:00:00', 25, 1)
    INTO "Order" (id, serialnumber, ordertotal, orderstatus, paymentstatus, creationdate, loyaltyscore, user_id)
    VALUES 
        (2, 155, 500.00, 'canceled', 'voided', TIMESTAMP '2021-03-05 16:00:00', 10, 2)
    INTO "Order" (id, serialnumber, ordertotal, orderstatus, paymentstatus, creationdate, loyaltyscore, user_id)
    VALUES 
        (3, 225, 700.00, 'completed', 'completed', TIMESTAMP '2021-03-06 16:00:00', 0, 3)
    INTO "Order" (id, serialnumber, ordertotal, orderstatus, paymentstatus, creationdate, loyaltyscore, user_id)
    VALUES 
        (4, 226, 1250.00, 'completed', 'processed', TIMESTAMP '2021-03-10 16:00:00', 50, 1)
    INTO "Order" (id, serialnumber, ordertotal, orderstatus, paymentstatus, creationdate, loyaltyscore, user_id)
    VALUES 
        (5, 285, 715.00, 'shipped', 'pending', TIMESTAMP '2021-03-11 16:00:00', 100, 4)
    INTO "Order" (id, serialnumber, ordertotal, orderstatus, paymentstatus, creationdate, loyaltyscore, user_id)
    VALUES 
        (6, 298, 1390.00, 'awaiting', 'pending', TIMESTAMP '2021-03-11 16:00:00', 0, 5)
SELECT 1 FROM DUAL;

-- Line Item

INSERT ALL
    INTO lineitem (id, quantity, itemtotal, order_id, menuitem_id)
    VALUES 
        (1, 1, 1000.00, 1, 3)
    INTO lineitem (id, quantity, itemtotal, order_id, menuitem_id)
    VALUES 
        (2, 1, 225.00, 1, 5)
    INTO lineitem (id, quantity, itemtotal, order_id, menuitem_id)
    VALUES
        (3, 2, 500.00, 2, 10)
    INTO lineitem (id, quantity, itemtotal, order_id, menuitem_id)
    VALUES 
        (4, 1, 450.00, 3, 32)
    INTO lineitem (id, quantity, itemtotal, order_id, menuitem_id)
    VALUES 
        (5, 1, 250.00, 3, 34)
    INTO lineitem (id, quantity, itemtotal, order_id, menuitem_id)
    VALUES 
        (6, 1, 1250.00, 4, 28)
    INTO lineitem (id, quantity, itemtotal, order_id, menuitem_id)
    VALUES 
        (7, 1, 715.00, 5, 25)
    INTO lineitem (id, quantity, itemtotal, order_id, menuitem_id)
    VALUES 
        (8, 2, 695.00, 6, 8)
SELECT 1 FROM DUAL;

-- Delivery

INSERT ALL
    INTO delivery (id, deliverystage, assignedagent, "date", order_id)
    VALUES (1, 'complete', 'Motonepal', DATE '2021-03-05', 1)
    INTO delivery (id, deliverystage, assignedagent, "date", order_id)
    VALUES (2, 'canceled', 'Motonepal', DATE '2021-03-05', 2)
    INTO delivery (id, deliverystage, assignedagent, "date", order_id)
    VALUES (3, 'complete', 'Motonepal', DATE '2021-03-06', 3)
    INTO delivery (id, deliverystage, assignedagent, "date", order_id)
    VALUES (4, 'complete', 'Motonepal', DATE '2021-03-10', 4)
    INTO delivery (id, deliverystage, assignedagent, "date", order_id)
    VALUES (5, 'shipping', 'Motonepal', DATE '2021-03-11', 5)
    INTO delivery (id, deliverystage, assignedagent, "date", order_id)
    VALUES (6, 'picking', 'Motonepal', DATE '2021-03-11', 6)
SELECT 1 FROM DUAL;

-- Delivery address

INSERT ALL
    INTO deliveryaddress (id, longitude, latitude, city, street, landmarks, delivery_id)
    VALUES 
        (1, 27.715452, 85.308811, 'Kathmandu', 'Paknajol Marg', 'Himalayan Arabica Beans Coffee', 1)
    INTO deliveryaddress (id, longitude, latitude, city, street, landmarks, delivery_id)
    VALUES 
        (2, 27.6783848, 85.318499, 'Lalitpur', 'Jawalakhel', 'Herman Bakery', 2)
    INTO deliveryaddress (id, longitude, latitude, city, street, landmarks, delivery_id)
    VALUES
        (3, 27.7036139, 85.3512307, 'Kathmandu', 'Devkota Sadak', 'Global College International', 3)
    INTO deliveryaddress (id, longitude, latitude, city, street, landmarks, delivery_id)
    VALUES 
        (4, 27.715452, 85.308811, 'Kathmandu', 'Paknajol Marg', 'Himalayan Arabica Beans Coffee', 4)
    INTO deliveryaddress (id, longitude, latitude, city, street, landmarks, delivery_id)
    VALUES 
        (5, 27.6782819, 85.3215574, 'Lalitpur', 'Patan Dhoka', 'Patan Book Shop', 5)
    INTO deliveryaddress (id, longitude, latitude, city, street, landmarks, delivery_id)
    VALUES 
        (6, 27.701579, 85.310524, 'Kathmandu', 'Sundhara Marg', 'Kathmandu Mall', 6)
SELECT 1 FROM DUAL;

