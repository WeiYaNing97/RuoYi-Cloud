<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="用户ID" prop="userId">
        <el-input
          v-model="queryParams.userId"
          placeholder="请输入用户ID"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="变动数值" prop="amount">
        <el-input
          v-model="queryParams.amount"
          placeholder="请输入变动数值"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="变动后余额快照" prop="balanceSnapshot">
        <el-input
          v-model="queryParams.balanceSnapshot"
          placeholder="请输入变动后余额快照"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="来源业务ID(幂等)" prop="sourceId">
        <el-input
          v-model="queryParams.sourceId"
          placeholder="请输入来源业务ID(幂等)"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="${comment}" prop="description">
        <el-input
          v-model="queryParams.description"
          placeholder="请输入${comment}"
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
          v-hasPermi="['points:PtsLog:add']"
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
          v-hasPermi="['points:PtsLog:edit']"
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
          v-hasPermi="['points:PtsLog:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['points:PtsLog:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="PtsLogList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="${comment}" align="center" prop="id" />
      <el-table-column label="用户ID" align="center" prop="userId" />
      <el-table-column label="类型:1-增加;2-扣减" align="center" prop="type" />
      <el-table-column label="变动数值" align="center" prop="amount" />
      <el-table-column label="变动后余额快照" align="center" prop="balanceSnapshot" />
      <el-table-column label="来源:ORDER,SIGN" align="center" prop="sourceType" />
      <el-table-column label="来源业务ID(幂等)" align="center" prop="sourceId" />
      <el-table-column label="${comment}" align="center" prop="description" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-view"
            @click="handleViewData(scope.row)"
            v-hasPermi="['points:PtsLog:query']"
          >详情</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['points:PtsLog:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['points:PtsLog:remove']"
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

    <!-- 积分流水详情抽屉 -->
    <PtsLog-view-drawer ref="PtsLogViewRef" />
    <!-- 添加或修改积分流水对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="100px">
        <el-row>
          <el-col :span="24">
            <el-form-item label="用户ID" prop="userId">
              <el-input v-model="form.userId" placeholder="请输入用户ID" />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="变动数值" prop="amount">
              <el-input v-model="form.amount" placeholder="请输入变动数值" />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="变动后余额快照" prop="balanceSnapshot">
              <el-input v-model="form.balanceSnapshot" placeholder="请输入变动后余额快照" />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="来源业务ID(幂等)" prop="sourceId">
              <el-input v-model="form.sourceId" placeholder="请输入来源业务ID(幂等)" />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="${comment}" prop="description">
              <el-input v-model="form.description" placeholder="请输入${comment}" />
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
import { listPtsLog, getPtsLog, delPtsLog, addPtsLog, updatePtsLog } from "@/api/points/PtsLog"
import PtsLogViewDrawer from "./view"

export default {
  name: "PtsLog",
  components: { PtsLogViewDrawer },
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
      // 积分流水表格数据
      PtsLogList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        userId: null,
        type: null,
        amount: null,
        balanceSnapshot: null,
        sourceType: null,
        sourceId: null,
        description: null,
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        userId: [
          { required: true, message: "用户ID不能为空", trigger: "blur" }
        ],
        type: [
          { required: true, message: "类型:1-增加;2-扣减不能为空", trigger: "change" }
        ],
        amount: [
          { required: true, message: "变动数值不能为空", trigger: "blur" }
        ],
        balanceSnapshot: [
          { required: true, message: "变动后余额快照不能为空", trigger: "blur" }
        ],
        sourceType: [
          { required: true, message: "来源:ORDER,SIGN不能为空", trigger: "change" }
        ],
        sourceId: [
          { required: true, message: "来源业务ID(幂等)不能为空", trigger: "blur" }
        ],
        createTime: [
          { required: true, message: "$comment不能为空", trigger: "blur" }
        ]
      }
    }
  },
  created() {
    this.getList()
  },
  methods: {
    /** 查询积分流水列表 */
    getList() {
      this.loading = true
      listPtsLog(this.queryParams).then(response => {
        this.PtsLogList = response.rows
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
        userId: null,
        type: null,
        amount: null,
        balanceSnapshot: null,
        sourceType: null,
        sourceId: null,
        description: null,
        createTime: null
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
      this.title = "添加积分流水"
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset()
      const id = row.id || this.ids
      getPtsLog(id).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改积分流水"
      })
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.id != null) {
            updatePtsLog(this.form).then(response => {
              this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            })
          } else {
            addPtsLog(this.form).then(response => {
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
      this.$modal.confirm('是否确认删除积分流水编号为"' + ids + '"的数据项？').then(function() {
        return delPtsLog(ids)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {})
    },
    /** 详情按钮操作 */
    handleViewData(row) {
      this.$refs["PtsLogViewRef"].open(row.id)
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('points/PtsLog/export', {
        ...this.queryParams
      }, `PtsLog_${new Date().getTime()}.xlsx`)
    }
  }
}
</script>
