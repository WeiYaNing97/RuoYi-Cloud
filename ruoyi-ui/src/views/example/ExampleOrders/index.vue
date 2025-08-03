<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="下单用户的ID" prop="exampleUserId">
        <el-input
          v-model="queryParams.exampleUserId"
          placeholder="请输入下单用户的ID"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="下单日期" prop="orderDate">
        <el-date-picker clearable
                        v-model="queryParams.orderDate"
                        type="date"
                        value-format="yyyy-MM-dd"
                        placeholder="请选择下单日期">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="订单总金额" prop="totalAmount">
        <el-input
          v-model="queryParams.totalAmount"
          placeholder="请输入订单总金额"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="配送方式" prop="shippingMethod">
        <el-input
          v-model="queryParams.shippingMethod"
          placeholder="请输入配送方式"
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
      <el-form-item label="物流追踪号码" prop="trackingNumber">
        <el-input
          v-model="queryParams.trackingNumber"
          placeholder="请输入物流追踪号码"
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
          v-hasPermi="['example:ExampleOrders:add']"
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
          v-hasPermi="['example:ExampleOrders:edit']"
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
          v-hasPermi="['example:ExampleOrders:remove']"
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
          v-hasPermi="['example:ExampleOrders:export']"
        >导出
        </el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="ExampleOrdersList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center"/>
      <el-table-column label="订单的唯一标识符" align="center" prop="exampleId"/>
      <el-table-column label="下单用户的ID" align="center" prop="exampleUserId"/>
      <el-table-column label="下单日期" align="center" prop="orderDate" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.orderDate, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="订单总金额" align="center" prop="totalAmount"/>
      <el-table-column label="订单状态" align="center" prop="status"/>
      <el-table-column label="收货地址" align="center" prop="shippingAddress"/>
      <el-table-column label="配送方式" align="center" prop="shippingMethod"/>
      <el-table-column label="支付方式" align="center" prop="paymentMethod"/>
      <el-table-column label="物流追踪号码" align="center" prop="trackingNumber"/>
      <el-table-column label="备注信息" align="center" prop="remark"/>
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
            v-hasPermi="['example:ExampleOrders:edit']"
          >修改
          </el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['example:ExampleOrders:remove']"
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

    <!-- 添加或修改存储订单的信息对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">

        <el-form-item label="下单用户的ID" prop="exampleUserId">
          <el-select v-model="form.exampleUserId" placeholder="请下拉选择下单用户" clearable
                     :style="{width: '100%'}" @visible-change="getUserIDs">
            <el-option v-for="(item, index) in userIDs"
                       :key="index"
                       :label="item.label"
                       :value="item.value"
                       :disabled="item.disabled"></el-option>
          </el-select>

        </el-form-item>

        <el-form-item label="下单日期" prop="orderDate">
          <el-date-picker clearable
                          v-model="form.orderDate"
                          type="date"
                          value-format="yyyy-MM-dd"
                          placeholder="请选择下单日期">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="订单总金额" prop="totalAmount">
          <el-input v-model="form.totalAmount" placeholder="请输入订单总金额"/>
        </el-form-item>
        <el-form-item label="收货地址" prop="shippingAddress">
          <el-input v-model="form.shippingAddress" type="textarea" placeholder="请输入内容"/>
        </el-form-item>
        <el-form-item label="配送方式" prop="shippingMethod">
          <el-input v-model="form.shippingMethod" placeholder="请输入配送方式"/>
        </el-form-item>
        <el-form-item label="支付方式" prop="paymentMethod">
          <el-input v-model="form.paymentMethod" placeholder="请输入支付方式"/>
        </el-form-item>
        <el-form-item label="物流追踪号码" prop="trackingNumber">
          <el-input v-model="form.trackingNumber" placeholder="请输入物流追踪号码"/>
        </el-form-item>
        <el-form-item label="备注信息" prop="remark">
          <el-input v-model="form.remark" type="textarea" placeholder="请输入内容"/>
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
  listExampleOrders,
  getExampleOrders,
  delExampleOrders,
  addExampleOrders,
  updateExampleOrders,
  listExampleUsers
} from "@/api/example/ExampleOrders"

export default {
  name: "ExampleOrders",
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
      // 存储订单的信息表格数据
      ExampleOrdersList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        exampleUserId: null,
        orderDate: null,
        totalAmount: null,
        status: null,
        shippingAddress: null,
        shippingMethod: null,
        paymentMethod: null,
        trackingNumber: null,
        createdAt: null,
        updatedAt: null
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        exampleUserId: [
          {required: true, message: "下单用户的ID不能为空", trigger: "blur"}
        ],
        totalAmount: [
          {required: true, message: "订单总金额不能为空", trigger: "blur"}
        ],
        status: [
          {required: true, message: "订单状态不能为空", trigger: "change"}
        ],
        shippingAddress: [
          {required: true, message: "收货地址不能为空", trigger: "blur"}
        ],
      },
      /* 用户ID数组 */
      userIDs: []
    }
  },
  created() {
    this.getList()
  },
  methods: {
    /** 查询存储订单的信息列表 */
    getList() {
      this.loading = true
      listExampleOrders(this.queryParams).then(response => {
        this.ExampleOrdersList = response.rows
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
        exampleUserId: null,
        orderDate: null,
        totalAmount: null,
        status: null,
        shippingAddress: null,
        shippingMethod: null,
        paymentMethod: null,
        trackingNumber: null,
        remark: null,
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
      this.title = "添加存储订单的信息"
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset()
      const exampleId = row.exampleId || this.ids
      getExampleOrders(exampleId).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改存储订单的信息"
      })
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.exampleId != null) {
            updateExampleOrders(this.form).then(response => {
              this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            })
          } else {
            addExampleOrders(this.form).then(response => {
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
      this.$modal.confirm('是否确认删除存储订单的信息编号为"' + exampleIds + '"的数据项？').then(function () {
        return delExampleOrders(exampleIds)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {
      })
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('example/ExampleOrders/export', {
        ...this.queryParams
      }, `ExampleOrders_${new Date().getTime()}.xlsx`)
    },

    getUserIDs() {
      listExampleUsers().then(
        response => {
          this.userIDs = []
          response.rows.map(item => (this.userIDs.push(
            {
              label: item.username,
              value: item.exampleId
            }))
          )
        })
    }
  }
}
</script>
