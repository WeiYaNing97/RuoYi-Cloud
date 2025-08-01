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
      <el-form-item label="支付方式" prop="paymentMethod">
        <el-input
          v-model="queryParams.paymentMethod"
          placeholder="请输入支付方式"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="支付金额" prop="amount">
        <el-input
          v-model="queryParams.amount"
          placeholder="请输入支付金额"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="支付日期" prop="paymentDate">
        <el-date-picker clearable
          v-model="queryParams.paymentDate"
          type="date"
          value-format="yyyy-MM-dd"
          placeholder="请选择支付日期">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="交易编号" prop="transactionId">
        <el-input
          v-model="queryParams.transactionId"
          placeholder="请输入交易编号"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="支付渠道" prop="paymentChannel">
        <el-input
          v-model="queryParams.paymentChannel"
          placeholder="请输入支付渠道"
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
          v-hasPermi="['example:ExamplePayments:add']"
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
          v-hasPermi="['example:ExamplePayments:edit']"
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
          v-hasPermi="['example:ExamplePayments:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['example:ExamplePayments:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="ExamplePaymentsList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="支付记录的唯一标识符" align="center" prop="exampleId" />
      <el-table-column label="关联订单的ID" align="center" prop="exampleOrderId" />
      <el-table-column label="支付方式" align="center" prop="paymentMethod" />
      <el-table-column label="支付金额" align="center" prop="amount" />
      <el-table-column label="支付状态" align="center" prop="paymentStatus" />
      <el-table-column label="支付日期" align="center" prop="paymentDate" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.paymentDate, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="交易编号" align="center" prop="transactionId" />
      <el-table-column label="支付渠道" align="center" prop="paymentChannel" />
      <el-table-column label="额外信息" align="center" prop="extraInfo" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['example:ExamplePayments:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['example:ExamplePayments:remove']"
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

    <!-- 添加或修改存储支付信息对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="关联订单的ID" prop="exampleOrderId">
          <el-input v-model="form.exampleOrderId" placeholder="请输入关联订单的ID" />
        </el-form-item>
        <el-form-item label="支付方式" prop="paymentMethod">
          <el-input v-model="form.paymentMethod" placeholder="请输入支付方式" />
        </el-form-item>
        <el-form-item label="支付金额" prop="amount">
          <el-input v-model="form.amount" placeholder="请输入支付金额" />
        </el-form-item>
        <el-form-item label="支付日期" prop="paymentDate">
          <el-date-picker clearable
            v-model="form.paymentDate"
            type="date"
            value-format="yyyy-MM-dd"
            placeholder="请选择支付日期">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="交易编号" prop="transactionId">
          <el-input v-model="form.transactionId" placeholder="请输入交易编号" />
        </el-form-item>
        <el-form-item label="支付渠道" prop="paymentChannel">
          <el-input v-model="form.paymentChannel" placeholder="请输入支付渠道" />
        </el-form-item>
        <el-form-item label="额外信息" prop="extraInfo">
          <el-input v-model="form.extraInfo" type="textarea" placeholder="请输入内容" />
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
import { listExamplePayments, getExamplePayments, delExamplePayments, addExamplePayments, updateExamplePayments } from "@/api/example/ExamplePayments"

export default {
  name: "ExamplePayments",
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
      // 存储支付信息表格数据
      ExamplePaymentsList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        exampleOrderId: null,
        paymentMethod: null,
        amount: null,
        paymentStatus: null,
        paymentDate: null,
        transactionId: null,
        paymentChannel: null,
        extraInfo: null
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        exampleOrderId: [
          { required: true, message: "关联订单的ID不能为空", trigger: "blur" }
        ],
        paymentMethod: [
          { required: true, message: "支付方式不能为空", trigger: "blur" }
        ],
        amount: [
          { required: true, message: "支付金额不能为空", trigger: "blur" }
        ],
        paymentStatus: [
          { required: true, message: "支付状态不能为空", trigger: "change" }
        ],
      }
    }
  },
  created() {
    this.getList()
  },
  methods: {
    /** 查询存储支付信息列表 */
    getList() {
      this.loading = true
      listExamplePayments(this.queryParams).then(response => {
        this.ExamplePaymentsList = response.rows
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
        paymentMethod: null,
        amount: null,
        paymentStatus: null,
        paymentDate: null,
        transactionId: null,
        paymentChannel: null,
        extraInfo: null
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
      this.title = "添加存储支付信息"
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset()
      const exampleId = row.exampleId || this.ids
      getExamplePayments(exampleId).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改存储支付信息"
      })
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.exampleId != null) {
            updateExamplePayments(this.form).then(response => {
              this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            })
          } else {
            addExamplePayments(this.form).then(response => {
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
      this.$modal.confirm('是否确认删除存储支付信息编号为"' + exampleIds + '"的数据项？').then(function() {
        return delExamplePayments(exampleIds)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {})
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('example/ExamplePayments/export', {
        ...this.queryParams
      }, `ExamplePayments_${new Date().getTime()}.xlsx`)
    }
  }
}
</script>
