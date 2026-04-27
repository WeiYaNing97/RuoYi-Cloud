import request from '@/utils/request'

// 查询积分账户列表
export function listPtsAccount(query) {
  return request({
    url: '/points/PtsAccount/list',
    method: 'get',
    params: query
  })
}

// 查询积分账户详细
export function getPtsAccount(userId) {
  return request({
    url: '/points/PtsAccount/' + userId,
    method: 'get'
  })
}

// 新增积分账户
export function addPtsAccount(data) {
  return request({
    url: '/points/PtsAccount',
    method: 'post',
    data: data
  })
}

// 修改积分账户
export function updatePtsAccount(data) {
  return request({
    url: '/points/PtsAccount',
    method: 'put',
    data: data
  })
}

// 删除积分账户
export function delPtsAccount(userId) {
  return request({
    url: '/points/PtsAccount/' + userId,
    method: 'delete'
  })
}
