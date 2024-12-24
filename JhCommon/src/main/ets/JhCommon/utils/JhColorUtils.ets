///  JhColorUtils.ets
///
///  Created by iotjin on 2024/08/14.
///  description: 颜色工具类

import { RandomUtil } from '@pura/harmony-utils'

export class JhColorUtils {
  /// 取随机颜色
  public static randomColor() {
    return RandomUtil.getRandomColor()
  }
}