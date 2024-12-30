///  JhDialog.ets
///
///  Created by iotjin on 2024/11/26.
///  description:  @pura/harmony-dialog 封装。JhDialog、JhToast、JhPickerTool共用同一默认配置

import { ActionCallBack, AnimationHelper, BaseDialogOptions, DialogAction, DialogHelper } from '@pura/harmony-dialog';
import { InputFilter } from '@pura/harmony-dialog/src/main/ets/model/InputFilter';
import { KColors } from '../configs/Colors';

const _loadingBgColor = '#CC000000'
const _closeTime = 1500
const _radius = 5.0
const _fontSize = 16.0

// Dialog 、Toast显示位置
const _alignment: Alignment = Alignment.Center
const _offset: Offset = { dx: 0.0, dy: 0.0 }

// Dialog 按钮文字颜色
const _cancelTextColor = '#999999'
const _confirmTextColor = KColors.kThemeColor
const _dialogBgColor = KColors.kAlertBgColor
const _dialogRadius = 8
const _title = '提示'
const _placeholder = '请输入'
const _cancelText = '取消'
const _confirmText = '确认'
const _btnStyle = ButtonStyleMode.TEXTUAL

export interface JhDialogOptions {
  title: ResourceStr
  message?: ResourceStr
  contentBuilder?: () => void // 自定义弹框内容
  contentAreaPadding?: Padding // 自定义弹框内容区内边距
  leftText?: ResourceStr
  rightText?: ResourceStr
  hiddenCancel?: boolean // 默认false
  clickBtnClose?: boolean // 点击确认按钮是否弹框消失，默认true
  // onCancel?: () => void
  // onConfirm?: (value: ResourceStr) => void
  onCancel?: ActionCallBack // 按钮的CallBack事件
  onConfirm?: ActionCallBack // 按钮的CallBack事件
}

export interface JhDialogInputOptions extends JhDialogOptions {
  inputText?: ResourceStr
  placeholder?: ResourceStr
  inputType?: InputType
  textAreaType?: TextAreaType
  fontColor?: ResourceColor; //字体颜色
  fontSize?: Length; //字体大小
  placeholderColor ?: ResourceColor //设置placeholder文本颜色。
  inputBackgroundColor?: ResourceColor; //输入框背景
  inputBorder?: BorderOptions; //输入框Border
  inputHeight?: Length; //输入框高度

  defaultFocus?: boolean //设置弹框默认获得焦点，打开弹窗同时弹出输入法
  maxLength?: number; //文本的最大输入字符数。  默认值：Infinity，可以无限输入。
  controller?: TextInputController; //TextInput组件的控制器
  inputFilter?: InputFilter; //通过正则表达式设置输入过滤器。
}

export interface JhCustomOptions extends BaseDialogOptions {
  width?: Dimension | Length; //宽度
  height?: Dimension | Length //高度
  alignment?: DialogAlignment
  offset?: Offset //弹窗相对alignment所在位置的偏移量。默认值：{ dx: 0, dy: 0 }
  transition?: TransitionEffect; //设置弹窗显示和退出的过渡效果。 AnimationHelper.transitionInDown(0)
  autoCancel?: boolean, // //点击遮障层时，是否关闭弹窗，true表示关闭弹窗。false表示不关闭弹
  backCancel?: boolean, // 点击返回键或手势返回时，是否关闭弹窗
}

export class JhDialog {
  /**
   * 设置默认统一样式
   * 初始化Dialog(在全局入口 page 处挂载)
   * 注：JhDialog、JhToast、JhPickerTool共用此默认配置
   */
  public static initConfig(context: UIContext) {
    DialogHelper.setDefaultConfig((config) => {
      config.uiContext = context
      config.autoCancel = false; //点击遮障层时，是否关闭弹窗，true表示关闭弹窗。false表示不关闭弹窗。默认值：true
      config.backCancel = false; //点击返回键或手势返回时，是否关闭弹窗；实现onWillDismiss函数时，该参数不起作用。true表示关闭弹窗。false表示不关闭弹窗。默认值：true。
      config.actionCancel = true; //点击操作按钮时，是否关闭弹窗。false表示不关闭弹窗。默认值：true。
      config.alignment = DialogAlignment.Center; //弹窗的对齐方式。
      config.offset = _offset; //弹窗相对alignment所在位置的偏移量。默认值：{ dx: 0, dy: 0 }
      config.maskColor = 0x11000000; //自定义蒙层颜色。默认值 0x33000000
      config.backgroundColor = _dialogBgColor; //弹窗背板颜色。默认值：Color.White
      config.backgroundBlurStyle = BlurStyle.COMPONENT_ULTRA_THICK; //弹窗背板模糊材质
      config.cornerRadius = _dialogRadius; //设置背板的圆角半径。可分别设置4个圆角的半径

      config.title = _title; //弹框标题
      config.primaryButton = _cancelText; //弹框左侧按钮。
      config.secondaryButton = _confirmText; //弹框右侧按钮。
      config.imageRes = undefined; //TipsDialog用到，展示的图片。
      config.imageSize = { width: '64vp', height: '64vp' }; //TipsDialog用到，自定义图片尺寸。默认值：64*64vp

      config.loading_loadSize = 60; //加载动画或进度条的大小
      config.loading_loadColor = Color.White; //加载动画或进度条的颜色
      config.loading_content = ''; //加载动画的提示文字
      config.loading_fontSize = _fontSize; //文字大小
      config.loading_fontColor = Color.White; //文字颜色
      config.loading_backgroundColor = _loadingBgColor; //背景颜色，八位色值前两位为透明度
      config.loading_borderRadius = _radius; //背景圆角

      // toast
      config.toast_fontSize = _fontSize; //文字大小
      config.toast_fontColor = Color.White; //文字颜色
      config.toast_backgroundColor = _loadingBgColor; //背景颜色，建议八位色值前两位为透明度
      config.toast_borderRadius = _radius; //背景圆角
      config.toast_padding = {
        top: 16,
        bottom: 16,
        left: 24,
        right: 24,
      }; //Padding
      config.toast_imageSize = { width: 30, height: 30 }; //Tip图片尺寸。默认值：45*45vp
      config.toast_duration = _closeTime; //显示时长(1500ms-10000ms)
      config.toast_durationLong = 5000; //显示时长
    });
  }


