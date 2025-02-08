///  WxAddFriendPage.ets
///
///  Created by iotjin on 2025/01/14.
///  description:  添加朋友

import { BaseNavigation, JhProgressHUD, KColors } from 'JhCommon'
import { WxAddFriendModel } from '../models/WxAddFriendModel'
import { WxAddFriendCell } from '../widgets/WxAddFriendCell'


@Entry
@Preview
@Component
struct WxAddFriendPage {
  @State dataArr: WxAddFriendModel[] = []

  aboutToAppear() {
    this.dataArr = this.getData()
    // console.error('data', JSON.stringify(this.dataArr))
  }

  build() {
    Column() {
      BaseNavigation({ title: '添加朋友', bgColor: Color.Transparent })
      Scroll() {
        Column() {
          this.header()
          this.body()
        }
      }
      .layoutWeight(1)
      .edgeEffect(EdgeEffect.Spring, {
        alwaysEnabled: true
      })
    }
    .backgroundColor(KColors.wxBgColor)
  }

  @Builder
  body() {
    List() {
      ForEach(this.dataArr, (item: WxAddFriendModel, index: number) => {
        ListItem() {
          WxAddFriendCell({
            model: item,
            onClickCell: () => {
              this.clickCell(item)
            },
          })
        }
      })
    }
    .layoutWeight(1)
    .divider({
      strokeWidth: 0.5,
      startMargin: 0,
      endMargin: 0,
      color: KColors.kLineColor
    })
  }

  @Builder
  header() {
    Column() {
      Search({ value: '', placeholder: '微信号/手机号' })
        .borderRadius(5)
        .margin(10)
        .backgroundColor(Color.White)
        .onSubmit((value: string) => {
          console.log('搜索框 onSubmit 文字：', JSON.stringify(value))
        })
        .onChange((value: string) => {
          console.log('搜索框 onChange 文字：', JSON.stringify(value))
        })
      Row() {
        Text('我的微信号：abc')
        Blank().width(10)
        Image($rawfile('wechat/contacts/add/add_friend_myQR_20x20_@2x.png')).width(20)
      }
      .height(60)
    }
  }

  clickCell(item: WxAddFriendModel) {
    console.log('点击cell', JSON.stringify(item))
    JhProgressHUD.showText(`点击 ${item.title}`)
  }

  getData() {
    let dataArr: WxAddFriendModel[] = [
      {
        'title': '雷达加朋友',
        'subtitle': '添加身边的朋友',
        'img': 'wechat/contacts/add/add_friend_icon_reda_36x36_@3x.png',
      },
      {
        'title': '面对面建群',
        'subtitle': '与身边的朋友进入同一个群聊',
        'img': 'wechat/contacts/add/add_friend_icon_addgroup_36x36_@3x.png',
      },
      {
        'title': '扫一扫',
        'subtitle': '扫描二维码名片',
        'img': 'wechat/contacts/add/add_friend_icon_scanqr_36x36_@3x.png',
      },
      {
        'title': '手机联系人',
        'subtitle': '添加手机通讯录中的朋友',
        'img': 'wechat/contacts/add/add_friend_icon_contacts_36x36_@3x.png',
      },
      {
        'title': '公众号',
        'subtitle': '获取更多资讯和服务',
        'img': 'wechat/contacts/add/add_friend_icon_offical_36x36_@3x.png',
      },
      {
        'title': '企业微信联系人',
        'subtitle': '通过手机号搜索企业微信用户',
        'img': 'wechat/contacts/add/add_friend_icon_search_wework_40x40_@2x.png',
      },
    ];
    return dataArr;
  }
}