<template>
  <el-drawer title="积分流水详情" :visible.sync="visible" direction="rtl" size="60%" append-to-body :before-close="handleClose" custom-class="detail-drawer">
    <div v-loading="loading" class="drawer-content">
      <h4 class="section-header">基本信息</h4>
      <el-row :gutter="20" class="mb8">
        <el-col :span="12">
          <div class="info-item">
            <label class="info-label">用户ID：</label>
            <span class="info-value plaintext">
              {{ info.userId }}
            </span>
          </div>
        </el-col>
        <el-col :span="12">
          <div class="info-item">
            <label class="info-label">类型:1-增加;2-扣减：</label>
            <span class="info-value plaintext">
              {{ info.type }}
            </span>
          </div>
        </el-col>
      </el-row>
      <el-row :gutter="20" class="mb8">
        <el-col :span="12">
          <div class="info-item">
            <label class="info-label">变动数值：</label>
            <span class="info-value plaintext">
              {{ info.amount }}
            </span>
          </div>
        </el-col>
        <el-col :span="12">
          <div class="info-item">
            <label class="info-label">变动后余额快照：</label>
            <span class="info-value plaintext">
              {{ info.balanceSnapshot }}
            </span>
          </div>
        </el-col>
      </el-row>
      <el-row :gutter="20" class="mb8">
        <el-col :span="12">
          <div class="info-item">
            <label class="info-label">来源:ORDER,SIGN：</label>
            <span class="info-value plaintext">
              {{ info.sourceType }}
            </span>
          </div>
        </el-col>
        <el-col :span="12">
          <div class="info-item">
            <label class="info-label">来源业务ID(幂等)：</label>
            <span class="info-value plaintext">
              {{ info.sourceId }}
            </span>
          </div>
        </el-col>
      </el-row>
      <el-row :gutter="20" class="mb8">
        <el-col :span="12">
          <div class="info-item">
            <label class="info-label">${comment}：</label>
            <span class="info-value plaintext">
              {{ info.description }}
            </span>
          </div>
        </el-col>
      </el-row>
    </div>
  </el-drawer>
</template>

<script>
import { getPtsLog } from '@/api/points/PtsLog'

export default {
  name: 'PtsLogViewDrawer',
  data() {
    return {
      visible: false,
      loading: false,
      info: {}
    }
  },
  methods: {
    open(id) {
      this.visible = true
      this.loading = true
      getPtsLog(id).then(res => {
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
