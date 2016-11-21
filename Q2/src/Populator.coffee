module.exports = class Populator

  #
  # @param orderProducts  Array<OrderProduct> the orderProducts to populate
  # @param products       Array<Product> products used to populate orderProduct properties
  #
  # Note: This method modifies the objects in place and returns the original array
  #
  @populate: (orderProducts, products) ->
    # fast lookup
    productMap = {}
    for product in products
      productMap[product.id] = product
    product = null
    for op in orderProducts
      product = productMap[op.productId]
      op.name = product.name
      op.price = product.price

    return orderProducts