  /**
   * 关闭弹框
   * @param dialogId 目前弹框id
   */
  public static hide(dialogId: string) {
    DialogHelper.closeDialog(dialogId)
  }


  /**
   * 中间弹框
   * @param options
   */
  public static show(options: JhDialogOptions) {
    DialogHelper.showAlertDialog({
      title: options.title ?? _title,
      content: options.message ?? '',
      autoCancel: false, // 点击遮障层时，是否关闭弹窗，true表示关闭弹窗。
      backCancel: false, // 点击返回键或手势返回时，是否关闭弹窗；实现onWillDismiss函数时，该参数不起作用。
      actionCancel: options.clickBtnClose ?? true, // 点击操作按钮时，是否关闭弹窗。false表示不关闭弹窗。
      primaryButton: options.hiddenCancel ? null : {
        value: options.leftText ?? _cancelText,
        fontColor: _cancelTextColor,
        buttonStyle: _btnStyle
      },
      secondaryButton: {
        value: options.rightText ?? _confirmText,
        fontColor: _confirmTextColor,
        buttonStyle: _btnStyle
      },
      onAction: (action, dialogId, content) => {
        if (action == DialogAction.ONE) {
          options.onCancel?.(action, dialogId, content)
        } else {
          options.onConfirm?.(action, dialogId, content)
        }
      }
    })
  }


  /**
   * 中间录入弹框 - 单行
   * @param options
   */
  public static showInputDialog(options: JhDialogInputOptions) {
    DialogHelper.showTextInputDialog({
      title: options.title ?? _title,
      text: options.inputText as string,
      maxLength: options.maxLength,
      inputFilter: options.inputFilter,
      controller: options.controller,
      placeholder: options.placeholder ?? _placeholder,
      placeholderColor: options.placeholderColor,
      inputType: options.inputType ?? InputType.Normal,
      inputBorder: options.inputBorder ?? { radius: 8 },
      inputHeight: options.inputHeight,
      defaultFocus: true,
      alignment: DialogAlignment.Center,
      offset: _offset,
      contentAreaPadding: {
        top: 12,
        bottom: 16,
        left: 15,
        right: 15
      },
      onChange: (text) => {
        // console.log("onChange: " + text);
      },
      autoCancel: false, // 点击遮障层时，是否关闭弹窗，true表示关闭弹窗。
      backCancel: false, // 点击返回键或手势返回时，是否关闭弹窗；实现onWillDismiss函数时，该参数不起作用。
      actionCancel: options.clickBtnClose ?? true, // 点击操作按钮时，是否关闭弹窗。false表示不关闭弹窗。
      buttons: [
        options.hiddenCancel ? null : {
          value: options.leftText ?? _cancelText,
          fontColor: _cancelTextColor,
          buttonStyle: _btnStyle
        },
        {
          value: options.rightText ?? _confirmText,
          fontColor: _confirmTextColor,
          buttonStyle: _btnStyle
        },
      ],
      onAction: (action, dialogId, content) => {
        if (action == DialogAction.ONE) {
          options.onCancel?.(action, dialogId, content)
        } else {
          options.onConfirm?.(action, dialogId, content)
        }
      }
    })
  }


