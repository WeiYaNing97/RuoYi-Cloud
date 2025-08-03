<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="用户名" prop="username">
        <el-input
          v-model="queryParams.username"
          placeholder="请输入用户名"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="用户邮箱地址" prop="email">
        <el-input
          v-model="queryParams.email"
          placeholder="请输入用户邮箱地址"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="用户密码哈希值" prop="passwordHash">
        <el-input
          v-model="queryParams.passwordHash"
          placeholder="请输入用户密码哈希值"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="用户联系电话" prop="phone">
        <el-input
          v-model="queryParams.phone"
          placeholder="请输入用户联系电话"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="用户角色" prop="role">
        <el-select v-model="queryParams.role" placeholder="请选择用户角色">
          <el-option v-for="item in roleList"
                     :key="item.value"
                     :label="item.label"
                     :value="item.value"/>
        </el-select>
      </el-form-item>
      <el-form-item label="用户账户是否激活" prop="isActive">
        <el-select v-model="queryParams.isActive" placeholder="请选择用户账户是否激活">
          <el-option v-for="item in Userstate"
                     :key="item.value"
                     :label="item.label"
                     :value="item.value"/>
        </el-select>
      </el-form-item>
      <el-form-item label="用户上次登录时间" prop="lastLogin">
        <el-date-picker clearable
                        v-model="queryParams.lastLogin"
                        type="date"
                        value-format="yyyy-MM-dd"
                        placeholder="请选择用户上次登录时间">
        </el-date-picker>
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
          v-hasPermi="['example:ExampleUsers:add']"
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
          v-hasPermi="['example:ExampleUsers:edit']"
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
          v-hasPermi="['example:ExampleUsers:remove']"
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
          v-hasPermi="['example:ExampleUsers:export']"
        >导出
        </el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="ExampleUsersList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center"/>
      <el-table-column label="用户的唯一标识符" align="center" prop="exampleId"/>
      <el-table-column label="用户名" align="center" prop="username"/>
      <el-table-column label="用户邮箱地址" align="center" prop="email"/>
      <el-table-column label="用户密码哈希值" align="center" prop="passwordHash"/>
      <el-table-column label="用户联系电话" align="center" prop="phone"/>
      <el-table-column label="用户头像URL" align="center" prop="avatarUrl">
        <template slot-scope="scope">
          <img :src="scope.row.avatarUrl" style="width: 50px; height: 50px; border-radius: 4px"/>
        </template>
      </el-table-column>

      <el-table-column label="用户角色" align="center" prop="role">
        <template slot-scope="scope">
          {{ getRoleLabel(scope.row.role) }}
        </template>
      </el-table-column>

      <el-table-column label="用户账户是否激活" align="center" prop="isActive">
        <template slot-scope="scope">
          {{ getUserstate(scope.row.isActive) }}
        </template>
      </el-table-column>
      <el-table-column label="用户上次登录时间" align="center" prop="lastLogin" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.lastLogin, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
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
            v-hasPermi="['example:ExampleUsers:edit']"
          >修改
          </el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['example:ExampleUsers:remove']"
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

    <!-- 添加或修改存储用户的信息对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="用户名" prop="username">
          <el-input v-model="form.username" placeholder="请输入用户名"/>
        </el-form-item>
        <el-form-item label="用户邮箱地址" prop="email">
          <el-input v-model="form.email" placeholder="请输入用户邮箱地址"/>
        </el-form-item>
        <el-form-item label="用户密码哈希值" prop="passwordHash">
          <el-input v-model="form.passwordHash" placeholder="请输入用户密码哈希值"/>
        </el-form-item>
        <el-form-item label="用户联系电话" prop="phone">
          <el-input v-model="form.phone" placeholder="请输入用户联系电话"/>
        </el-form-item>

        <el-form-item label="用户头像" prop="avatarUrl">
          <el-upload
            action="/dev-api/practice/oss/upload"
            :headers="{ 'Authorization': 'Bearer ' + $store.state.user.token }"
            :show-file-list="false"
            :on-success="handleAvatarSuccess"
            :before-upload="beforeAvatarUpload">
            <img v-if="form.avatarUrl" :src="form.avatarUrl" class="avatar"/>
            <i v-else class="el-icon-plus avatar-uploader-icon"></i>
          </el-upload>
        </el-form-item>

        <!-- 修改成下拉框选择      -->
        <el-form-item label="用户角色" prop="role">
          <el-select v-model="form.role" placeholder="请下拉选择所属类别" clearable
                     :style="{width: '100%'}" @visible-change="getRoleList">
            <el-option v-for="(item, index) in roleList"
                       :key="index"
                       :label="item.label"
                       :value="item.value"
                       :disabled="item.disabled"></el-option>
          </el-select>
        </el-form-item>


        <el-form-item label="用户账户是否激活" prop="isActive">
          <el-select v-model="form.isActive" placeholder="请下拉选择用户账户是否激活" clearable
                     :style="{width: '100%'}">
            <el-option v-for="(item, index) in Userstate"
                       :key="index"
                       :label="item.label"
                       :value="item.value"
                       :disabled="item.disabled"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="用户上次登录时间" prop="lastLogin">
          <el-date-picker clearable
                          v-model="form.lastLogin"
                          type="date"
                          value-format="yyyy-MM-dd"
                          placeholder="请选择用户上次登录时间">
          </el-date-picker>
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
<style>
.avatar-uploader .el-upload {
  border: 1px dashed #d9d9d9;
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
}

