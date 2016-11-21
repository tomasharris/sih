module.exports = class OrderProduct

  # Represents a row in the "OrderProduct” table.

  constructor: (@orderId, @productId, @name, @price) ->
    return @

