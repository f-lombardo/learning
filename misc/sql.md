# Some useful SQL commands

## Oracle specific
To know when a row was updated you can use the Oracle System Change Number 

`SELECT SCN_TO_TIMESTAMP(ora_rowscn), MY_TABLE.*
 FROM MYTABLE`
