///  JhPickerTool.ets
///
///  Created by iotjin on 2024/12/25. 
///  description:  @pura/harmony-dialog 封装。JhDialog、JhToast、JhPickerTool共用同一默认配置

import { SheetOptions, DialogAction, DialogHelper, OnActionCallBack } from "@pura/harmony-dialog"
import { KColors } from "../configs/Colors"


const _labelKey = 'label' // 对象数组的文字字段
const _titleText = '请选择'
const _cancelText = '取消'
const _confirmText = '确认'

const _kTitleFontSize = 18.0
const _kBtnFontSize = 17.0
const _textFontSize = 18.0
const _selectTextFontSize = 20.0
const _kHeaderRadius = 10.0

const _bgColor = KColors.kPickerBgColor
const _titleColor = KColors.kPickerTitleColor
const _btnColor = KColors.kPickerBtnColor
// const  _headerColor = '#E6E6E6'
const _headerColor = KColors.kPickerHeaderColor
const _selectTextColor = KColors.kPickerTextColor
const _otherTextColor = KColors.kLightGreyTextColor

export interface JhPickerOptions {
  data?: ESObject[] // 数据源
  labelKey?: string, // 对象数组的文字字段, 默认_labelKey
  selectIndex?: number | number[]
  title?: ResourceStr
  leftText?: ResourceStr
  rightText?: ResourceStr
  onCancel?: () => void
  /// 选择回调
  /// 单列选择器返回选中行对象和index
  /// 多列选择器返回选中行对象数组和index数组
  onConfirm?: (selectValue: string | string[], selectIndexArr: ESObject) => void
}

export interface JhBottomSheetOptions {
  data?: Array<SheetOptions> | Array<ResourceStr>; // 数据源
  title?: ResourceStr
  /// 选择回调
  /// index 从上往下 0，1，2
  clickCallback?: (selectIndex: number, selectText: string) => void
}

export class JhPickerTool {
  /**
   * 底部弹框
   * @param options
   */
  public static showBottomSheet(options: JhBottomSheetOptions) {
    if ((options.data ?? []).length == 0) {
      return
    }
    DialogHelper.showBottomSheetDialog({
      title: options.title ?? '',
      titleFontColor: _titleColor,
      cancelValue: _cancelText,
      sheets: options.data ?? [],
      cornerRadius: _kHeaderRadius,
      backgroundColor: _bgColor,
      autoCancel: true, // 点击遮障层时，是否关闭弹窗，true表示关闭弹窗。默认关闭
      backCancel: false, // 点击返回键或手势返回时，是否关闭弹窗；实现onWillDismiss函数时，该参数不起作用。默认不关闭
      actionCancel: true, // 点击操作按钮时，是否关闭弹窗。false表示不关闭弹窗。
      onAction: (index) => {
        const isStringArray = JhPickerTool.isOneStringArray(options.data)
        const selectedText: string = isStringArray ? options.data![index] : options.data![index]['value']
        options.clickCallback?.(index, selectedText)
      }
    })
  }

  /**
   * 单列选择器
   * 单列选择器返回选中行对象和index
   * @param options
   */
  public static showStringPicker(options: JhPickerOptions) {
    const originalList: ESObject[] = options.data ?? []
    if (originalList.length == 0 || !JhPickerTool.isOneDimensionalArray(originalList)) {
      return
    }
    const isStringArray = JhPickerTool.isOneStringArray(originalList)
    const labelKey = options.labelKey ?? _labelKey
    const tempList: string[] = originalList.map((item: ESObject) => {
      return (isStringArray ? item : item[labelKey]) as string
    })

    DialogHelper.showTextPickerDialog({
      range: tempList,
      value: tempList[options.selectIndex as number ?? 0],
      title: options.title ?? _titleText,
      titleFontColor: _titleColor,
      titleBackground: _headerColor,
      primaryButton: {
        value: options.leftText ?? _cancelText,
        fontColor: _btnColor,
      },
      secondaryButton: {
        value: options.rightText ?? _confirmText,
        fontColor: _btnColor,
      },
      //设置所有选项中最上和最下两个选项的文本颜色、字号、字体粗细。
      disappearTextStyle: { color: _otherTextColor, font: { size: _textFontSize } },
      //设置所有选项中除了最上、最下及选中项以外的文本颜色、字号、字体粗细。
      textStyle: { color: _otherTextColor, font: { size: _textFontSize } },
      //设置选中项的文本颜色、字号、字体粗细。
      selectedTextStyle: { color: _selectTextColor, font: { size: _selectTextFontSize } },
      cornerRadius: _kHeaderRadius,
      backgroundColor: _bgColor,
      canLoop: false,
      autoCancel: true, // 点击遮障层时，是否关闭弹窗，true表示关闭弹窗。默认关闭
      backCancel: false, // 点击返回键或手势返回时，是否关闭弹窗；实现onWillDismiss函数时，该参数不起作用。默认不关闭
      actionCancel: true, // 点击操作按钮时，是否关闭弹窗。false表示不关闭弹窗。
      onChange: (value: string | string[], index: number | number[]): void => {
        // console.log(`value: ${value}`)
        // console.log(`index: ${index}`)
      },
      onAction: (action: number, dialogId: string, value: string | string[]) => {
        if (action == DialogAction.ONE) {
          options.onCancel?.()
        } else {
          if (isStringArray) {
            const foundIndex = tempList.findIndex((item) => item === value)
            const selectIndex = foundIndex === -1 ? 0 : foundIndex
            options.onConfirm?.(value, selectIndex)
          } else {
            const foundIndex = originalList.findIndex((item: ESObject) => item[labelKey] === value)
            const selectIndex = foundIndex === -1 ? 0 : foundIndex
            options.onConfirm?.(originalList[selectIndex], selectIndex)
          }
        }
      }
    })
  }

