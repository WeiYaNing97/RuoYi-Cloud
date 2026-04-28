import request from '@/utils/request'

// 查询订单主表列表
export function listOrdOrder(query) {
  return request({
    url: '/order/OrdOrder/list',
    method: 'get',
    params: query
  })
}

// 查询订单主表详细
export function getOrdOrder(id) {
  return request({
    url: '/order/OrdOrder/' + id,
    method: 'get'
  })
}
// 查询订单主表详细
export function paymentOrdOrder(id) {
  return request({
    url: '/order/OrdOrder/payment',
    method: 'get',
    params: { id }
  })
}

// 新增订单主表
export function addOrdOrder(data) {
  return request({
    url: '/order/OrdOrder',
    method: 'post',
    data: data
  })
}

// 修改订单主表
export function updateOrdOrder(data) {
  return request({
    url: '/order/OrdOrder',
    method: 'put',
    data: data
  })
}

// 删除订单主表
export function delOrdOrder(id) {
  return request({
    url: '/order/OrdOrder/' + id,
    method: 'delete'
  })
}
