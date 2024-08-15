///  JhCommonUtils.ets
///
///  Created by iotjin on 2024/08/08.
///  description: 公共工具类

import { util } from '@kit.ArkTS'

export class JhCommonUtils {
  /// 生成UUID
  public static generateUUID() {
    let uuid = util.generateRandomUUID(true)
    console.log("RFC 4122 Version 4 UUID:" + uuid.toString())
    return uuid
  }
}

export function add(a: number, b: number) {
  return a + b
}