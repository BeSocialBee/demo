from flask import Flask
import mysql.connector
from flask_cors import CORS


app = Flask(__name__)
CORS(app)

# MySQL database configuration
db_config = {
    'host': 'database-3.ciqpxqolslw4.eu-north-1.rds.amazonaws.com',
    'user': 'master',
    'password': 'masterpassword',
    'database': 'beedatabase',
    'port': 3306,
}

# Create a MySQL connection
db_connection = mysql.connector.connect(**db_config)
cursor = db_connection.cursor()



##############################################################
#                 CREATE TABLES FOR DATABASE                 #                
##############################################################

create_table_query = """
CREATE TABLE IF NOT EXISTS users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255),
    password VARCHAR(255),
    isAdmin VARCHAR(5) DEFAULT "NO"
);
"""
cursor.execute(create_table_query)
# Commit the changes to the database
db_connection.commit()

##############################################################

# Generate MySQL table if not exists
create_table_query = """
CREATE TABLE IF NOT EXISTS collections(
    collectionName varchar(100) PRIMARY KEY,
    collection_id INT UNIQUE KEY
);
"""
cursor.execute(create_table_query)
# Commit the changes to the database
db_connection.commit()

##############################################################

# Generate MySQL table if not exists
create_table_query = """
CREATE TABLE IF NOT EXISTS avatars(
    avatar_id INT AUTO_INCREMENT PRIMARY KEY,
    fileURL varchar(200)
);
"""
cursor.execute(create_table_query)
# Commit the changes to the database
db_connection.commit()

##############################################################

# Generate MySQL table if not exists
create_table_query = """
CREATE TABLE IF NOT EXISTS cards(
    card_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    description TEXT NOT NULL,
    price FLOAT NOT NULL,
    date DATETIME DEFAULT CURRENT_TIMESTAMP,
    filename VARCHAR(200) NOT NULL,
    fileURL VARCHAR(200) NOT NULL,
    filepath VARCHAR(200) NOT NULL,
    collectionName varchar(100) NOT NULL,
    rarity varchar(100) NOT NULL,
    quantity INT NOT NULL,
    FOREIGN KEY (collectionName) REFERENCES collections(collectionName)
);
"""
cursor.execute(create_table_query)
# Commit the changes to the database
db_connection.commit()

##############################################################

# Generate MySQL table if not exists
create_table_query = """
CREATE TABLE IF NOT EXISTS usersprofiles(
    profile_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    email VARCHAR(100) NOT NULL,
    username VARCHAR(100) NOT NULL,
    date DATETIME DEFAULT CURRENT_TIMESTAMP,
    avatar_id INT DEFAULT 1,
    balance FLOAT DEFAULT 1000,
    score INT DEFAULT 0,
    showcase_card INT,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (showcase_card) REFERENCES cards(card_id),
    FOREIGN KEY (avatar_id) REFERENCES avatars(avatar_id)
);
"""
cursor.execute(create_table_query)
# Commit the changes to the database
db_connection.commit()

##############################################################

# Generate MySQL table if not exists
create_table_query = """
CREATE TABLE IF NOT EXISTS usercards(
    user_id INT,
    card_id INT,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (card_id) REFERENCES cards(card_id)
);
"""
cursor.execute(create_table_query)
# Commit the changes to the database
db_connection.commit()

##############################################################

# Generate MySQL table if not exists
create_table_query = """
CREATE TABLE IF NOT EXISTS dailyspin(
    reward_id INT AUTO_INCREMENT PRIMARY KEY,
    reward_coin FLOAT DEFAULT 0.0,
    reward_card_id INT,
    reward_text varchar(100),
    FOREIGN KEY (reward_card_id) REFERENCES cards(card_id)
);
"""
cursor.execute(create_table_query)
# Commit the changes to the database
db_connection.commit()

##############################################################

# Generate MySQL table if not exists
create_table_query = """
CREATE TABLE IF NOT EXISTS achievements(
    achievement_id INT AUTO_INCREMENT PRIMARY KEY,
    title varchar(250) NOT NULL,
    description TEXT NOT NULL,
    cards_reward INT,
    price_reward FLOAT DEFAULT 0.0,
    FOREIGN KEY (cards_reward) REFERENCES cards(card_id)
);
"""
cursor.execute(create_table_query)
# Commit the changes to the database
db_connection.commit()

##############################################################

# Generate MySQL table if not exists
create_table_query = """
CREATE TABLE IF NOT EXISTS userachievements(
    profile_id INT,
    achievement_id INT,
    FOREIGN KEY (profile_id) REFERENCES usersprofiles(profile_id),
    FOREIGN KEY (achievement_id) REFERENCES achievements(achievement_id)
);
"""
cursor.execute(create_table_query)
# Commit the changes to the database
db_connection.commit()

##############################################################

# Generate MySQL table if not exists
create_table_query = """
CREATE TABLE IF NOT EXISTS auctionMarket(
    card_id INT,
    user_id INT,
    startingDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    endingDate DATETIME NOT NULL,
    startingPrice float,
    currentBid float,
    bid_user_id INT,
    FOREIGN KEY (card_id) REFERENCES cards(card_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (bid_user_id) REFERENCES users(user_id)
);
"""
cursor.execute(create_table_query)
# Commit the changes to the database
db_connection.commit()

##############################################################

# Generate MySQL table if not exists
create_table_query = """
CREATE TABLE IF NOT EXISTS fixedPriceMarket(
    card_id INT,
    user_id INT,
    currentPrice float,
    FOREIGN KEY (card_id) REFERENCES cards(card_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);
"""
cursor.execute(create_table_query)
# Commit the changes to the database
db_connection.commit()