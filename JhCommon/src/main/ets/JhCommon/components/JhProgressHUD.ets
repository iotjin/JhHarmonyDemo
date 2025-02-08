///  JhProgressHUD.ets
///
///  Created by iotjin on 2024/08/09.
///  description: 加载框(promptAction、@jxt/xt_hud 三方库封装)

import { promptAction, window } from '@kit.ArkUI';
import { XTHUDLoadingOptions, XTHUDProgressOptions, XTHUDReactiveBaseOptions, XTHUDToastOptions, XTPromptHUD } from '@jxt/xt_hud';

const _loadingBgColor = '#CC000000'
const _closeTime = 1000
const _radius = 5.0
const _fontSize = 16.0

// Toast显示位置
const _alignment: Alignment = Alignment.Center
const _offset: Offset = { dx: 0.0, dy: 0.0 }

enum _ToastType {
  text,
  success,
  error,
  info,
  loading,
}

export class JhProgressHUD {
  /// 初始化Loading(在 windowStage.loadContent 后执行初始化)
  public static initConfig(windowStage: window.WindowStage) {
    const context = windowStage.getMainWindowSync().getUIContext()
    JhProgressHUD.initXTPromptHUDConfig(context)
  }

  /// 初始化Loading(在全局入口 page 处挂载)
  public static initUIConfig(context: UIContext) {
    JhProgressHUD.initXTPromptHUDConfig(context)
  }

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
    JhProgressHUD._showToast(loadingText, _ToastType.text)
  }

  /// 成功弹框
  public static showSuccess(loadingText: ResourceStr) {
    JhProgressHUD._showToast(loadingText, _ToastType.success)
  }

  /// 失败弹框
  public static showError(loadingText: ResourceStr) {
    JhProgressHUD._showToast(loadingText, _ToastType.error)
  }

  /// 警告弹框
  public static showInfo(loadingText: ResourceStr) {
    JhProgressHUD._showToast(loadingText, _ToastType.info)
  }

  /// 加载中 - 系统样式
  public static showLoadingText(loadingText = '加载中...') {
    JhProgressHUD._showToast(loadingText, _ToastType.loading)
  }

  /// 加载中 - 圆环样式
  public static showRingLoadingText(loadingText = '加载中...') {
    JhProgressHUD._showLoading(loadingText)
  }

  /// 下载中 - 圆环进度条
  public static showProgressLoadingText(progress: number, loadingText = '正在下载...') {
    JhProgressHUD._showProgress(progress, loadingText)
  }

  /// 下载中 - 水平进度条
  public static showBarProgressLoadingText(progress: number, loadingText = '正在下载...') {
    JhProgressHUD._showBarProgress(progress, loadingText)
  }

  /// 隐藏加载框
  public static hide() {
    XTPromptHUD.hideAllToast()
    XTPromptHUD.hideAllLoading()
    XTPromptHUD.hideProgress()
    XTPromptHUD.hideCustomHUD()
  }

  /// 全局参数配置
  /// API文档 https://gitee.com/kukumalu/xthud
  private static initXTPromptHUDConfig(context: UIContext) {
    XTPromptHUD.globalConfigToast(context, (options: XTHUDToastOptions) => {
      options.isQueueMode = true // 同时只显示一个
      options.isModal = true // 是否为全屏，屏蔽交互
      options.closeOnPressBack = false // 控制是否点击系统返回键时关闭 HUD，默认 false，开启后触发返回关闭会执行 onCancel
      options.closeOnClickOutside = false // 控制是否点击 HUD 背景时关闭（isModal 为 true 时生效），默认 false，开启后触发点击背景关闭会执行 onCancel
      options.fontSize = _fontSize
      options.font = {
        size: _fontSize,
        // weight: 600
      }
      options.borderRadius = _radius
      options.backgroundColor = _loadingBgColor
      options.hidingDelay = _closeTime
      options.iconSize = { width: 30, height: 30 }
      options.textPadding = {
        top: 16,
        bottom: 16,
        left: 24,
        right: 24,
      }
    })
    XTPromptHUD.globalConfigLoading(context, (options: XTHUDLoadingOptions) => {
      options.isModal = true // 是否为全屏，屏蔽交互
      options.closeOnPressBack = false // 控制是否点击系统返回键时关闭 HUD，默认 false，开启后触发返回关闭会执行 onCancel
      options.closeOnClickOutside = false // 控制是否点击 HUD 背景时关闭（isModal 为 true 时生效），默认 false，开启后触发点击背景关闭会执行 onCancel
      options.fontSize = _fontSize
      options.font = {
        size: _fontSize,
        // weight: 600,
      }
      options.borderRadius = _radius
      options.backgroundColor = _loadingBgColor
      options.iconSize = { width: 50, height: 50 }
      options.iconMargin = {
        top: 16,
        bottom: 8,
        left: 24,
        right: 24,
      }
      options.textPadding = {
        top: 0,
        bottom: 16,
        left: 24,
        right: 24
      }
    })
    XTPromptHUD.globalConfigProgress(context, (options: XTHUDProgressOptions) => {
      options.isModal = true // 是否为全屏，屏蔽交互
      options.closeOnPressBack = false // 控制是否点击系统返回键时关闭 HUD，默认 false，开启后触发返回关闭会执行 onCancel
      options.closeOnClickOutside = false // 控制是否点击 HUD 背景时关闭（isModal 为 true 时生效），默认 false，开启后触发点击背景关闭会执行 onCancel
      options.fontSize = _fontSize
      options.font = {
        size: _fontSize,
        // weight: 600
      }
      options.borderRadius = _radius
      options.backgroundColor = _loadingBgColor
      options.iconSize = { width: 50, height: 50 }
      options.iconMargin = {
        top: 24,
        bottom: 16,
        left: 36,
        right: 36,
      }
      options.textPadding = {
        top: 0,
        bottom: 16,
        left: 24,
        right: 24
      }

      options.strokeWidth = 5
      options.progressFontSize = 5
      options.progressFont = {
        size: 12,
        weight: 600
      }
      options.progressTextColor = Color.White
      // options.autoHideWhenProgressCompletion = false
    })

    XTPromptHUD.globalConfigCustomHUD(context, (options: XTHUDReactiveBaseOptions) => {
      options.isModal = true // 是否为全屏，屏蔽交互
      options.closeOnPressBack = false // 控制是否点击系统返回键时关闭 HUD，默认 false，开启后触发返回关闭会执行 onCancel
      options.closeOnClickOutside = false // 控制是否点击 HUD 背景时关闭（isModal 为 true 时生效），默认 false，开启后触发点击背景关闭会执行 onCancel
      options.maskColor = _loadingBgColor
      // options.maskColor = '#33000000'
    })
  }

  private static _showToast(loadingText: ResourceStr, toastType: _ToastType) {
    if (toastType == _ToastType.text) {
      XTPromptHUD.showToast(loadingText)
    } else if (toastType == _ToastType.success) {
      XTPromptHUD.showSuccess(loadingText)
    } else if (toastType == _ToastType.error) {
      XTPromptHUD.showError(loadingText)
    } else if (toastType == _ToastType.info) {
      XTPromptHUD.showInfo(loadingText)
    } else if (toastType == _ToastType.loading) {
      XTPromptHUD.showLoading(loadingText, {
        iconMargin: loadingText == '' ? {
          top: 24,
          bottom: 24,
          left: 36,
          right: 36,
        } : {
          top: 16,
          bottom: 8,
          left: 24,
          right: 24,
        }
      })
    }
  }

  private static _showLoading(loadingText: ResourceStr) {
    XTPromptHUD.showRingLoading(loadingText, {
      iconSize: { width: 30, height: 30 },
      strokeWidth: 3,

      isModal: true,
      closeOnPressBack: false,
      closeOnClickOutside: false,
      fontSize: _fontSize,
      font: { size: _fontSize },
      borderRadius: _radius,
      backgroundColor: _loadingBgColor,
      iconMargin: loadingText == '' ? {
        top: 35,
        bottom: 35,
        left: 45,
        right: 45,
      } : {
        top: 16,
        bottom: 8,
        left: 24,
        right: 24,
      },
      textPadding: {
        top: 8,
        bottom: 16,
        left: 24,
        right: 24
      },
    })
  }

  private static _showProgress(progress: number, loadingText?: ResourceStr) {
    XTPromptHUD.showProgress(progress, loadingText, {
      iconMargin: {
        top: 24,
        bottom: loadingText == '' ? 24 : 16,
        left: 36,
        right: 36,
      }
    })
  }

  private static _showBarProgress(progress: number, loadingText?: ResourceStr) {
    XTPromptHUD.showBarProgress(progress, loadingText, {
      tintColor: Color.White,
      iconMargin: {
        top: 24,
        bottom: loadingText == '' ? 24 : 16,
        left: 36,
        right: 36,
      }
    })
  }
}