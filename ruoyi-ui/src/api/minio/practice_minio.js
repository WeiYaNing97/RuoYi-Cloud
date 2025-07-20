import request from '@/utils/request'

// 查询minio操作记录列表
export function listPractice_minio(query) {
  return request({
    url: '/minio/practice_minio/list',
    method: 'get',
    params: query
  })
}

// 查询minio操作记录详细
export function getPractice_minio(id) {
  return request({
    url: '/minio/practice_minio/' + id,
    method: 'get'
  })
}

// 新增minio操作记录
export function addPractice_minio(data) {
  return request({
    url: '/minio/practice_minio',
    method: 'post',
    data: data
  })
}

// 修改minio操作记录
export function updatePractice_minio(data) {
  return request({
    url: '/minio/practice_minio',
    method: 'put',
    data: data
  })
}

// 删除minio操作记录
export function delPractice_minio(id) {
  return request({
    url: '/minio/practice_minio/' + id,
    method: 'delete'
  })
}
