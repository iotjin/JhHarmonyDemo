///  JhAlert.ets
///
///  Created by iotjin on 2024/08/23. 
///  description:  

import { DialogUtil } from '@pura/harmony-utils';
import { ButtonOptions } from '@pura/harmony-utils/src/main/ets/entity/DialogOptions';

const _borderRadius = 5.0
const _cancelText = '取消'
const _confirmText = '确认'

interface JhAlertOptions {
  title: ResourceStr
  message?: ResourceStr
  leftText?: ResourceStr
  rightText?: ResourceStr
  buttons?: Array<ButtonOptions | ResourceStr>
  onCancel?: () => void
  onConfirm?: () => void
}

enum DatePickerType {
  YMD,
  YMD_HM,
}

interface JhDatePickerOptions {
  type: DatePickerType
  selected?: Date
  start?: Date
  end?: Date
  showTime?: boolean
  lunar?: boolean
  lunarSwitch?: boolean
  onCancel?: () => void
  onConfirm?: (value: Date) => void
}

interface JhTextPickerOptions {
  data: string[] | string[][] | Resource | TextPickerRangeContent[] | TextCascadePickerRangeContent[];
  value?: string | string[];
  selected?: number | number[];
  onCancel?: () => void
  onConfirm?: (value: TextPickerResult) => void
}

export class JhAlert {
  /**
   * 设置默认统一样式
   */
  public static initConfig() {
    DialogUtil.setDefaultConfig((config) => {
      config.title = ''
      config.alignment = DialogAlignment.Center
      config.backgroundColor = Color.White
      config.cornerRadius = {
        topLeft: _borderRadius,
        topRight: _borderRadius,
        bottomLeft: _borderRadius,
        bottomRight: _borderRadius
      }
      config.autoCancel = false
    });
  }

  /**
   * 系统中间弹框
   * @param options
   */
  public static showSystemAlert(options: JhAlertOptions) {
    AlertDialog.show(
      {
        title: options.title,
        message: options.message ?? '',
        autoCancel: true,
        buttons: [
          {
            value: options.leftText ?? _cancelText,
            fontColor: Color.Black,
            action: () => {
              options.onCancel?.()
            }
          },
          {
            value: options.rightText ?? _confirmText,
            fontColor: Color.Black,
            action: () => {
              options.onConfirm?.()
            }
          }
        ],
        cancel: () => {
          console.info('Closed callbacks')
        },
      }
    )
  }

  /**
   * 中间弹框
   * @param options
   */
  public static showAlert(options: JhAlertOptions) {
    DialogUtil.showPrimaryDialog({
      title: options.title,
      message: options.message ?? '',
      primaryButton: {
        value: options.leftText ?? _cancelText,
        fontColor: Color.Black,
        action: () => {
          options.onCancel?.()
        }
      },
      secondaryButton: {
        value: options.rightText ?? _confirmText,
        fontColor: Color.Black,
        action: () => {
          options.onConfirm?.()
        }
      },
    })
  }

  /**
   * 中间弹框，黑色按钮文字
   * @param options
   */
  public static showDialog(options: JhAlertOptions) {
    DialogUtil.showDialog({
      title: options.title,
      message: options.message ?? '',
      buttons: [
        {
          value: options.leftText ?? _cancelText,
          fontColor: Color.Black,
          action: () => {
            options.onCancel?.()
          }
        },
        {
          value: options.rightText ?? _confirmText,
          fontColor: Color.Black,
          action: () => {
            options.onConfirm?.()
          }
        },
      ],
    })
  }

  /**
   * 中间弹框，多按钮
   * @param options
   */
  public static showMultiButtonsAlert(options: JhAlertOptions) {
    DialogUtil.showDialog({
      title: options.title,
      message: options.message, // 必填
      buttons: options.buttons,
    })
  }

  /**
   * 中间弹框，时间选择器
   * @param options
   */
  public static showDatePicker(options?: JhDatePickerOptions) {
    if (options?.type === DatePickerType.YMD) {
      DialogUtil.showCalendarPicker({
        selected: options?.selected,
        onAccept: (value) => {
          options?.onConfirm?.(value)
        },
        onCancel: () => {
          options?.onCancel?.()
        }
      })
    }
    if (options?.type === DatePickerType.YMD_HM) {
      DialogUtil.showDatePicker({
        selected: options?.selected,
        start: options?.start,
        end: options?.end,
        showTime: options?.showTime ?? true,
        lunar: options?.lunar ?? false,
        lunarSwitch: options?.lunarSwitch ?? false,
        onDateAccept: (value) => {
          options?.onConfirm?.(value)
        },
        onCancel: () => {
          options?.onCancel?.()
        }
      })
    }
  }

  /**
   * 中间弹框，文本选择器
   * @param options
   */
  public static showTextPicker(options: JhTextPickerOptions) {
    DialogUtil.showTextPicker({
      range: options.data,
      value: options.value,
      selected: options.selected,
      canLoop: false,
      onAccept: (value: TextPickerResult) => {
        options.onConfirm?.(value)
      },
      onCancel: () => {
        options.onCancel?.()
      }
    })
  }
}
