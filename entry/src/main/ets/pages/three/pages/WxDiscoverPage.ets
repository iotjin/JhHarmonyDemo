///  WxDiscoverPage.ets
///
///  Created by iotjin on 2024/11/05. 
///  description: 发现


import { BaseNavigation, JhProgressHUD, JhSetCell, KColors } from 'JhCommon'
import { router } from '@kit.ArkUI';

const _cellH = 55.0;
const _leftSpace = 50.0;
const _rowSpace = 6.0;

@Entry
@Preview
@Component
export struct WxDiscoverPage {
  build() {
    Column() {
      BaseNavigation({ title: '发现', bgColor: Color.Transparent, leftItem: {} })
      Scroll() {
        Column() {
          this.body()
        }
      }
    }
    .backgroundColor(KColors.wxBgColor)
  }

  @Builder
  body() {
    JhSetCell({
      cellHeight: _cellH,
      leftIcon: $rawfile("wechat/discover/ic_social_circle.png"),
      title: '朋友圈',
      hiddenLine: true,
      rightWidget: (): void => this.rightBuilder(),
      clickCallBack: () => {
        this.clickCell('朋友圈')
      },
    })
    Blank().height(_rowSpace)
    JhSetCell({
      cellHeight: _cellH,
      leftIcon: $rawfile("wechat/discover/ic_video_number.png"),
      title: '视频号',
      hiddenLine: true,
      clickCallBack: (): void => this.clickCell('视频号'),
    })
    Blank().height(_rowSpace)
    JhSetCell({
      cellHeight: _cellH,
      lineLeftEdge: _leftSpace,
      leftIcon: $rawfile("wechat/discover/ic_quick_scan.png"),
      title: '扫一扫',
      clickCallBack: (): void => this.clickCell('扫一扫'),
    })
    JhSetCell({
      cellHeight: _cellH,
      lineLeftEdge: _leftSpace,
      leftIcon: $rawfile("wechat/discover/ic_shake_phone.png"),
      title: '摇一摇',
      hiddenLine: true,
      clickCallBack: (): void => this.clickCell('摇一摇'),
    })
    Blank().height(_rowSpace)
    JhSetCell({
      cellHeight: _cellH,
      lineLeftEdge: _leftSpace,
      leftIcon: $rawfile("wechat/discover/ic_feeds.png"),
      title: '看一看',
      clickCallBack: (): void => this.clickCell('看一看'),
    })
    JhSetCell({
      cellHeight: _cellH,
      leftIcon: $rawfile("wechat/discover/ic_quick_search.png"),
      title: '搜一搜',
      hiddenLine: true,
      clickCallBack: (): void => this.clickCell('搜一搜'),
    })
    Blank().height(_rowSpace)
    JhSetCell({
      cellHeight: _cellH,
      leftIcon: $rawfile("wechat/discover/ic_people_nearby.png"),
      title: '附近的人',
      hiddenLine: true,
      clickCallBack: (): void => this.clickCell('附近的人'),
    })
    Blank().height(_rowSpace)
    JhSetCell({
      cellHeight: _cellH,
      lineLeftEdge: _leftSpace,
      leftIcon: $rawfile("wechat/discover/ic_shopping.png"),
      title: '购物',
      clickCallBack: (): void => this.clickCell('购物'),
    })
    JhSetCell({
      cellHeight: _cellH,
      leftIcon: $rawfile("wechat/discover/ic_game_entry.png"),
      title: '游戏',
      hiddenLine: true,
      clickCallBack: (): void => this.clickCell('游戏'),
    })
    Blank().height(_rowSpace)
    JhSetCell({
      cellHeight: _cellH,
      leftIcon: $rawfile("wechat/discover/ic_mini_program.png"),
      title: '小程序',
      hiddenLine: true,
      clickCallBack: (): void => this.clickCell('小程序'),
    })
    Blank().height(15)
  }

  @Builder
  rightBuilder() {
    // Image('https://gitee.com/iotjh/Picture/raw/master/lufei.png').height(30).width(30)
    Row() {
      Badge({ value: '', position: BadgePosition.RightTop, style: { badgeSize: 6, badgeColor: '#FA2A2D' } }) {
        Image($rawfile('images/lufei.png'))
          .width(30).height(30)
          .margin({ top: 2.5, left: 2.5 })
      }
      .width(35).height(35)

      // .backgroundColor(Color.Green)
    }
  }

  // 点击cell
  clickCell(title: string) {
    console.log('点击cell', title)
    if (title === '朋友圈') {
      router.pushUrl({ url: 'pages/three/pages/WxFriendsCirclePage' })
    } else {
      JhProgressHUD.showText(`点击 ${title}`)
    }
  }
}