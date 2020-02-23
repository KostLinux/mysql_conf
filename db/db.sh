
#!/bin/bash
#DB_Name can be random
db_name=''
#DB_Table is db table name
db_table=''
#DB_info should be concrete, for example: (id INT, name VARCHAR(20), email VARCHAR(20) );
db_info='' 

echo "Your database name is: $db_name"
echo "Your table name is:$table_name"
echo "Your table architecture is: $db_info"

mysql -u root << EOF
create database $db_name;
use $db_name;
create table $db_table $db_info;
EOF

read -p 'Do you want to import file? <y/n>' confirm
if [[ $confirm == "y" || $confirm == "Y" || $confirm == "yes" || $confirm == "Yes" ]]
then
echo 'Importing file to mysql...'
read -p 'Please insert file name: ' filename

mysql -u root << EOF
use $db_name
LOAD DATA LOCAL INFILE "$filename"
INTO $db_table
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
;
EOF

else
	echo "Thanks for using script"
	echo "Exiting... "
fi

