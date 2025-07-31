<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="商品名称" prop="productName">
        <el-input
          v-model="queryParams.productName"
          placeholder="请输入商品名称"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="商品价格" prop="price">
        <el-input
          v-model="queryParams.price"
          placeholder="请输入商品价格"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>

      <el-form-item label="所属类别" prop="exampleCategoryId">
        <el-select v-model="queryParams.exampleCategoryId" placeholder="请选择类别">
          <el-option v-for="item in exampleCategoryIds"
                     :key="item.value"
                     :label="item.label"
                     :value="item.value"/>
        </el-select>
      </el-form-item>

      <el-form-item label="库存数量" prop="stockQuantity">
        <el-input
          v-model="queryParams.stockQuantity"
          placeholder="请输入库存数量"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="商品库存保有单位(SKU)" prop="sku">
        <el-input
          v-model="queryParams.sku"
          placeholder="请输入商品库存保有单位(SKU)"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="记录创建时间" prop="createdAt">
        <el-date-picker clearable
                        v-model="queryParams.createdAt"
                        type="date"
                        value-format="yyyy-MM-dd"
                        placeholder="请选择记录创建时间">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="记录最后更新时间" prop="updatedAt">
        <el-date-picker clearable
                        v-model="queryParams.updatedAt"
                        type="date"
                        value-format="yyyy-MM-dd"
                        placeholder="请选择记录最后更新时间">
        </el-date-picker>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="el-icon-plus"
          size="mini"
          @click="handleAdd"
          v-hasPermi="['example:ExampleProducts:add']"
        >新增
        </el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="el-icon-edit"
          size="mini"
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['example:ExampleProducts:edit']"
        >修改
        </el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="el-icon-delete"
          size="mini"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['example:ExampleProducts:remove']"
        >删除
        </el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['example:ExampleProducts:export']"
        >导出
        </el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="ExampleProductsList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center"/>
      <el-table-column label="商品的唯一标识符" align="center" prop="exampleId"/>
      <el-table-column label="商品名称" align="center" prop="productName"/>
      <el-table-column label="商品描述" align="center" prop="description"/>
      <el-table-column label="商品价格" align="center" prop="price"/>


      <el-table-column label="所属类别" align="center" prop="exampleCategoryId">
        <template slot-scope="scope">
          {{ getCategoryLabel(scope.row.exampleCategoryId) }}
        </template>
      </el-table-column>

      <el-table-column label="库存数量" align="center" prop="stockQuantity"/>
      <el-table-column label="商品状态" align="center" prop="status"/>
      <el-table-column label="商品库存保有单位(SKU)" align="center" prop="sku"/>
      <el-table-column label="商品图片URL" align="center" prop="imageUrl"/>
      <el-table-column label="记录创建时间" align="center" prop="createdAt" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.createdAt, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="记录最后更新时间" align="center" prop="updatedAt" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.updatedAt, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['example:ExampleProducts:edit']"
          >修改
          </el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['example:ExampleProducts:remove']"
          >删除
          </el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination
      v-show="total>0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />

    <!-- 添加或修改存储商品的信息对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="商品名称" prop="productName">
          <el-input v-model="form.productName" placeholder="请输入商品名称"/>
        </el-form-item>
        <el-form-item label="商品描述" prop="description">
          <el-input v-model="form.description" type="textarea" placeholder="请输入内容"/>
        </el-form-item>
        <el-form-item label="商品价格" prop="price">
          <el-input v-model="form.price" placeholder="请输入商品价格"/>
        </el-form-item>
        <!-- 修改成下拉框选择      -->
        <el-form-item label="所属类别" prop="exampleCategoryId">
          <el-select v-model="form.exampleCategoryId" placeholder="请下拉选择所属类别" clearable
                     :style="{width: '100%'}" @visible-change="getExampleCategories">
            <el-option v-for="(item, index) in exampleCategoryIds" :key="index" :label="item.label"
                       :value="item.value" :disabled="item.disabled"></el-option>
          </el-select>
        </el-form-item>

        <el-form-item label="库存数量" prop="stockQuantity">
          <el-input v-model="form.stockQuantity" placeholder="请输入库存数量"/>
        </el-form-item>
        <el-form-item label="商品库存保有单位(SKU)" prop="sku">
          <el-input v-model="form.sku" placeholder="请输入商品库存保有单位(SKU)"/>
        </el-form-item>
        <el-form-item label="商品图片URL" prop="imageUrl">
          <el-input v-model="form.imageUrl" type="textarea" placeholder="请输入内容"/>
        </el-form-item>
        <el-form-item label="记录创建时间" prop="createdAt">
          <el-date-picker clearable
                          v-model="form.createdAt"
                          type="date"
                          value-format="yyyy-MM-dd"
                          placeholder="请选择记录创建时间">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="记录最后更新时间" prop="updatedAt">
          <el-date-picker clearable
                          v-model="form.updatedAt"
                          type="date"
                          value-format="yyyy-MM-dd"
                          placeholder="请选择记录最后更新时间">
          </el-date-picker>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import {
  listExampleProducts,
  getExampleProducts,
  delExampleProducts,
  addExampleProducts,
  updateExampleProducts,
  exampleCategoriesList
} from "@/api/example/ExampleProducts"
import request from "@/utils/request";

