import request from '@/utils/request'

// 查询支付流水列表
export function listOrdPayment(query) {
  return request({
    url: '/order/OrdPayment/list',
    method: 'get',
    params: query
  })
}

// 查询支付流水详细
export function getOrdPayment(id) {
  return request({
    url: '/order/OrdPayment/' + id,
    method: 'get'
  })
}

// 新增支付流水
export function addOrdPayment(data) {
  return request({
    url: '/order/OrdPayment',
    method: 'post',
    data: data
  })
}

// 修改支付流水
export function updateOrdPayment(data) {
  return request({
    url: '/order/OrdPayment',
    method: 'put',
    data: data
  })
}

// 删除支付流水
export function delOrdPayment(id) {
  return request({
    url: '/order/OrdPayment/' + id,
    method: 'delete'
  })
}
