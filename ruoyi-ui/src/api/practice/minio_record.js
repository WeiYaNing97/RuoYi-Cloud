import request from '@/utils/request'

// 查询minio操作记录列表
export function listMinio_record(query) {
  return request({
    url: '/practice/minio_record/list',
    method: 'get',
    params: query
  })
}

// 查询minio操作记录详细
export function getMinio_record(id) {
  return request({
    url: '/practice/minio_record/' + id,
    method: 'get'
  })
}

// 新增minio操作记录
export function addMinio_record(data) {
  return request({
    url: '/practice/minio_record',
    method: 'post',
    data: data
  })
}

// 修改minio操作记录
export function updateMinio_record(data) {
  return request({
    url: '/practice/minio_record',
    method: 'put',
    data: data
  })
}

// 删除minio操作记录
export function delMinio_record(id) {
  return request({
    url: '/practice/minio_record/' + id,
    method: 'delete'
  })
}
