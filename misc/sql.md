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

## Oracle specific
To know when a row was updated you can use the Oracle System Change Number 

```sql
SELECT SCN_TO_TIMESTAMP(ora_rowscn), MY_TABLE.*
FROM MYTABLE
```

