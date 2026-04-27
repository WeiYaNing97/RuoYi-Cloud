import request from '@/utils/request'

// 查询积分流水列表
export function listPtsLog(query) {
  return request({
    url: '/points/PtsLog/list',
    method: 'get',
    params: query
  })
}

// 查询积分流水详细
export function getPtsLog(id) {
  return request({
    url: '/points/PtsLog/' + id,
    method: 'get'
  })
}

// 新增积分流水
export function addPtsLog(data) {
  return request({
    url: '/points/PtsLog',
    method: 'post',
    data: data
  })
}

// 修改积分流水
export function updatePtsLog(data) {
  return request({
    url: '/points/PtsLog',
    method: 'put',
    data: data
  })
}

// 删除积分流水
export function delPtsLog(id) {
  return request({
    url: '/points/PtsLog/' + id,
    method: 'delete'
  })
}