  /**
   * 中间录入弹框 - 多行
   * @param options
   */
  public static showTextAreaDialog(options: JhDialogInputOptions) {
    DialogHelper.showTextAreaDialog({
      title: options.title ?? _title,
      text: options.inputText as string,
      maxLength: options.maxLength,
      inputFilter: options.inputFilter,
      controller: options.controller,
      placeholder: options.placeholder ?? _placeholder,
      placeholderColor: options.placeholderColor,
      inputType: options.textAreaType ?? TextAreaType.NORMAL,
      inputBorder: options.inputBorder ?? { radius: 8 },
      inputHeight: options.inputHeight,
      defaultFocus: true,
      alignment: DialogAlignment.Center,
      offset: _offset,
      contentAreaPadding: {
        top: 12,
        bottom: 16,
        left: 15,
        right: 15
      },
      onChange: (text) => {
        // console.log("onChange: " + text);
      },
      autoCancel: false, // 点击遮障层时，是否关闭弹窗，true表示关闭弹窗。
      backCancel: false, // 点击返回键或手势返回时，是否关闭弹窗；实现onWillDismiss函数时，该参数不起作用。
      actionCancel: options.clickBtnClose ?? true, // 点击操作按钮时，是否关闭弹窗。false表示不关闭弹窗。
      buttons: [
        options.hiddenCancel ? null : {
          value: options.leftText ?? _cancelText,
          fontColor: _cancelTextColor,
          buttonStyle: _btnStyle
        },
        {
          value: options.rightText ?? _confirmText,
          fontColor: _confirmTextColor,
          buttonStyle: _btnStyle
        },
      ],
      onAction: (action, dialogId, content) => {
        if (action == DialogAction.ONE) {
          options.onCancel?.(action, dialogId, content)
        } else {
          options.onConfirm?.(action, dialogId, content)
        }
      }
    })
  }


  /**
   * 中间自定义弹框
   * @param options
   */
  public static showCustomDialog(options: JhDialogOptions) {
    DialogHelper.showCustomContentDialog({
      title: options.title ?? _title,
      contentBuilder: options.contentBuilder,
      contentAreaPadding: options.contentAreaPadding,
      autoCancel: false, // 点击遮障层时，是否关闭弹窗，true表示关闭弹窗。
      backCancel: false, // 点击返回键或手势返回时，是否关闭弹窗；实现onWillDismiss函数时，该参数不起作用。
      actionCancel: options.clickBtnClose ?? true, // 点击操作按钮时，是否关闭弹窗。false表示不关闭弹窗。
      buttons: [
        options.hiddenCancel ? null : {
          value: options.leftText ?? _cancelText,
          fontColor: _cancelTextColor,
          buttonStyle: _btnStyle
        },
        {
          value: options.rightText ?? _confirmText,
          fontColor: _confirmTextColor,
          buttonStyle: _btnStyle
        },
      ],
      onAction: (action, dialogId, content) => {
        if (action == DialogAction.ONE) {
          options.onCancel?.(action, dialogId, content)
        } else {
          options.onConfirm?.(action, dialogId, content)
        }
      }
    })
  }

  /**
   * 底部完全自定义弹框，默认高度260
   * @param builder
   * @param options 可不传
   */
  public static showBottomAllCustomDialog(builder: WrappedBuilder<[JhCustomOptions]>, options?: JhCustomOptions): string {
    let custom: JhCustomOptions = {
      height: options?.height ?? 260,
      alignment: options?.alignment ?? DialogAlignment.Bottom,
      offset: options?.offset ?? { dx: 0, dy: 0 },
      transition: options?.transition ?? AnimationHelper.transitionInDown(0),
      autoCancel: options?.autoCancel ?? true, // 点击遮障层时，是否关闭弹窗，true表示关闭弹窗。默认关闭
      backCancel: options?.backCancel ?? false, // 点击返回键或手势返回时，是否关闭弹窗；实现onWillDismiss函数时，该参数不起作用。默认不关闭
    };
    return JhDialog.showAllCustomDialog(builder, custom);
  }

  /**
   * 完全自定义弹框，默认底部弹出,高度260
   * @param builder
   * @param options 可不传
   * @returns
   */
  public static showAllCustomDialog(builder: WrappedBuilder<[JhCustomOptions]>, options?: JhCustomOptions): string {
    let custom: JhCustomOptions = {
      width: options?.width ?? '100%',
      height: options?.height ?? 260,
      alignment: options?.alignment ?? DialogAlignment.Bottom,
      offset: options?.offset ?? { dx: 0, dy: 0 },
      transition: options?.transition ?? AnimationHelper.transitionInDown(0),
      autoCancel: options?.autoCancel ?? true, // 点击遮障层时，是否关闭弹窗，true表示关闭弹窗。默认关闭
      backCancel: options?.backCancel ?? false, // 点击返回键或手势返回时，是否关闭弹窗；实现onWillDismiss函数时，该参数不起作用。默认不关闭
    };
    return DialogHelper.showCustomDialog(builder, custom);
  }

  /**
   * 完全自定义弹框2
   * @param builder
   * @param options
   * @returns
   */
  public static showAllCustomDialog2<T extends BaseDialogOptions>(builder: WrappedBuilder<[T]>, options: T): string {
    return DialogHelper.showCustomDialog(builder, options)
  }
}