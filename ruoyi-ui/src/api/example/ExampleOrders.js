import request from '@/utils/request'

// 查询存储订单的信息列表
export function listExampleOrders(query) {
  return request({
    url: '/example/ExampleOrders/list',
    method: 'get',
    params: query
  })
}

// 查询存储订单的信息详细
export function getExampleOrders(exampleId) {
  return request({
    url: '/example/ExampleOrders/' + exampleId,
    method: 'get'
  })
}

// 新增存储订单的信息
export function addExampleOrders(data) {
  return request({
    url: '/example/ExampleOrders',
    method: 'post',
    data: data
  })
}

// 修改存储订单的信息
export function updateExampleOrders(data) {
  return request({
    url: '/example/ExampleOrders',
    method: 'put',
    data: data
  })
}

// 删除存储订单的信息
export function delExampleOrders(exampleId) {
  return request({
    url: '/example/ExampleOrders/' + exampleId,
    method: 'delete'
  })
}
