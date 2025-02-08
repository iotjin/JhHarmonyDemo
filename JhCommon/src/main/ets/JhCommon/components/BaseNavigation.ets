///  BaseNavigation.ets
///
///  Created by iotjin on 2024/08/01.
///  description: 导航条

import { router } from '@kit.ArkUI';
import { KColors } from '../configs/Colors';

type imageType = string | Resource | PixelMap

interface ItemType {
  icon?: imageType // icon优先级高于text
  text?: ResourceStr
  itemCallBack?: () => void
}

const _titleFontSize = 18.0
const _textFontSize = 16.0
const _itemSpace = 15.0 // 右侧item内间距
const _imgWH = 22.0 // 右侧图片宽高
const _rate = 16 // 左右item占比

const _bgColor: ResourceColor = KColors.kThemeColor
const _bgDarkColor: ResourceColor = KColors.kNavBgDarkColor
const _titleColor: ResourceColor = KColors.kNavTitleColor

const _appbarStartColor = KColors.kGradientStartColor // 默认appBar 渐变开始色
const _appbarEndColor = KColors.kGradientEndColor // 默认appBar 渐变结束色

const _backImageWhite = $rawfile("common/ic_nav_back_white.png")
const _backImageBlack = $rawfile("common/ic_nav_back_black.png")

@Preview
@Component
export struct BaseNavigation {
  @Prop public title: ResourceStr = '' // 标题文字
  private isCenterTitle: boolean = true
  @Prop public titleFontSize: number = _titleFontSize
  @Prop public titleTextAlign: TextAlign = this.isCenterTitle ? TextAlign.Center : TextAlign.Start
  @Prop @Watch('onChangeBgColor') public bgColor: ResourceColor = _bgColor
  @Prop public leftItem?: ItemType | null = null // 左侧Widget，为空显示返回按钮
  public leftItemCallBack?: () => void
  @Prop public rightText: ResourceStr = '' // 右侧按钮文字
  @Prop public rightImgPath: imageType = '' // 右侧按钮图片路径，优先级高于text ,eg: $rawfile("images/ic_nav_add.png") | 'resources/rawfile/images/ic_nav_add.png'
  public rightItemCallBack?: () => void
  @Prop public rightItems: [] | [ItemType] | [ItemType, ItemType] = [] // 优先级高于rightText和rightImgPath
  @Prop public isGradient: boolean = false // 是否渐变背景色
  @Prop public navHeight: number = 56 // 传入child为100%，否则为navHeight
  @Prop public rate: number = _rate // 大于默认值会压缩标题的空间, 使得左右空间占比变多
  @BuilderParam child?: () => void // 子组件
  //
  @State private backImage: imageType = _backImageWhite
  @State private titleAndIconColor: ResourceColor = _titleColor

  aboutToAppear() {
    this.onChangeBgColor()
  }

  onChangeBgColor() {
    // 如果背景透明或者是白色，设置字体和图标、状态栏字体为黑色
    const isTransparent = this.bgColor == Color.Transparent || this.bgColor == Color.White || this.bgColor == KColors.kNavWhiteBgColor
    if (isTransparent) {
      this.titleAndIconColor = Color.Black
      this.backImage = _backImageBlack
    } else {
      // 导航条渐变显隐处理
      if (this.bgColor == 'rgba(237,237,237,0)') {
        this.titleAndIconColor = _titleColor
        this.backImage = _backImageWhite
      }
      if (this.bgColor == 'rgba(237,237,237,1)') {
        this.titleAndIconColor = Color.Black
        this.backImage = _backImageBlack
      }
    }
  }

  build() {
    Navigation() {
      if (this.child) {
        this.child()
      }
    }
    .titleMode(NavigationTitleMode.Mini)
    .title(this.NavigationTitle())
    .hideBackButton(true)
    .height(this.child ? '100%' : this.navHeight)
  }

  @Builder
  NavigationTitle() {
    Row() {
      this.navBuilder()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.bgColor)
    .linearGradient(this.isGradient ? {
      direction: GradientDirection.Right, // 从左向右
      colors: [[_appbarStartColor, 0.0], [_appbarEndColor, 1.0]]
    } : null)
  }

  @Builder
  navBuilder() {
    Row() {
      if (this.leftItem) {
        Row() {
          this.itemBuilder({ icon: this.leftItem.icon, text: this.leftItem.text })
        }.onClick(this.leftItem.itemCallBack)
      } else {
        this.backBuilder()
      }
    }
    .layoutWeight(this.rate)
    .width('100%')

    Row() {
      this.titleBuilder()
    }
    .layoutWeight(this.rightItems.length ? (100 - this.rate - this.rightItems.length * this.rate) : (100 - this.rate * 2))
    .width('100%')

    if (this.rightItems.length) {
      Row() {
        ForEach(this.rightItems, (item: ItemType) => {
          Row() {
            this.itemBuilder({ icon: item.icon, text: item.text })
          }.onClick(item.itemCallBack)
          .layoutWeight(1)
          .width('100%')
        })
      }
      .margin({ left: this.rightItems.length == 2 ? 15 : 0, right: this.rightItems.length == 2 ? 5 : 0 })
      .layoutWeight(this.rate * this.rightItems.length)
      .width('100%')
    } else {
      Row() {
        this.itemBuilder({ icon: this.rightImgPath, text: this.rightText })
      }
      .onClick(this.rightItemCallBack)
      .layoutWeight(this.rate)
      .width('100%')
    }
  }

  @Builder
  backBuilder() {
    Row() {
      Image(this.backImage)
        .width(18)
        .height(18)
        .margin({ left: 15 })
    }
    .size({ width: '100%', height: '100%' })
    .onClick(() => {
      if (this.leftItemCallBack) {
        this.leftItemCallBack()
      } else {
        this.goBack()
      }
    })
  }

  @Builder
  titleBuilder() {
    Row() {
      Text(this.title)
        .padding({
          left: 10,
          top: 5,
          right: 10,
          bottom: 5
        })
        .fontSize(this.titleFontSize)
        .fontColor(this.titleAndIconColor)
        .textAlign(this.titleTextAlign)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })// 文本超长显示省略号
        .wordBreak(WordBreak.BREAK_WORD)
    }
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .size({ width: '100%', height: '100%' })
  }

  @Builder
  itemBuilder(item: ItemType) {
    Row() {
      if (item.icon) {
        Image(item.icon)
          .width(_imgWH)
          .height(_imgWH)
          .margin({ left: _itemSpace, right: _itemSpace })
      } else if (item.text) {
        Text(item.text)
          .fontSize(_textFontSize)
          .fontColor(this.titleAndIconColor)
      }
    }
    .size({ width: '100%', height: '100%' })
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
  }

  goBack() {
    router.back()
  }
}