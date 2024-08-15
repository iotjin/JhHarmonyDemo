///  JhPreferencesUtils.ets
///
///  Created by iotjin on 2024/08/09. 
///  description:  AES 数据存储（封装第三方）

import { PreferencesUtil } from '@pura/harmony-utils';
import { JhEncryptUtils } from './JhEncryptUtils';

/// AES 加密存储
export class JhAESPreferencesUtils {
  /// 存 String
  public static saveString(key: string, value: string) {
    key = JhEncryptUtils.aesEncrypt(key)
    value = JhEncryptUtils.aesEncrypt(value)
    PreferencesUtil.putSync(key, value)
  }

  /// 取 String
  public static getString(key: string): string | null {
    key = JhEncryptUtils.aesEncrypt(key)
    const enValue = PreferencesUtil.getStringSync(key)
    return JhEncryptUtils.aesDecrypt(enValue)
  }

  /// 存 boolean
  public static saveBool(key: string, value: boolean) {
    const newValue = value == true ? 'TRUE' : 'FALSE'
    JhAESPreferencesUtils.saveString(key, newValue)
  }

  /// 取 boolean
  public static getBool(key: string): boolean {
    const value = JhAESPreferencesUtils.getString(key)
    return value == 'TRUE' ? true : false
  }

  /// 存 number
  public static saveNumber(key: string, value: number) {
    const newValue = value.toString()
    JhAESPreferencesUtils.saveString(key, newValue)
  }

  /// 取 number
  public static getNumber(key: string): number {
    let value = JhAESPreferencesUtils.getString(key)
    value = (value == '' || value == null) ? '0' : value
    return Number(value)
  }

  /// 存 Model
  public static saveModel(key: string, value: Object) {
    let jsonString: string = JSON.stringify(value)
    JhAESPreferencesUtils.saveString(key, jsonString)
  }

  /// 取 Model
  public static getModel(key: string): Object | null {
    let jsonStr = JhAESPreferencesUtils.getString(key)
    return jsonStr ? JSON.parse(jsonStr) : null
  }

  /// 移除单个
  public static delete(key: string) {
    key = JhEncryptUtils.aesEncrypt(key)
    PreferencesUtil.deleteSync(key)
  }

  /// 移除所有
  public static clear() {
    PreferencesUtil.clear()
  }

  /// 根据key检查缓存值是否存在
  public static has(key: string): boolean {
    key = JhEncryptUtils.aesEncrypt(key)
    return PreferencesUtil.hasSync(key)
  }
}

/// 数据存储（不使用AES加密）
export class JhPreferencesUtils {
  /// 存 String
  public static saveString(key: string, value: string) {
    PreferencesUtil.putSync(key, value)
  }

  /// 取 String
  public static getString(key: string): string | null {
    return PreferencesUtil.getStringSync(key)
  }

  /// 存 boolean
  public static saveBool(key: string, value: boolean) {
    const newValue = value == true ? 'TRUE' : 'FALSE'
    JhAESPreferencesUtils.saveString(key, newValue)
  }

  /// 取 boolean
  public static getBool(key: string): boolean {
    const value = JhAESPreferencesUtils.getString(key)
    return value == 'TRUE' ? true : false
  }

  /// 存 number
  public static saveNumber(key: string, value: number) {
    const newValue = value.toString()
    JhAESPreferencesUtils.saveString(key, newValue)
  }

  /// 取 number
  public static getNumber(key: string): number {
    let value = JhAESPreferencesUtils.getString(key)
    value = (value == '' || value == null) ? '0' : value
    return Number(value)
  }

  /// 存 Model
  public static saveModel(key: string, value: Object) {
    let jsonString: string = JSON.stringify(value)
    JhAESPreferencesUtils.saveString(key, jsonString)
  }

  /// 取 Model
  public static getModel(key: string): Object | null {
    let jsonStr = JhAESPreferencesUtils.getString(key)
    return jsonStr ? JSON.parse(jsonStr) : null
  }

  /// 移除单个
  public static remove(key: string) {
    PreferencesUtil.deleteSync(key)
  }

  /// 移除所有
  public static clear() {
    PreferencesUtil.clear()
  }

  /// 根据key检查缓存值是否存在
  public static has(key: string): boolean {
    return PreferencesUtil.hasSync(key)
  }
}