  /**
   * 多列选择器
   * 多列选择器返回选中行对象数组和index数组
   * @param options
   */
  public static showArrayPicker(options: JhPickerOptions) {
    const originalList: ESObject[] = options.data ?? []
    if (originalList.length == 0 || JhPickerTool.isOneDimensionalArray(originalList)) {
      return
    }
    const isMultiStringArray = JhPickerTool.isMultiStringArray(originalList)
    const labelKey = options.labelKey ?? _labelKey

    let tempList: string[][] = originalList
    if (!isMultiStringArray) {
      const labelArr: string[][] = originalList.map((subArray: ESObject) => {
        return subArray.map((item: ESObject) => item[labelKey] as string) as string[]
      })
      tempList = labelArr
    }

    let valueList: string[] = []
    if (options.selectIndex && Array.isArray(options.selectIndex)) {
      for (let i = 0; i < options.selectIndex!.length; i++) {
        let columnData: ESObject = originalList[i]
        const index = options.selectIndex![i]
        if (index >= 0 && index < columnData.length) {
          valueList.push(isMultiStringArray ? columnData[index] : columnData[index][labelKey])
        } else {
          valueList.push(isMultiStringArray ? columnData[0] : columnData[0][labelKey])
        }
      }
    }
    DialogHelper.showTextPickerDialog({
      range: tempList,
      value: valueList,
      title: options.title ?? _titleText,
      titleFontColor: _titleColor,
      titleBackground: _headerColor,
      primaryButton: {
        value: options.leftText ?? _cancelText,
        fontColor: _btnColor,
      },
      secondaryButton: {
        value: options.rightText ?? _confirmText,
        fontColor: _btnColor,
      },
      //设置所有选项中最上和最下两个选项的文本颜色、字号、字体粗细。
      disappearTextStyle: { color: _otherTextColor, font: { size: _textFontSize } },
      //设置所有选项中除了最上、最下及选中项以外的文本颜色、字号、字体粗细。
      textStyle: { color: _otherTextColor, font: { size: _textFontSize } },
      //设置选中项的文本颜色、字号、字体粗细。
      selectedTextStyle: { color: _selectTextColor, font: { size: _selectTextFontSize } },
      cornerRadius: _kHeaderRadius,
      backgroundColor: _bgColor,
      canLoop: false,
      autoCancel: true, // 点击遮障层时，是否关闭弹窗，true表示关闭弹窗。默认关闭
      backCancel: false, // 点击返回键或手势返回时，是否关闭弹窗；实现onWillDismiss函数时，该参数不起作用。默认不关闭
      actionCancel: true, // 点击操作按钮时，是否关闭弹窗。false表示不关闭弹窗。
      onChange: (value: string | string[], index: number | number[]): void => {
        // console.log(`value: ${value}`)
        // console.log(`index: ${index}`)
      },
      onAction: (action: number, dialogId: string, values: string | string[]) => {
        if (action == DialogAction.ONE) {
          options.onCancel?.()
        } else {
          if (Array.isArray(values)) {
            let selectItemArr: ESObject = []
            let selectIndexArr: number[] = []
            for (let i = 0; i < values.length; i++) {
              let columnData: ESObject = originalList[i]
              const value = values[i]
              const foundIndex: number = columnData.findIndex((item: ESObject) => (isMultiStringArray ? item : item[labelKey]) === value)
              const selectIndex = foundIndex === -1 ? 0 : foundIndex
              selectIndexArr.push(selectIndex)
              selectItemArr.push(columnData[selectIndex])
            }
            options.onConfirm?.(selectItemArr, selectIndexArr)
          }
        }
      }
    })
  }

  /**
   * 是否是一维数组
   * @param arr
   * @returns
   */
  public static isOneDimensionalArray(arr: ESObject[]) {
    // 检查是否为数组，并且数组内元素不是数组, 使用 some 方法检查是否有任何元素是数组，如果存在，则说明是非一维数组
    return Array.isArray(arr) && !arr.some((item: ESObject) => Array.isArray(item))
  }

  /**
   * 是否是一维字符串数组
   * @param arr
   * @returns
   */
  public static isOneStringArray(arr: ESObject[]) {
    return Array.isArray(arr) && arr.every((item: ESObject) => typeof item === 'string')
  }

  /**
   * 是否是多维字符串数组
   * @param arr
   * @returns
   */
  public static isMultiStringArray(arr: ESObject[]) {
    // 如果不是数组，直接返回 false
    if (!Array.isArray(arr)) {
      return false
    }
    // 检查数组中的每个元素是否是字符串数组
    return arr.every((item: ESObject): boolean => JhPickerTool.isOneStringArray(item))
  }
}