.avatar-uploader .el-upload:hover {
  border-color: #409EFF;
}

.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 178px;
  height: 178px;
  line-height: 178px;
  text-align: center;
}

.avatar {
  width: 178px;
  height: 178px;
  display: block;
}
</style>
<script>
import {
  listExampleUsers,
  getExampleUsers,
  delExampleUsers,
  addExampleUsers,
  updateExampleUsers,
  listRole
} from "@/api/example/ExampleUsers"
import {getToken} from "@/utils/auth"

export default {
  name: "ExampleUsers",
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
      // 存储用户的信息表格数据
      ExampleUsersList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        username: null,
        email: null,
        passwordHash: null,
        phone: null,
        avatarUrl: null,
        role: null,
        isActive: null,
        lastLogin: null,
        createdAt: null,
        updatedAt: null
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        username: [
          {required: true, message: "用户名不能为空", trigger: "blur"}
        ],
        email: [
          {required: true, message: "用户邮箱地址不能为空", trigger: "blur"}
        ],
        passwordHash: [
          {required: true, message: "用户密码哈希值不能为空", trigger: "blur"}
        ],
        role: [
          {required: true, message: "用户角色不能为空", trigger: "blur"}
        ],
        isActive: [
          {required: true, message: "用户账户是否激活不能为空", trigger: "blur"}
        ],
      },
      /* 角色数组 */
      roleList: [{
        "label": "选项一",
        "value": 1
      }, {
        "label": "选项二",
        "value": 2
      }],
      /* 用户状态 */
      Userstate: [{
        "label": "激活",
        "value": 1
      }, {
        "label": "未激活",
        "value": 0
      }
      ]
    }
  },
  created() {
    this.getRoleList()
    this.getList()
  },
  methods: {

    getRoleLabel(id) {
      const item = this.roleList.find(v => v.value === id);
      return item ? item.label : id;
    },
    getUserstate(id) {
      return id === 1 ? "激活" : "未激活";
    },

    /** 获取角色信息 */
    getRoleList() {
      listRole().then(response => {
          this.roleList = []
          response.rows.map(item => (this.roleList.push(
            {
              label: item.roleName,
              value: item.roleId
            }))
          )
        }
      )
    },
    /** 查询存储用户的信息列表 */
    getList() {
      this.loading = true
      listExampleUsers(this.queryParams).then(response => {
        this.ExampleUsersList = response.rows
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
        username: null,
        email: null,
        passwordHash: null,
        phone: null,
        avatarUrl: null,
        role: null,
        isActive: null,
        lastLogin: null,
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
      this.title = "添加存储用户的信息"
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset()
      const exampleId = row.exampleId || this.ids
      getExampleUsers(exampleId).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改存储用户的信息"
      })
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.exampleId != null) {
            updateExampleUsers(this.form).then(response => {
              this.$modal.msgSuccess("修改成功")
              this.open = false
              this.getList()
            })
          } else {
            addExampleUsers(this.form).then(response => {
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
      this.$modal.confirm('是否确认删除存储用户的信息编号为"' + exampleIds + '"的数据项？').then(function () {
        return delExampleUsers(exampleIds)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess("删除成功")
      }).catch(() => {
      })
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('example/ExampleUsers/export', {
        ...this.queryParams
      }, `ExampleUsers_${new Date().getTime()}.xlsx`)
    },

    /* 用户头像上传 */
    handleAvatarSuccess(res, file) {

    if (this.form.avatarUrl != null) {
      delExampleUsersAvatarUrl(this.form.avatarUrl)
    }
    if (res.code === 200) {
      alert(res.msg)
      this.form.avatarUrl = res.msg // 假设后端返回结构为{ data: { data: 'url' } }
      this.$message.success('上传成功')
    } else {
      this.$message.error(res.msg || '上传失败')
    }
  },
    beforeAvatarUpload(file) {
      const isImage = file.type.startsWith('image/')
      const isLt2M = file.size / 1024 / 1024 < 2
      if (!isImage) {
        this.$message.error('只能上传图片!')
      }
      if (!isLt2M) {
        this.$message.error('图片大小不能超过2MB!')
      }
      return isImage && isLt2M
    }
  }
}
</script>
