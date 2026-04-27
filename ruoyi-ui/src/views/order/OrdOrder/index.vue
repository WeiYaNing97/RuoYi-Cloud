<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="订单编号" prop="orderSn">
        <el-input
          v-model="queryParams.orderSn"
          placeholder="请输入订单编号"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="用户ID" prop="memberId">
        <el-input
          v-model="queryParams.memberId"
          placeholder="请输入用户ID"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="总金额(分)" prop="totalAmount">
        <el-input
          v-model="queryParams.totalAmount"
          placeholder="请输入总金额(分)"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="应付金额(分)" prop="payAmount">
        <el-input
          v-model="queryParams.payAmount"
          placeholder="请输入应付金额(分)"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="优惠金额(分)" prop="promotionAmount">
        <el-input
          v-model="queryParams.promotionAmount"
          placeholder="请输入优惠金额(分)"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="运费(分)" prop="freightAmount">
        <el-input
          v-model="queryParams.freightAmount"
          placeholder="请输入运费(分)"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="支付时间" prop="paymentTime">
        <el-date-picker clearable
          v-model="queryParams.paymentTime"
          type="date"
          value-format="yyyy-MM-dd"
          placeholder="请选择支付时间">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="过期时间" prop="expireTime">
        <el-date-picker clearable
          v-model="queryParams.expireTime"
          type="date"
          value-format="yyyy-MM-dd"
          placeholder="请选择过期时间">
        </el-date-picker>
      </el-form-item>
      <el-form-item label="乐观锁版本号" prop="version">
        <el-input
          v-model="queryParams.version"
          placeholder="请输入乐观锁版本号"
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
          v-hasPermi="['order:OrdOrder:add']"
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
          v-hasPermi="['order:OrdOrder:edit']"
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
          v-hasPermi="['order:OrdOrder:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['order:OrdOrder:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="OrdOrderList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="主键ID" align="center" prop="id" />
      <el-table-column label="订单编号" align="center" prop="orderSn" />
      <el-table-column label="用户ID" align="center" prop="memberId" />
      <el-table-column label="状态:0-待支付;1-待发货;2-已发货;3-已完成;4-已关闭" align="center" prop="status" />
      <el-table-column label="总金额(分)" align="center" prop="totalAmount" />
      <el-table-column label="应付金额(分)" align="center" prop="payAmount" />
      <el-table-column label="优惠金额(分)" align="center" prop="promotionAmount" />
      <el-table-column label="运费(分)" align="center" prop="freightAmount" />
      <el-table-column label="支付方式:1-微信;2-支付宝" align="center" prop="paymentType" />
      <el-table-column label="支付时间" align="center" prop="paymentTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.paymentTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="过期时间" align="center" prop="expireTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.expireTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="乐观锁版本号" align="center" prop="version" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-view"
            @click="handleViewData(scope.row)"
            v-hasPermi="['order:OrdOrder:query']"
          >详情</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['order:OrdOrder:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['order:OrdOrder:remove']"
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

    <!-- 订单主表详情抽屉 -->
    <OrdOrder-view-drawer ref="OrdOrderViewRef" />
    <!-- 添加或修改订单主表对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="100px">
        <el-row>
          <el-col :span="24">
            <el-form-item label="订单编号" prop="orderSn">
              <el-input v-model="form.orderSn" placeholder="请输入订单编号" />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="用户ID" prop="memberId">
              <el-input v-model="form.memberId" placeholder="请输入用户ID" />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="总金额(分)" prop="totalAmount">
              <el-input v-model="form.totalAmount" placeholder="请输入总金额(分)" />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="应付金额(分)" prop="payAmount">
              <el-input v-model="form.payAmount" placeholder="请输入应付金额(分)" />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="优惠金额(分)" prop="promotionAmount">
              <el-input v-model="form.promotionAmount" placeholder="请输入优惠金额(分)" />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="运费(分)" prop="freightAmount">
              <el-input v-model="form.freightAmount" placeholder="请输入运费(分)" />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="支付时间" prop="paymentTime">
              <el-date-picker clearable
                v-model="form.paymentTime"
                type="date"
                value-format="yyyy-MM-dd"
                placeholder="请选择支付时间">
              </el-date-picker>
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="过期时间" prop="expireTime">
              <el-date-picker clearable
                v-model="form.expireTime"
                type="date"
                value-format="yyyy-MM-dd"
                placeholder="请选择过期时间">
              </el-date-picker>
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="乐观锁版本号" prop="version">
              <el-input v-model="form.version" placeholder="请输入乐观锁版本号" />
            </el-form-item>
          </el-col>
        </el-row>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listOrdOrder, getOrdOrder, delOrdOrder, addOrdOrder, updateOrdOrder } from "@/api/order/OrdOrder"
import OrdOrderViewDrawer from "./view"

export default {
  name: "OrdOrder",
  components: { OrdOrderViewDrawer },
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
      // 订单主表表格数据
      OrdOrderList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        orderSn: null,
        memberId: null,
        status: null,
        totalAmount: null,
        payAmount: null,
        promotionAmount: null,
        freightAmount: null,
        paymentType: null,
        paymentTime: null,
        expireTime: null,
        version: null,
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        orderSn: [
          { required: true, message: "订单编号不能为空", trigger: "blur" }
        ],
        memberId: [
          { required: true, message: "用户ID不能为空", trigger: "blur" }
        ],
        status: [
          { required: true, message: "状态:0-待支付;1-待发货;2-已发货;3-已完成;4-已关闭不能为空", trigger: "change" }
        ],
        totalAmount: [
          { required: true, message: "总金额(分)不能为空", trigger: "blur" }
        ],
        payAmount: [
          { required: true, message: "应付金额(分)不能为空", trigger: "blur" }
        ],
        promotionAmount: [
          { required: true, message: "优惠金额(分)不能为空", trigger: "blur" }
        ],
        freightAmount: [
          { required: true, message: "运费(分)不能为空", trigger: "blur" }
        ],
        version: [
          { required: true, message: "乐观锁版本号不能为空", trigger: "blur" }
        ],
        createTime: [
          { required: true, message: "$comment不能为空", trigger: "blur" }
        ],
        updateTime: [
          { required: true, message: "$comment不能为空", trigger: "blur" }
        ]
      }
    }
  },
  created() {
    this.getList()
  },
  methods: {
    /** 查询订单主表列表 */
    getList() {
      this.loading = true
      listOrdOrder(this.queryParams).then(response => {
        this.OrdOrderList = response.rows
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
        id: null,
        orderSn: null,
        memberId: null,
        status: null,
        totalAmount: null,
        payAmount: null,
        promotionAmount: null,
        freightAmount: null,
        paymentType: null,
        paymentTime: null,
        expireTime: null,
        version: null,
        createTime: null,
        updateTime: null
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
      this.ids = selection.map(item => item.id)
      this.single = selection.length !== 1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset()
      this.open = true
      this.title = "添加订单主表"
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset()
      const id = row.id || this.ids
      getOrdOrder(id).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改订单主表"
      })
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.id != null) {
            updateOrdOrder(this.form).then(response => {
              this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            })
          } else {
            addOrdOrder(this.form).then(response => {
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
      const ids = row.id || this.ids
      this.$modal.confirm('是否确认删除订单主表编号为"' + ids + '"的数据项？').then(function() {
        return delOrdOrder(ids)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {})
    },
    /** 详情按钮操作 */
    handleViewData(row) {
      this.$refs["OrdOrderViewRef"].open(row.id)
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('order/OrdOrder/export', {
        ...this.queryParams
      }, `OrdOrder_${new Date().getTime()}.xlsx`)
    }
  }
}
</script>
