# Some useful SQL commands

## MySQL specific
### Using MySQL Fulltext search for finding users by full name (first name and last name)

```sql 
CREATE FULLTEXT INDEX fx_name ON users (firstName, lastName);
```

If you're using TypeORM you can use th following annotation on the User entity:

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

