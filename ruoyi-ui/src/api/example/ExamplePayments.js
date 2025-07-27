import request from '@/utils/request'

// 查询存储支付信息列表
export function listExamplePayments(query) {
  return request({
    url: '/example/ExamplePayments/list',
    method: 'get',
    params: query
  })
}

// 查询存储支付信息详细
export function getExamplePayments(exampleId) {
  return request({
    url: '/example/ExamplePayments/' + exampleId,
    method: 'get'
  })
}

// 新增存储支付信息
export function addExamplePayments(data) {
  return request({
    url: '/example/ExamplePayments',
    method: 'post',
    data: data
  })
}

// 修改存储支付信息
export function updateExamplePayments(data) {
  return request({
    url: '/example/ExamplePayments',
    method: 'put',
    data: data
  })
}

// 删除存储支付信息
export function delExamplePayments(exampleId) {
  return request({
    url: '/example/ExamplePayments/' + exampleId,
    method: 'delete'
  })
}
