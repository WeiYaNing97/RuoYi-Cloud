import request from '@/utils/request'

// 查询存储商品的信息列表
export function listExampleProducts(query) {
  return request({
    url: '/example/ExampleProducts/list',
    method: 'get',
    params: query
  })
}

// 查询存储商品的信息详细
export function getExampleProducts(exampleId) {
  return request({
    url: '/example/ExampleProducts/' + exampleId,
    method: 'get'
  })
}

// 新增存储商品的信息
export function addExampleProducts(data) {
  return request({
    url: '/example/ExampleProducts',
    method: 'post',
    data: data
  })
}

// 修改存储商品的信息
export function updateExampleProducts(data) {
  return request({
    url: '/example/ExampleProducts',
    method: 'put',
    data: data
  })
}

// 删除存储商品的信息
export function delExampleProducts(exampleId) {
  return request({
    url: '/example/ExampleProducts/' + exampleId,
    method: 'delete'
  })
}


// 删除存储商品的信息
export function exampleCategoriesList() {
  return request({
    url: '/example/ExampleCategories/list',
    method: 'get'
  })
}
