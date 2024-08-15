import { router } from '@kit.ArkUI';
import { BaseNavigation, JhProgressHUD } from 'JhCommon';

@Entry
@Component
struct TestBaseNavigation {
  // 获取传递过来的参数对象
  jumpParams0 = router.getParams()
  jumpParams = router.getParams() as Record<string, string>
  text = this.jumpParams['label']

  aboutToAppear() {
    console.info('aboutToAppear')
    console.log(JSON.stringify(this.jumpParams))
    console.log('text:   ' + this.text)
  }

  aboutToDisappear() {
    console.info('aboutToDisappear')
  }

  onPageShow() {
    console.info('onPageShow')
  }

  onPageHide() {
    console.info('onPageHide')
  }

  onBackPress() {
    console.info('onBackPress')
  }

  build() {
    Scroll() {
      Column() {
        if (this.text == 'nav-只有title') {
          BaseNavigation({ title: '标题' })
        } else if (this.text == 'nav-左侧返回，右侧文字') {
          BaseNavigation({
            title: '标题标题标题标题标题标题标题标题标题标题',
            rightText: '设置',
            rightItemCallBack: () => {
              console.log("点击了设置")
              JhProgressHUD.showText("点击了设置")
            }
          })
        } else if (this.text == 'nav-左侧返回(拦截点击事件)，右侧图片') {
          BaseNavigation({
            title: '标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题',
            titleTextAlign: TextAlign.Start,
            // rightImgPath: 'resources/rawfile/images/ic_more_white.png',
            rightImgPath: $rawfile("images/ic_nav_add.png"),
            rightItemCallBack: () => {
              JhProgressHUD.showText("点击了右侧图标")
            },
            leftItemCallBack: () => {
              JhProgressHUD.showText("点击左侧")
            }
          })
        } else if (this.text == 'nav-左侧自定义右侧文字') {
          BaseNavigation({
            title: '标题',
            titleTextAlign: TextAlign.Start,
            leftItem: {
              text: '设置1',
              icon: $rawfile("images/ic_nav_add.png"),
              itemCallBack: () => {
                JhProgressHUD.showText("点击了左侧")
              }
            },
            rightText: '发布',
            rightItemCallBack: () => {
              console.log("点击了设置")
              JhProgressHUD.showText("点击了发布")
            }
          })
        } else if (this.text == 'nav-设置背景色') {
          BaseNavigation({
            bgColor: Color.Orange,
            title: '标题',
            // rightImgPath: 'resources/rawfile/images/ic_more_white.png',
            rightImgPath: $rawfile("images/ic_nav_add.png"),
            rightItemCallBack: () => {
              JhProgressHUD.showText("点击了右侧图标")
            }
          })
        } else if (this.text == 'nav-设置透明背景色') {
          BaseNavigation({
            bgColor: Color.Transparent,
            title: '标题',
            // rightImgPath: $rawfile("common/ic_arrow_black.png"),
            // rightItemCallBack: () => {
            //   JhProgressHUD.showText("点击了右侧图标")
            // }
            rightText: '设置',
            rightItemCallBack: () => {
              JhProgressHUD.showText("点击了设置")
            }
          })
        } else if (this.text == 'nav-渐变导航条') {
          BaseNavigation({
            isGradient: true,
            title: '标题',
            // rightImgPath: 'resources/rawfile/images/ic_more_white.png',
            rightImgPath: $rawfile("images/ic_nav_add.png"),
            rightItemCallBack: () => {
              JhProgressHUD.showText("点击了右侧图标")
            }
          })
        } else if (this.text == 'nav-右侧自定义1') {
          BaseNavigation({
            title: '标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题',
            titleTextAlign: TextAlign.Start,
            rightItems: [
              {
                text: '设置1',
                itemCallBack: () => {
                  JhProgressHUD.showText("点击了设置1")
                }
              },
              {
                text: '设置2',
                itemCallBack: () => {
                  JhProgressHUD.showText("点击了设置2")
                }
              }
            ]
          })
        } else if (this.text == 'nav-右侧自定义2') {
          BaseNavigation({
            title: '标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题',
            titleTextAlign: TextAlign.Start,
            rightItems: [
              {
                icon: 'resources/rawfile/images/ic_more_white.png',
                text: '设置1',
                itemCallBack: () => {
                  JhProgressHUD.showText("点击了更多图标")
                }
              },
              {
                icon: $rawfile("images/ic_nav_add.png"),
                text: '设置2',
                itemCallBack: () => {
                  JhProgressHUD.showText("点击了添加图标")
                }
              }
            ]
          })
        }
        if (this.text != 'nav-child') {
          Button('返回', { type: ButtonType.Normal })
            .margin(15)
            .width(90)
            .borderRadius(8)
            .onClick(() => {
              router.back()
            })
        }

        if (this.text == 'nav-child') {
          BaseNavigation({
            title: '自定义child',
            child: () => {
              this.childBuilder()
            }
          })
          // {
          //   Text('33333333')
          //   Text('4444444')
          // }
        }
      }
    }
  }

  @Builder
  childBuilder() {
    Scroll() {
      Column() {
        Text('111111111')
          .width('100%')
          .height(600)
          .backgroundColor(Color.Orange)
        Text('222222222')
          .width('100%')
          .height(500)
          .backgroundColor(Color.Yellow)
      }
    }
  }
}
