///  JhToast.ets
///
///  Created by iotjin on 2024/11/26.
///  description:  加载框(promptAction、@pura/harmony-dialog 三方库封装。JhDialog和JhToast共用同一默认配置)

import { promptAction } from '@kit.ArkUI';
import { DialogHelper, SpinType } from '@pura/harmony-dialog';

const _loadingBgColor = '#CC000000'
const _closeTime = 1500
const _radius = 5.0
const _fontSize = 16.0

// Toast显示位置
const _alignment: Alignment = Alignment.Center
const _offset: Offset = { dx: 0.0, dy: 0.0 }

enum _ToastType {
  text,
  TextLong,
  success,
  error,
  info,
  loading,
}

export class JhToast {
  /// 系统Toast
  public static showToast(loadingText: ResourceStr) {
    promptAction.showToast({
      message: loadingText,
      duration: _closeTime,
      alignment: _alignment,
      offset: _offset,
    })
  }

  /// 文字弹框
  public static showText(loadingText: ResourceStr) {
    JhToast._showToast(loadingText, _ToastType.text)
  }

  /// 文字长弹框
  public static showTextLong(loadingText: ResourceStr) {
    JhToast._showToast(loadingText, _ToastType.TextLong)
  }

  /// 成功弹框
  public static showSuccess(loadingText: ResourceStr) {
    JhToast._showToast(loadingText, _ToastType.success)
  }

  /// 失败弹框
  public static showError(loadingText: ResourceStr) {
    JhToast._showToast(loadingText, _ToastType.error)
  }

  /// 警告弹框
  public static showInfo(loadingText: ResourceStr) {
    JhToast._showToast(loadingText, _ToastType.info)
  }

  /// 加载中 - 系统样式
  public static showLoadingText(loadingText = '加载中...') {
    JhToast._showToast(loadingText, _ToastType.loading)
  }

  /// 加载中 - 圆环等自定义样式
  public static showRingLoadingText(loadingText = '加载中...', loadType: SpinType = 16) {
    JhToast._showLoading(loadingText, loadType)
  }

  /// 下载中 - 圆环进度条
  public static showProgressLoadingText(progress: number, loadingText = '正在下载...') {
    JhToast._showProgress(progress, loadingText)
  }

  /// 隐藏加载框
  public static hide() {
    DialogHelper.closeLoading();
  }

  private static _showToast(loadingText: ResourceStr, toastType: _ToastType) {
    if (toastType == _ToastType.text) {
      DialogHelper.showToast(loadingText, {
        fontSize: _fontSize,
        fontColor: Color.White,
        backgroundColor: _loadingBgColor,
        borderRadius: _radius,
        duration: _closeTime,
        padding: {
          top: 16,
          bottom: 16,
          left: 24,
          right: 24,
        },
      });
    } else if (toastType == _ToastType.TextLong) {
      DialogHelper.showToastLong(loadingText, {
        fontSize: _fontSize,
        fontColor: Color.White,
        backgroundColor: _loadingBgColor,
        borderRadius: _radius,
        padding: {
          top: 16,
          bottom: 16,
          left: 24,
          right: 24,
        },
      });
    } else if (toastType == _ToastType.loading) {
      JhToast._showLoading(loadingText)
    } else {
      let icon: ResourceStr = '';
      if (toastType == _ToastType.success) {
        icon = $rawfile("hud/hud_success.svg");
      }
      if (toastType == _ToastType.error) {
        icon = $rawfile("hud/hud_error.svg");
      }
      if (toastType == _ToastType.info) {
        icon = $rawfile("hud/hud_info.svg");
      }
      DialogHelper.showToastTip({
        message: loadingText,
        imageRes: icon,
        imageSize: { width: 30, height: 30 },
        fontSize: _fontSize,
        fontColor: Color.White,
        backgroundColor: _loadingBgColor,
        borderRadius: _radius,
        offset: _offset,
        padding: {
          top: 16,
          bottom: 16,
          left: 24,
          right: 24,
        },
        duration: _closeTime,
      })
    }
  }

  private static _showLoading(loadingText: ResourceStr, loadType?: SpinType) {
    DialogHelper.showLoadingDialog({
      loadType: loadType,
      content: loadingText,
      isModal: true, // 弹窗是否为模态窗口，模态窗口有蒙层，非模态窗口无蒙层。默认值：true，此时弹窗有蒙层。
      maskColor: Color.Transparent, // 自定义蒙层颜色。默认值 0x33000000
      autoCancel: false, // 点击遮障层时，是否关闭弹窗，true表示关闭弹窗。
      backCancel: false, // 点击返回键或手势返回时，是否关闭弹窗；实现onWillDismiss函数时，该参数不起作用。
      marginTop: loadType == null ? 8 : 16,
      loadSize: loadType == null ? 50 : 30,
      fontSize: _fontSize,
      fontColor: Color.White,
      backgroundColor: _loadingBgColor,
      borderRadius: _radius,
      offset: _offset,
      padding: {
        top: 16,
        bottom: 16,
        left: 36,
        right: 36,
      },
    })
  }

  private static _showProgress(progress: number, loadingText?: ResourceStr) {
    DialogHelper.showLoadingProgress({
      progress: progress,
      content: loadingText,
    });
    DialogHelper.updateLoading(loadingText as string, progress)
  }
}