import request from '@/utils/request'

// 查询订单明细列表
export function listOrdItem(query) {
  return request({
    url: '/order/OrdItem/list',
    method: 'get',
    params: query
  })
}

// 查询订单明细详细
export function getOrdItem(id) {
  return request({
    url: '/order/OrdItem/' + id,
    method: 'get'
  })
}

// 新增订单明细
export function addOrdItem(data) {
  return request({
    url: '/order/OrdItem',
    method: 'post',
    data: data
  })
}

// 修改订单明细
export function updateOrdItem(data) {
  return request({
    url: '/order/OrdItem',
    method: 'put',
    data: data
  })
}

// 删除订单明细
export function delOrdItem(id) {
  return request({
    url: '/order/OrdItem/' + id,
    method: 'delete'
  })
}
