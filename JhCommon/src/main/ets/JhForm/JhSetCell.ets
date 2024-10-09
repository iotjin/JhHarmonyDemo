///  JhSetCell.ets
///
///  Created by iotjin on 2024/10/08. 
///  description: 设置页的cell ，左侧图片，title, 右侧text ,箭头 , Edge 左15，右10


import { KColors } from '../JhCommon/configs/Colors'

const _titleFontSize = 15.0
const _textFontSize = 15.0
const _titleColor = KColors.kFormTitleColor
const _textColor = KColors.kFormInfoColor
const _lineColor = KColors.kFormLineColor
const _bgColor = KColors.kCellBgColor

const _imgWH = 22.0; // 左侧图片宽高
const _titleWidth = 150 // 左侧title默认宽
const _cellHeight = 50
const _leftEdge = 15.0; // 内部Widget 左边距 15
const _rightEdge = 10.0; // 内部Widget 左边距 10
const _lineLeftEdge = 15.0; // 线 左间距 默认 15
const _lineRightEdge = 0; // 线 右间距 默认  0
const _lineHeight = 0.6; // 底部线高


@Preview
@Component
export struct JhSetCell {
  @Prop public leftIcon?: ResourceStr = '' // 左侧图标，不设置时不显示 eg: $rawfile("svg/ic_login_user.svg")
  @BuilderParam leftWidget?: () => void // 左侧自定义组件，默认隐藏，优先级高于leftIcon
  @Prop public title: ResourceStr = '' // 左侧标题
  @Prop public titleWidth: number = _titleWidth // 标题宽度
  @Prop public titleStyle: TextStyle = { fontSize: _titleFontSize, fontColor: _titleColor }
  @Prop public text: ResourceStr = '' // 右侧文字
  @Prop public textStyle: TextStyle = { fontSize: _textFontSize, fontColor: _textColor }
  @Prop public textAlign: TextAlign = TextAlign.End // 右侧文字对齐方式，默认右对齐
  @BuilderParam rightWidget?: () => void // 右侧自定义组件，默认隐藏
  @Prop public hiddenArrow: boolean = false // 是否隐藏箭头，默认不隐藏
  @Prop public hiddenLine: boolean = false // 隐藏底部下划线，默认false
  @Prop public lineLeftEdge: number = _lineLeftEdge // 底部横线左侧距离 默认_leftEdge
  @Prop public lineRightEdge: number = _lineRightEdge // 底部横线右侧距离 默认0
  @Prop public cellHeight: number = _cellHeight //cell高度 默认_cellHeight
  @Prop public bgColor: ResourceColor = _bgColor // 背景颜色，默认白色
  @Prop public leftImgWH: number = _imgWH // 左侧图片宽高，默认_imgWH
  @Prop public arrowImgWH: number = _cellHeight / 2 // 箭头图片宽高
  public clickCallBack?: () => void // 点击回调
  // private
  @State private arrowIcon: ResourceStr = $rawfile("JhForm/ic_arrow_right.svg")

  build() {
    Column() {
      Row() {
        // left
        if (this.isShowLeftWidget()) {
          Row() {
            if (this.leftWidget) {
              this.leftWidget()
            } else {
              if (this.leftIcon) {
                Image(this.leftIcon)
                  .width(this.leftImgWH)
                  .height(this.leftImgWH)
              }
            }
            if ((this.leftIcon || this.leftWidget) && this.title) {
              Blank().width(10)
            }
            if (this.title) {
              Text(this.title)
                .fontColor(this.titleStyle.fontColor)
                .fontSize(this.titleStyle.fontSize)
                .textAlign(TextAlign.Start)
            }
          }
          .justifyContent(FlexAlign.Start)
          .width(this.titleWidth)
          .height('100%')
        }

        // center
        Row() {
          this.textBuilder()
        }
        .layoutWeight(1)
        .enabled(false)

        // right
        Row() {
          if (this.rightWidget) {
            this.rightWidget()
          }
          if (!this.hiddenArrow) {
            Image(this.arrowIcon)
              .fillColor('#C8C8C8')
              .width(this.arrowImgWH)
              .height(this.arrowImgWH)
          }
        }
        .height('100%')
      }
      .padding({ left: _leftEdge, right: _rightEdge })
      .height(this.cellHeight - 1)

      // bottom line
      this.lineBuilder()
    }
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Start)
    .size({ width: '100%', height: this.cellHeight })
    .backgroundColor(this.bgColor)
    .onClick(() => {
      this.clickCallBack?.()
    })
  }

  isShowLeftWidget() {
    return this.leftIcon || this.leftWidget || this.title
  }

  @Builder
  textBuilder() {
    Text(this.text)
      .fontSize(this.textStyle.fontSize)
      .fontColor(this.textStyle.fontColor)
      .textAlign(this.textAlign)
      .width('100%')
      .height('100%')
  }

  @Builder
  lineBuilder() {
    if (!this.hiddenLine) {
      Row()
        .width(`calc(100% - ${this.lineLeftEdge + this.lineRightEdge}vp)`)
        .height(_lineHeight)
        .margin({ left: this.lineLeftEdge, right: this.lineRightEdge })
        .backgroundColor(_lineColor)
    }
  }
}