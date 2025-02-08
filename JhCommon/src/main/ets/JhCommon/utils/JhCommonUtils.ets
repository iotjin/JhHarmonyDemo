///  JhCommonUtils.ets
///
///  Created by iotjin on 2024/08/08.
///  description: 公共工具类

import { util } from '@kit.ArkTS'
import { RandomUtil } from '@pura/harmony-utils'

export class JhCommonUtils {
  /// 生成UUID
  public static generateUUID() {
    let uuid = util.generateRandomUUID(true)
    console.log("RFC 4122 Version 4 UUID:" + uuid.toString())
    return uuid
  }

  /**
   * 获取随机整数（默认包含最小值,不包含最大值）
   *
   * @param min
   * @param max
   * @returns
   */
  static getRandomInt(min: number = 0, max: number = Number.MAX_SAFE_INTEGER): number {
    return RandomUtil.getRandomInt(min, max)
  }
}

export function add(a: number, b: number) {
  return a + b
}