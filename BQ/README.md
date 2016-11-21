# The sound of music
Was a pretty interesting and fun task all round. I'm pretty sure this is some kind of graph problem, but I don't know the theory. I tried to solve it in a tricky recursive way that kept cycling until there were no more suitable events rather than the end of the day. It proved trickier than I expected.
I ended up doing it in a fairly straight forward but perhaps not optimal way. I think it conforms to the spec.

## Testing
- `npm install`
- `npm test`

If you want to see the output of your own set of events change the JSON in `test/Performance/MockData.coffee` and it will output at the end of the tests.


## Coverage (100%)
- `npm install`
- `npm run coverage`

Wouldn't usually commit the coverage.html file but in this case did to save you generating it.
