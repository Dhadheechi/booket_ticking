# booket_ticking

### Superuser-password

billy_56 - 1234@asdf (Bhuvan)

# database config
## From terminal

mysql -u root -p

CREATE DATABASE Booket_Ticking;

USE Booket_Ticking;

SOURCE /path/to/booket_ticking_dump.sql;


#in .env

DB_NAME=event_ticket_db

DB_USER=root

DB_PASSWORD=your_new_password

DB_HOST=localhost

DB_PORT=3306
