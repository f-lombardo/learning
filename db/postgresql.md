# Notes on PostgreSQL

## Backup and restore
To execute a backup we can use `pg_dump`:

```shell
pg_dump -h mySourceHost -U myUser --create --clean  -f myDB.dump myDB
```

Here is the meaning of the options:

`-h` and `-U`: connection options for host and user.
`--create`: add statements for creating database in the dump
`--clean`: add statements to drop database objects 
`-f`: indicates the destination file of the dump

Please note that:
1. The command can be run toward a database that has the same or a lower version than the command itself. 
If `pg_dump` has a higher version, the dump file could include some commands that are not compatible with the version of the source DB.
2. The above switches produce a dump file in textual version. This allows you to edit incompatible commands that could be possibly included.
3. The dump does not include the statement for creating users, so you must create them manually in the target DB, if they are not present. 
To export also user profiles you can use `pg_dumpall`.

To restore dumps in textual form you have to run:
```shell
psql -h myDestinationHost -U myUser -f myDB.dump template1
```

Please note that the final database name is not the one that we would like to restore, but just a default database we need for initial connection of `psql`.
This holds for `pg_restore` command too! 
Be prepared to edit the dump file to remove incompatible statements if the version of the target database does not match the version of the `pg_dump` program used to make the backup

## Performances

Here is a sample database for tests https://github.com/devrimgunduz/pagila

Tip: don't join views, since this will make the syntax tree more complicated.

`EXPLAIN`: explains the query without executing it
`EXPLAIN ANALYZE`: runs the query and explains it

`LIMIT` clause just limits data provided to the user, but it performs table scans anyway.

Indexes are often not used for clauses like `FIELD > 123`

`CREATE STATISTICS` creates a table with more statistics on a set of columns of a table. It would be useful to tell PostgreSQL that
there is some sort of relationship in data of the selected fields.

`SELECT * FROM pg_stat_all_tables WHERE relname='my_table'`
`SELECT * FROM pg_stat_all_indexes WHERE relname='my_table'` -> if number of index scans is low we can drop the index

For PG it's better to have few powerful cores than many low performance cores.

`VACUUM` command identifies expired records and frees their space. It can be used with the wrapping program `vacuumdb`.

`VACUUM FULL` creates a new table and copies the valid records in it. It locks the table during the operation. Run it only if you're running out of disk space.

`ANALYZE my_table` collects statistics on the selected table.