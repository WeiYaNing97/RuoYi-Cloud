<template>
  <el-drawer title="积分账户详情" :visible.sync="visible" direction="rtl" size="60%" append-to-body :before-close="handleClose" custom-class="detail-drawer">
    <div v-loading="loading" class="drawer-content">
      <h4 class="section-header">基本信息</h4>
      <el-row :gutter="20" class="mb8">
        <el-col :span="12">
          <div class="info-item">
            <label class="info-label">总积分：</label>
            <span class="info-value plaintext">
              {{ info.totalPoints }}
            </span>
          </div>
        </el-col>
        <el-col :span="12">
          <div class="info-item">
            <label class="info-label">冻结积分：</label>
            <span class="info-value plaintext">
              {{ info.frozenPoints }}
            </span>
          </div>
        </el-col>
      </el-row>
      <el-row :gutter="20" class="mb8">
        <el-col :span="12">
          <div class="info-item">
            <label class="info-label">乐观锁版本：</label>
            <span class="info-value plaintext">
              {{ info.version }}
            </span>
          </div>
        </el-col>
      </el-row>
    </div>
  </el-drawer>
</template>

<script>
import { getPtsAccount } from '@/api/points/PtsAccount'

export default {
  name: 'PtsAccountViewDrawer',
  data() {
    return {
      visible: false,
      loading: false,
      info: {}
    }
  },
  methods: {
    open(userId) {
      this.visible = true
      this.loading = true
      getPtsAccount(userId).then(res => {
        this.info = res.data || {}
      }).finally(() => {
        this.loading = false
      })
    },
    handleClose() {
      this.visible = false
    }
  }
}
</script>
