import request from '@/utils/request'

// 查询存储用户的信息列表
export function listExampleUsers(query) {
  return request({
    url: '/example/ExampleUsers/list',
    method: 'get',
    params: query
  })
}

// 查询存储用户的信息详细
export function getExampleUsers(exampleId) {
  return request({
    url: '/example/ExampleUsers/' + exampleId,
    method: 'get'
  })
}

// 新增存储用户的信息
export function addExampleUsers(data) {
  return request({
    url: '/example/ExampleUsers',
    method: 'post',
    data: data
  })
}

// 修改存储用户的信息
export function updateExampleUsers(data) {
  return request({
    url: '/example/ExampleUsers',
    method: 'put',
    data: data
  })
}

// 删除存储用户的信息
export function delExampleUsers(exampleId) {
  return request({
    url: '/example/ExampleUsers/' + exampleId,
    method: 'delete'
  })
}

// 查询角色列表
export function listRole(query) {
  return request({
    url: '/system/role/list',
    method: 'get',
    params: query
  })
}

// 删除用户头像url
export function delExampleUsersAvatarUrl(fileName) {
  return request({
    url: '/practice/oss/'+fileName,
    method: 'delete'
  })
}