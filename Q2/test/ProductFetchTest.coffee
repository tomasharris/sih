assert          = require 'assert'
ProductFetcher  = require.main.require 'src/ProductFetcher'
OrderProduct    = require.main.require 'src/Model/OrderProduct'

describe 'ProductFetcher', ->

  describe '@getQuery', ->
    it 'parameterises for each orderProduct', ->
      params = ['@id0', '@id1', '@id2']
      assert.equal(
        ProductFetcher.getQuery(params),
        'SELECT * FROM Products WHERE id IN (@id0, @id1, @id2)'
      )

  describe '@fetch', ->
    it 'calls fetchProductsCB with correct query', ->
      ops = [new OrderProduct('op1', 'pid1'), new OrderProduct('op2', 'pid2')]
      queryResult = null
      fpCB = (query, args) ->
        queryResult = query
      ProductFetcher.fetch(ops, fpCB)
      assert.equal(queryResult, 'SELECT * FROM Products WHERE id IN (@id0, @id1)')

    it 'calls fetchProductsCB with correct args', ->
      ops = [new OrderProduct('op1', 'pid1'), new OrderProduct('op2', 'pid2')]
      argsResult = null
      fpCB = (sql, args) ->
        argsResult = args
      ProductFetcher.fetch(ops, fpCB)
      assert.deepEqual(argsResult[0], {'@id0': 'pid1'})
      assert.deepEqual(argsResult[1], {'@id1': 'pid2'})

    it 'returns fetchProductsCB result', ->
      returnRef = []
      fpCB = (sql, args) ->
        return returnRef
      result = ProductFetcher.fetch([], fpCB)
      assert.equal(result, returnRef)


