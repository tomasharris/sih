# An SQL query walks into a bar...

## Caveats

I did it the standard
`SELECT * FROM TABLE WHERE ID IN (id1, id2, ..., idn)` way.


Apparently there is a better way to query for many records according to
`http://stackoverflow.com/questions/5803472/sql-where-id-in-id1-id2-idn`
>The third way would be importing the list of values into a temporary table and join it which is more efficient in most systems, if there are lots of values.



## To Run
- `npm install`
- `npm start`

## Testing
- `npm install`
- `npm test`

## Coverage (100%)
- `npm install`
- `npm run coverage`

Wouldn't usually commit the coverage.html file but in this case did to save you generating it.

