import request from '@/utils/request'

// 查询存储订单中每种商品的详细信息列表
export function listExampleOrderItems(query) {
  return request({
    url: '/example/ExampleOrderItems/list',
    method: 'get',
    params: query
  })
}

// 查询存储订单中每种商品的详细信息详细
export function getExampleOrderItems(exampleId) {
  return request({
    url: '/example/ExampleOrderItems/' + exampleId,
    method: 'get'
  })
}

// 新增存储订单中每种商品的详细信息
export function addExampleOrderItems(data) {
  return request({
    url: '/example/ExampleOrderItems',
    method: 'post',
    data: data
  })
}

// 修改存储订单中每种商品的详细信息
export function updateExampleOrderItems(data) {
  return request({
    url: '/example/ExampleOrderItems',
    method: 'put',
    data: data
  })
}

// 删除存储订单中每种商品的详细信息
export function delExampleOrderItems(exampleId) {
  return request({
    url: '/example/ExampleOrderItems/' + exampleId,
    method: 'delete'
  })
}
