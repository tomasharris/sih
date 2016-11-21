QUERY = 'SELECT * FROM Products WHERE id IN (params)'

module.exports = class ProductFetcher

  #
  # @param orderProducts    Array<OrderProduct> the orderProducts to fetch Product for
  # @param fetchProductsCB  fetchProducts( String sql, Object[] arguments )
  #
  # @returns Product[]
  #
  @fetch: (orderProducts, fetchProductsCB) ->
    params = []
    args = []
    for op, i in orderProducts
      paramName = '@id' + i
      params.push(paramName)
      obj = {}
      obj[paramName] = op.productId
      args.push(obj)

    query = ProductFetcher.getQuery(params)
    return fetchProductsCB(query, args)

  @getQuery: (params) ->
    return QUERY.replace('params', params.join(', '))

