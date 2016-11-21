assert        = require 'assert'
Populator     = require.main.require 'src/Populator'
OrderProduct  = require.main.require 'src/Model/OrderProduct'
Product       = require.main.require 'src/Model/Product'


describe 'ProductFetcher', ->

  describe '@populate', ->
    it 'returns orderProducts', ->
      ops = []
      result = Populator.populate(ops, [])
      assert.equal(result, ops)

    it 'populates name', ->
      ops = [new OrderProduct('op1', 'pid1'), new OrderProduct('op2', 'pid2')]
      pds = [new Product('pid1', 'name1', 'price1'), new Product('pid2', 'name2', 'price2')]
      Populator.populate(ops, pds)
      assert.equal(ops[0].name, 'name1')
      assert.equal(ops[1].name, 'name2')
    it 'populates price', ->
      ops = [new OrderProduct('op1', 'pid1'), new OrderProduct('op2', 'pid2')]
      pds = [new Product('pid1', 'name1', 'price1'), new Product('pid2', 'name2', 'price2')]
      Populator.populate(ops, pds)
      assert.equal(ops[0].price, 'price1')
      assert.equal(ops[1].price, 'price2')