export default {
  name: "ExampleProducts",
  data() {
    return {
      // 遮罩层
      loading: true,
      // 选中数组
      ids: [],
      // 非单个禁用
      single: true,
      // 非多个禁用
      multiple: true,
      // 显示搜索条件
      showSearch: true,
      // 总条数
      total: 0,
      // 存储商品的信息表格数据
      ExampleProductsList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        productName: null,
        description: null,
        price: null,
        exampleCategoryId: null,
        stockQuantity: null,
        status: null,
        sku: null,
        imageUrl: null,
        createdAt: null,
        updatedAt: null
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        productName: [
          {required: true, message: "商品名称不能为空", trigger: "blur"}
        ],
        price: [
          {required: true, message: "商品价格不能为空", trigger: "blur"}
        ],
        exampleCategoryId: [
          {required: true, message: "所属类别ID不能为空", trigger: "blur"}
        ],
        stockQuantity: [
          {required: true, message: "库存数量不能为空", trigger: "blur"}
        ],
        status: [
          {required: true, message: "商品状态不能为空", trigger: "change"}
        ],
      },
      exampleCategoryIds: [{
        "label": "选项一",
        "value": 1
      }, {
        "label": "选项二",
        "value": 2
      }]
    }
  },
  created() {
    this.getExampleCategories()
    this.getList()
  },
  methods: {

    getCategoryLabel(id) {
      const item = this.exampleCategoryIds.find(v => v.value === id);
      return item ? item.label : id;
    },

    getExampleCategories() {
      exampleCategoriesList().then(response => {
        this.exampleCategoryIds = []
        response.rows.map(item => (this.exampleCategoryIds.push(
          {
            label: item.categoryName,
            value: item.exampleId
          }
        )));
      });
    },


    /** 查询存储商品的信息列表 */
    getList() {
      this.loading = true
      listExampleProducts(this.queryParams).then(response => {
        this.ExampleProductsList = response.rows
        this.total = response.total
        this.loading = false
      })
    },
    // 取消按钮
    cancel() {
      this.open = false
      this.reset()
    },
    // 表单重置
    reset() {
      this.form = {
        exampleId: null,
        productName: null,
        description: null,
        price: null,
        exampleCategoryId: null,
        stockQuantity: null,
        status: null,
        sku: null,
        imageUrl: null,
        createdAt: null,
        updatedAt: null
      }
      this.resetForm("form")
    },
    /** 搜索按钮操作 */
    handleQuery() {
      this.queryParams.pageNum = 1
      this.getList()
    },
    /** 重置按钮操作 */
    resetQuery() {
      this.resetForm("queryForm")
      this.handleQuery()
    },
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.exampleId)
      this.single = selection.length !== 1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset()
      this.open = true
      this.title = "添加存储商品的信息"
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset()
      const exampleId = row.exampleId || this.ids
      getExampleProducts(exampleId).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改存储商品的信息"
      })
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.exampleId != null) {
            updateExampleProducts(this.form).then(response => {
              this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            })
          } else {
            addExampleProducts(this.form).then(response => {
              this.$modal.msgSuccess("新增成功")
              this.open = false
              this.getList()
            })
          }
        }
      })
    },
    /** 删除按钮操作 */
    handleDelete(row) {
      const exampleIds = row.exampleId || this.ids
      this.$modal.confirm('是否确认删除存储商品的信息编号为"' + exampleIds + '"的数据项？').then(function () {
        return delExampleProducts(exampleIds)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {
      })
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('example/ExampleProducts/export', {
        ...this.queryParams
      }, `ExampleProducts_${new Date().getTime()}.xlsx`)
    }
  }
}
</script>
