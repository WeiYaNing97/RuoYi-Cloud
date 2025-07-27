import request from '@/utils/request'

// 查询存储商品类别的信息列表
export function listExampleCategories(query) {
  return request({
    url: '/example/ExampleCategories/list',
    method: 'get',
    params: query
  })
}

// 查询存储商品类别的信息详细
export function getExampleCategories(exampleId) {
  return request({
    url: '/example/ExampleCategories/' + exampleId,
    method: 'get'
  })
}

// 新增存储商品类别的信息
export function addExampleCategories(data) {
  return request({
    url: '/example/ExampleCategories',
    method: 'post',
    data: data
  })
}

// 修改存储商品类别的信息
export function updateExampleCategories(data) {
  return request({
    url: '/example/ExampleCategories',
    method: 'put',
    data: data
  })
}

// 删除存储商品类别的信息
export function delExampleCategories(exampleId) {
  return request({
    url: '/example/ExampleCategories/' + exampleId,
    method: 'delete'
  })
}
