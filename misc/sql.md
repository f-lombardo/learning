# Some useful SQL commands

## MySQL specific
### Using MySQL Fulltext search for finding users by full name (first name and last name)

```sql 
CREATE FULLTEXT INDEX fx_name ON users (firstName, lastName);
```

If you're using TypeORM you can use the following annotation on the User entity:

```typescript
@Entity()
@Index(['firstName', 'lastName'], { fulltext: true })
export class User {
```

Then the search query:

```sql
SELECT  id , firstName , lastName , fiscalCode 
FROM    users 
WHERE   MATCH(firstName ,lastName) AGAINST ('+rossi +mario' IN BOOLEAN MODE)
```

If you want to have a "starts with" match, you can add an asterisk at the end of searching terms. For example:
```sql
SELECT  id , firstName , lastName , fiscalCode 
FROM    users 
WHERE   MATCH(firstName ,lastName) AGAINST ('+rossi* +mario*' IN BOOLEAN MODE)
```

This query would find 'Mario Rossi', 'Mariolino Rossi' ad 'Mario Rossini'.

### How to overcome MySQL error 1093 'you can’t specify target table for update in from clause'
Running the following in Mysql query gives error 1093 'you can’t specify target table for update in from clause'
```sql
UPDATE
	company c1
SET
	c1.validFrom = '1999-01-01 00:00:00'
WHERE
	NOT EXISTS (
	SELECT
		1
	FROM
		company c2
	WHERE
		c2.id = c1.id
		AND c2.validFrom < c1.validFrom)
```
This error can be overcome substituting the real table `company` in the `EXISTS` clause with a `SELECT`:
```sql
UPDATE
	company c1
SET
	c1.validFrom = '1999-01-01 00:00:00'
WHERE
	NOT EXISTS (
	SELECT
		1
	FROM
		(SELECT * FROM company) c2
	WHERE
		c2.id = c1.id
		AND c2.validFrom < c1.validFrom)
```


## Oracle specific
To know when a row was updated you can use the Oracle System Change Number 

```sql
SELECT SCN_TO_TIMESTAMP(ora_rowscn), MY_TABLE.*
FROM MYTABLE
```

## PostgreSQL specific
### How to extract data from a JSON field
```sql
select trim( '"' from (my_json_field::json->'my_property')::text) 
from my_table
```
### General notes on PostgreSQL
PostgreSQL does not allow queries that use table from multiple DB. There are some Default DBs 
- `template1` is the default template for new databases. If you add some table or objects there, they will be also created in new databases.
- `template0` is a readonly template that can be used to create new databases that have a different language from `template1`
- `postgres` is a default general purpose database that can be deleted.

- template0: usato per DB con collating differenti
- tablespaces: possibile dividere dischi per tabelle e indici
- \d -> describe
- \l -> list dbs\
- pg_toast: DB che contiene le colonne > 8kB
- schema pg_temp -> ~QTEMP
- SET search_path = test, public
- SET role = a_user (cmabia CURRENT_USER, non SESSION_USER)
- SET role = default
- MVCC -> updates = delete + update -> nessun ordinamento predifinito
- Unlogged tables
- \timing ->misurare prestazione
- generates_series(1, 200);
- sequence: specificare maxvalue
- sequence: owned by column_name
- serial -> autoincrement

### Views
Saved in an internal format. SELECT * is mapped to the list of coluns at creation time.
You cannot drop a column without cascade if it is included in a view. Cascade option will delete views too. 

### Indexes
WHERE bool_field = false -> useful for finding the few false values in a large set of true values
Hash indexes -> just for equality

EXPLAIN ANAYLZE SELECT.... -> Explains query execution plan
ANALYZE -> Update statistics

BRIN Index -> useful for sorted data

(pagila database: test DB)

Create index xxx on table_name on field_name (lower(field_name))
Create indezx..include(not_indexed_field)

create index concurrently

pg_stat_all_indexes

### Foreign table
Data outside PostgreSQL DB.  (Es. Mongo, MySQL, Kafka...)
https://wiki.postgresql.org/wiki/Foreign_data_wrappers#Generic_SQL_Database_Wrappers

### Misc
with x a s (DELETE FORM X RETURNING *) INSERT INTO Yjson SELECT * FROMX