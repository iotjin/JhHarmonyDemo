///  Request.ets
///
///  Created by iotjin on 2024/08/09. 
///  description: axios工具类

import axios, { InternalAxiosRequestConfig, AxiosResponse, AxiosError } from '@ohos/axios';
import { JhProgressHUD } from '../components/JhProgressHUD';
import { JhAESPreferencesUtils } from '../utils/JhPreferencesUtils';
import { APIs } from './APIs';


// 创建 axios 实例
const service = axios.create({
  baseURL: APIs.apiPrefix,
  timeout: 50000,
  headers: { 'Content-Type': 'application/json;charset=utf-8' }
})

// default token
const defaultToken = ''
const kRefreshTokenUrl = APIs.refreshToken

function getToken() {
  const token = JhAESPreferencesUtils.getString('accessToken') ?? defaultToken
  return token
}

function setToken(accessToken: string) {
  JhAESPreferencesUtils.saveString('accessToken', accessToken)
}

function getRefreshToken() {
  const refreshToken = JhAESPreferencesUtils.getString('refreshToken') ?? ''
  return refreshToken
}

function setRefreshToken(refreshToken: string) {
  JhAESPreferencesUtils.saveString('refreshToken', refreshToken)
}

// 请求拦截器
service.interceptors.request.use(
  (config: InternalAxiosRequestConfig) => {
    const accessToken = getToken()
    if (accessToken) {
      config.headers.Authorization = 'Bearer ' + accessToken
    }
    return config
  },
  (error: AxiosError) => {
    return Promise.reject(error)
  }
)

let isRefreshing = false

// 响应拦截器
service.interceptors.response.use(
  (response: AxiosResponse) => {
    const code: number = response.data['code']
    const msg: string = response.data['msg']
    if (code === 200) {
      return response.data
    }

    // 响应数据为二进制流处理(Excel导出)
    if (response.data instanceof ArrayBuffer) {
      return response
    }

    // JhProgressHUD.showText(msg || '系统错误') // 在HttpUtils中处理
    return Promise.reject(new Error(msg || 'Error'))
  },
  async (error: AxiosError) => {
    const originalRequest: InternalAxiosRequestConfig | undefined = error.config
    // token过期
    if (error.response?.status === 401 && !isRefreshing) {
      isRefreshing = true
      try {
        // 刷新 token
        await refreshTokenRequest()
        // 刷新 Token 成功后，重新发送原始请求
        return service(originalRequest)
      } catch (refreshError) {
        return Promise.reject(refreshError)
      } finally {
        isRefreshing = false
      }
    }

    console.log('Request err: ' + JSON.stringify(error)) // for debug
    JhProgressHUD.showText(error.message || '系统错误')
    return Promise.reject(error)
  }
)

// 刷新 Token 的函数示例
async function refreshTokenRequest() {
  const params: object = Object({ 'accessToken': getToken(), 'refreshToken': getRefreshToken() })
  service({
    url: kRefreshTokenUrl,
    method: 'get',
    params: params
  }).then((res: AxiosResponse) => {
    const accessToken: string = res['data']['accessToken']
    const refreshToken: string = res['data']['accessToken']
    // 保存token
    setToken(accessToken)
    setRefreshToken(refreshToken)
  }).catch((err: AxiosError) => {
    console.log("---------- 刷新Token失败！----------" + err)
  })
}

// 导出 axios 实例
export default service
