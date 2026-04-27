<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="总积分" prop="totalPoints">
        <el-input
          v-model="queryParams.totalPoints"
          placeholder="请输入总积分"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="冻结积分" prop="frozenPoints">
        <el-input
          v-model="queryParams.frozenPoints"
          placeholder="请输入冻结积分"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="乐观锁版本" prop="version">
        <el-input
          v-model="queryParams.version"
          placeholder="请输入乐观锁版本"
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
          v-hasPermi="['points:PtsAccount:add']"
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
          v-hasPermi="['points:PtsAccount:edit']"
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
          v-hasPermi="['points:PtsAccount:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['points:PtsAccount:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="PtsAccountList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="用户ID" align="center" prop="userId" />
      <el-table-column label="总积分" align="center" prop="totalPoints" />
      <el-table-column label="冻结积分" align="center" prop="frozenPoints" />
      <el-table-column label="乐观锁版本" align="center" prop="version" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-view"
            @click="handleViewData(scope.row)"
            v-hasPermi="['points:PtsAccount:query']"
          >详情</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['points:PtsAccount:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['points:PtsAccount:remove']"
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

    <!-- 积分账户详情抽屉 -->
    <PtsAccount-view-drawer ref="PtsAccountViewRef" />
    <!-- 添加或修改积分账户对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="100px">
        <el-row>
          <el-col :span="24">
            <el-form-item label="总积分" prop="totalPoints">
              <el-input v-model="form.totalPoints" placeholder="请输入总积分" />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="冻结积分" prop="frozenPoints">
              <el-input v-model="form.frozenPoints" placeholder="请输入冻结积分" />
            </el-form-item>
          </el-col>
          <el-col :span="24">
            <el-form-item label="乐观锁版本" prop="version">
              <el-input v-model="form.version" placeholder="请输入乐观锁版本" />
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
import { listPtsAccount, getPtsAccount, delPtsAccount, addPtsAccount, updatePtsAccount } from "@/api/points/PtsAccount"
import PtsAccountViewDrawer from "./view"

export default {
  name: "PtsAccount",
  components: { PtsAccountViewDrawer },
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
      // 积分账户表格数据
      PtsAccountList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        totalPoints: null,
        frozenPoints: null,
        version: null,
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        totalPoints: [
          { required: true, message: "总积分不能为空", trigger: "blur" }
        ],
        frozenPoints: [
          { required: true, message: "冻结积分不能为空", trigger: "blur" }
        ],
        version: [
          { required: true, message: "乐观锁版本不能为空", trigger: "blur" }
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
    /** 查询积分账户列表 */
    getList() {
      this.loading = true
      listPtsAccount(this.queryParams).then(response => {
        this.PtsAccountList = response.rows
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
        userId: null,
        totalPoints: null,
        frozenPoints: null,
        version: null,
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
      this.ids = selection.map(item => item.userId)
      this.single = selection.length !== 1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset()
      this.open = true
      this.title = "添加积分账户"
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset()
      const userId = row.userId || this.ids
      getPtsAccount(userId).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改积分账户"
      })
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.userId != null) {
            updatePtsAccount(this.form).then(response => {
              this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            })
          } else {
            addPtsAccount(this.form).then(response => {
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
      const userIds = row.userId || this.ids
      this.$modal.confirm('是否确认删除积分账户编号为"' + userIds + '"的数据项？').then(function() {
        return delPtsAccount(userIds)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {})
    },
    /** 详情按钮操作 */
    handleViewData(row) {
      this.$refs["PtsAccountViewRef"].open(row.userId)
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('points/PtsAccount/export', {
        ...this.queryParams
      }, `PtsAccount_${new Date().getTime()}.xlsx`)
    }
  }
}
</script>
