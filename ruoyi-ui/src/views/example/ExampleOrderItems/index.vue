<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="关联订单的ID" prop="exampleOrderId">
        <el-input
          v-model="queryParams.exampleOrderId"
          placeholder="请输入关联订单的ID"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="商品的ID" prop="exampleProductId">
        <el-input
          v-model="queryParams.exampleProductId"
          placeholder="请输入商品的ID"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="商品数量" prop="quantity">
        <el-input
          v-model="queryParams.quantity"
          placeholder="请输入商品数量"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="单价" prop="unitPrice">
        <el-input
          v-model="queryParams.unitPrice"
          placeholder="请输入单价"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="总价" prop="totalPrice">
        <el-input
          v-model="queryParams.totalPrice"
          placeholder="请输入总价"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="商品名称" prop="productName">
        <el-input
          v-model="queryParams.productName"
          placeholder="请输入商品名称"
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
          v-hasPermi="['example:ExampleOrderItems:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="el-icon-edit"
          size="mini"
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['example:ExampleOrderItems:edit']"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="el-icon-delete"
          size="mini"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['example:ExampleOrderItems:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['example:ExampleOrderItems:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="ExampleOrderItemsList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="订单项的唯一标识符" align="center" prop="exampleId" />
      <el-table-column label="关联订单的ID" align="center" prop="exampleOrderId" />
      <el-table-column label="商品的ID" align="center" prop="exampleProductId" />
      <el-table-column label="商品数量" align="center" prop="quantity" />
      <el-table-column label="单价" align="center" prop="unitPrice" />
      <el-table-column label="总价" align="center" prop="totalPrice" />
      <el-table-column label="商品名称" align="center" prop="productName" />
      <el-table-column label="商品库存保有单位(SKU)" align="center" prop="sku" />
      <el-table-column label="订单项状态" align="center" prop="status" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['example:ExampleOrderItems:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['example:ExampleOrderItems:remove']"
          >删除</el-button>
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

    <!-- 添加或修改存储订单中每种商品的详细信息对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="关联订单的ID" prop="exampleOrderId">
          <el-input v-model="form.exampleOrderId" placeholder="请输入关联订单的ID" />
        </el-form-item>
        <el-form-item label="商品的ID" prop="exampleProductId">
          <el-input v-model="form.exampleProductId" placeholder="请输入商品的ID" />
        </el-form-item>
        <el-form-item label="商品数量" prop="quantity">
          <el-input v-model="form.quantity" placeholder="请输入商品数量" />
        </el-form-item>
        <el-form-item label="单价" prop="unitPrice">
          <el-input v-model="form.unitPrice" placeholder="请输入单价" />
        </el-form-item>
        <el-form-item label="总价" prop="totalPrice">
          <el-input v-model="form.totalPrice" placeholder="请输入总价" />
        </el-form-item>
        <el-form-item label="商品名称" prop="productName">
          <el-input v-model="form.productName" placeholder="请输入商品名称" />
        </el-form-item>
        <el-form-item label="商品库存保有单位(SKU)" prop="sku">
          <el-input v-model="form.sku" placeholder="请输入商品库存保有单位(SKU)" />
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
import { listExampleOrderItems, getExampleOrderItems, delExampleOrderItems, addExampleOrderItems, updateExampleOrderItems } from "@/api/example/ExampleOrderItems"

export default {
  name: "ExampleOrderItems",
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
      // 存储订单中每种商品的详细信息表格数据
      ExampleOrderItemsList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        exampleOrderId: null,
        exampleProductId: null,
        quantity: null,
        unitPrice: null,
        totalPrice: null,
        productName: null,
        sku: null,
        status: null
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        exampleOrderId: [
          { required: true, message: "关联订单的ID不能为空", trigger: "blur" }
        ],
        exampleProductId: [
          { required: true, message: "商品的ID不能为空", trigger: "blur" }
        ],
        quantity: [
          { required: true, message: "商品数量不能为空", trigger: "blur" }
        ],
        unitPrice: [
          { required: true, message: "单价不能为空", trigger: "blur" }
        ],
        totalPrice: [
          { required: true, message: "总价不能为空", trigger: "blur" }
        ],
        productName: [
          { required: true, message: "商品名称不能为空", trigger: "blur" }
        ],
        status: [
          { required: true, message: "订单项状态不能为空", trigger: "change" }
        ]
      }
    }
  },
  created() {
    this.getList()
  },
  methods: {
    /** 查询存储订单中每种商品的详细信息列表 */
    getList() {
      this.loading = true
      listExampleOrderItems(this.queryParams).then(response => {
        this.ExampleOrderItemsList = response.rows
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
        exampleOrderId: null,
        exampleProductId: null,
        quantity: null,
        unitPrice: null,
        totalPrice: null,
        productName: null,
        sku: null,
        status: null
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
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset()
      this.open = true
      this.title = "添加存储订单中每种商品的详细信息"
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset()
      const exampleId = row.exampleId || this.ids
      getExampleOrderItems(exampleId).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改存储订单中每种商品的详细信息"
      })
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.exampleId != null) {
            updateExampleOrderItems(this.form).then(response => {
              this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            })
          } else {
            addExampleOrderItems(this.form).then(response => {
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
      this.$modal.confirm('是否确认删除存储订单中每种商品的详细信息编号为"' + exampleIds + '"的数据项？').then(function() {
        return delExampleOrderItems(exampleIds)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {})
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('example/ExampleOrderItems/export', {
        ...this.queryParams
      }, `ExampleOrderItems_${new Date().getTime()}.xlsx`)
    }
  }
}
</script>
