///  WxMinePage.ets
///
///  Created by iotjin on 2024/11/06.
///  description:  微信我的

import { BaseNavigation, JhAESPreferencesUtils, JhSetCell, KColors, kUserDefault_UserInfo } from 'JhCommon'
import { UserModel } from '../../model/UserModel';
import { router } from '@kit.ArkUI';

const _cellH = 55.0;
const _leftSpace = 50.0;
const _rowSpace = 6.0;

@Entry
@Preview
@Component
export struct WxMinePage {
  userInfo?: UserModel;

  aboutToAppear() {
    let useInfo = JhAESPreferencesUtils.getModel(kUserDefault_UserInfo)
    console.log('useInfo: ', JSON.stringify(useInfo))
    this.userInfo = useInfo as UserModel
    console.log('this.userInfo', JSON.stringify(this.userInfo))
  }

  build() {
    Stack({ alignContent: Alignment.TopEnd }) {
      this.body()
      BaseNavigation({
        title: '',
        bgColor: Color.Transparent,
        leftItem: {},
        rightImgPath: $rawfile("images/ic_set_black.png"),
        rightItemCallBack: () => {
          this.clickCell('设置')
        },
      })
        .hitTestBehavior(HitTestMode.Transparent)
    }
    .backgroundColor(KColors.wxBgColor)
  }

  @Builder
  body() {
    List() {
      this.header()
      ListItem() {
        Column() {
          Blank().height(_rowSpace)
          JhSetCell({
            cellHeight: _cellH,
            leftIcon: $rawfile("wechat/mine/ic_wallet.png"),
            title: '服务',
            hiddenLine: true,
            clickCallBack: (): void => this.clickCell('服务'),
          })
          Blank().height(_rowSpace)
          JhSetCell({
            cellHeight: _cellH,
            lineLeftEdge: _leftSpace,
            leftIcon: $rawfile("wechat/mine/ic_collections.png"),
            title: '收藏',
          })
          JhSetCell({
            cellHeight: _cellH,
            lineLeftEdge: _leftSpace,
            leftIcon: $rawfile("wechat/mine/ic_album.png"),
            title: '相册',
          })
          JhSetCell({
            cellHeight: _cellH,
            lineLeftEdge: _leftSpace,
            leftIcon: $rawfile("wechat/mine/ic_cards_wallet.png"),
            title: '卡包',
          })
          JhSetCell({
            cellHeight: _cellH,
            lineLeftEdge: _leftSpace,
            leftIcon: $rawfile("wechat/mine/ic_emotions.png"),
            title: '表情',
            hiddenLine: true,
          })
          Blank().height(_rowSpace)
          JhSetCell({
            cellHeight: _cellH,
            leftIcon: $rawfile("wechat/mine/ic_settings.png"),
            title: '设置',
            hiddenLine: true,
            clickCallBack: (): void => this.clickCell('设置'),
          })
          Blank().height(_rowSpace)
          JhSetCell({
            cellHeight: _cellH,
            leftIcon: $rawfile("images/ic_about.png"),
            title: '检查更新',
            text: '有新版本',
            textStyle: { fontSize: 14, fontColor: Color.Red },
            hiddenLine: true,
            clickCallBack: (): void => this.clickCell('showUpdateDialog'),
          })
          Blank().height(50)
        }
      }
    }.backgroundColor(Color.Transparent)
  }

  @Builder
  header() {
    Row() {
      // Image('https://gitee.com/iotjh/Picture/raw/master/lufei.png').width(75).height(75).borderRadius(10)
      Image(this.userInfo?.avatarUrl).width(75).height(75).borderRadius(10)
        .onClick(() => {
          console.log('点击头像==  ${this.userInfo?.avatarUrl}')
          this.clickCell('个人信息')
        })
      Column() {
        Text(this.userInfo?.userName)
          .fontSize(28)
          .fontWeight(FontWeight.Medium)
          .textAlign(TextAlign.Start)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .width('100%')// .backgroundColor(Color.Pink)
          .onClick(() => {
            console.log('点击昵称==  $\{model.userName}')
            this.clickCell('个人信息')
          })
        Row() {
          Text('微信号：abc').fontSize(17).fontColor(Color.Gray)
          Blank()
          // .backgroundColor(Color.Orange)
          Image($rawfile('wechat/mine/ic_setting_myQR.png')).width(18).height(18).margin({ right: 20 })
          Image($rawfile('JhForm/ic_arrow_right.svg')).width(25).height(25)
        }
        .margin({ top: 10 })
        .width('100%')
        // .backgroundColor(Color.Yellow)
        .onClick(() => {
          this.clickCell('个人信息')
        })

      }
      .layoutWeight(1)
      .padding({ left: 16 })

      // .backgroundColor(Color.Red)
    }
    .backgroundColor(Color.White)
    .padding({
      left: 15,
      right: 15,
      top: 40,
      bottom: 30
    })
  }

  // 点击cell
  clickCell(title: string) {
    console.log('点击cell', title)
    if (title === '服务') {
      router.pushUrl({ url: 'pages/four/pages/WxPayPage' })
    }
    if (title === '个人信息') {
      router.pushUrl({ url: 'pages/four/pages/WxPersonInfoPage' })
    }
    if (title === '设置') {
      router.pushUrl({ url: 'pages/four/pages/SetPage' })
    }
  }
}