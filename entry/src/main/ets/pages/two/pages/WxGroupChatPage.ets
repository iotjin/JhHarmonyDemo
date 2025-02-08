///  WxGroupChatPage.ets
///
///  Created by iotjin on 2025/01/16.
///  description:  群聊


import { BaseNavigation, JhProgressHUD, JhSetCell, KColors } from 'JhCommon'
import { WxAddFriendModel } from '../models/WxAddFriendModel';


@Entry
@Preview
@Component
struct WxGroupChatPage {
  @State dataArr: WxAddFriendModel[] = []

  aboutToAppear() {
    this.dataArr = this.getData()
    // console.error('data', JSON.stringify(this.dataArr))
  }

  build() {
    Column() {
      BaseNavigation({ title: '群聊', bgColor: Color.Transparent })
      this.body()
    }
    .backgroundColor(KColors.wxBgColor)
  }

  @Builder
  body() {
    List() {
      this.header()
      if (this.dataArr.length == 0) {
        ListItem() {
          Text('暂无数据')
            .width('100%')
            .padding({ top: 50 })
            .textAlign(TextAlign.Center)
            .fontSize(18)
        }
      } else {
        ForEach(this.dataArr, (item: WxAddFriendModel, index: number) => {
          ListItem() {
            JhSetCell({
              leftImgWH: 40,
              cellHeight: 55,
              lineLeftEdge: 65,
              title: item.title,
              hiddenArrow: true,
              leftWidget: () => {
                this.leftBuilder(item.img!)
              },
              clickCallBack: (): void => this.clickCell(item.title!),
            })
          }
        })
      }
    }
    .layoutWeight(1)
    .edgeEffect(EdgeEffect.Spring, {
      alwaysEnabled: true
    })

    // .divider({
    //   strokeWidth: 0.5,
    //   startMargin: 65,
    //   endMargin: 0,
    //   color: KColors.kLineColor
    // })
  }

  @Builder
  header() {
    Search({ value: '', placeholder: '搜索' })
      .borderRadius(5)
      .margin(10)
      .backgroundColor(Color.White)
      .onSubmit((value: string) => {
        console.log('搜索框 onSubmit 文字：', JSON.stringify(value))
      })
      .onChange((value: string) => {
        console.log('搜索框 onChange 文字：', JSON.stringify(value))
      })
  }

  @Builder
  leftBuilder(img: string) {
    Image($rawfile(img))
      .width(40)
      .height(40)
      .borderRadius(3)
  }

  clickCell(text: string) {
    JhProgressHUD.showText(`点击 ${text}`)
  }

  getData() {
    let dataArr: WxAddFriendModel[] = [
      {
        'title': '群聊一',
        'subtitle': '群聊一',
        'img': 'images/picture/touxiang_1.jpeg',
      },
      {
        'title': '群聊2',
        'subtitle': 'hello',
        'img': 'images/picture/touxiang_2.jpeg',
      },
      {
        'title': '群聊3',
        'subtitle': '[图片]',
        'img': 'images/picture/touxiang_3.jpeg',
      },
      {
        'title': '群聊4',
        'subtitle': '[动画表情]',
        'img': 'images/picture/touxiang_4.jpeg',
      },
      {
        'title': '群聊666',
        'subtitle': '',
        'img': 'images/picture/touxiang_5.jpeg',
      },
      {
        'title': 'HHHHHH',
        'subtitle': 'hi',
        'img': 'images/picture/touxiang_6.jpg',
      },
    ];
    return dataArr;
  }
}