///  JhTextList.ets
///
///  Created by iotjin on 2024/08/05.
///  description: 带箭头文本列表

import { KColors } from '../configs/Colors';
import { BaseNavigation } from './BaseNavigation';

export interface ItemType {
  label: string
  value?: string
}

const _lfSpace = 10.0
const _cellHeight = 50.0
const _lineHeight = 1.0
const _lineColor = KColors.kLineColor
const _lineDarkColor = KColors.kLineDarkColor
const _cellBgColor = KColors.kCellBgColor
const _cellBgDarkColor = KColors.kCellBgDarkColor

@Preview
@Component
export struct JhTextList {
  @Prop public title: string = ''
  @Prop public dataArr: ESObject[] = []
  public callBack?: (selectIndex: number, selectStr: string) => void

  build() {
    Scroll() {
      Column() {
        BaseNavigation({ title: this.title })
        List() {
          ForEach(this.dataArr, (item: ItemType, index: number) => {
            this.itemBuild(item, index)
          })
        }
        .width('100%')
        .height('100%')

        // // divider 第一个子组件上方和最后一个子组件下方不会绘制分割线
        // .divider({
        //   strokeWidth: _lineHeight, // 设置分割线宽度
        //   color: _lineColor // 设置分割线颜色
        // })
      }
    }
  }

  @Builder
  itemBuild(item: ItemType, index: number) {
    Column() {
      Row() {
        Text(item.label)
          .fontSize(18)
        Image($rawfile("common/ic_arrow_black.png"))
          .size({ width: 18, height: 18 })

      }
      .width('100%')
      .height(_cellHeight - _lineHeight)
      .justifyContent(FlexAlign.SpaceBetween)

      Row() {
      }
      .size({ width: '100%', height: _lineHeight })
      .backgroundColor(_lineColor)
    }
    .padding({ left: _lfSpace, right: _lfSpace })
    .backgroundColor(_cellBgColor)
    .onClick(() => this.callBack?.(index, item.label))
  }
}