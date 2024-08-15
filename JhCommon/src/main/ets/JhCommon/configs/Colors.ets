///  Colors.ets
///
///  Created by iotjin on 2024/08/01.
///  description:  

export class KColors {
  // 主题色（导航条背景、提交按钮背景、弹框确认文字、表单图标录入光标）
  // 暗黑模式高亮显示颜色按kThemeColor设置，如tabBar选中文字图标、提交按钮背景色、指示器选中下划线、光标等
  static readonly kThemeColor: ResourceColor = '#3BB815'
  static readonly kThemeDarkColor: ResourceColor = '#0A0A0A' // (10, 10, 10)
  static readonly kThemeBlueColor: ResourceColor = '#4688FA'
  static readonly kThemePurpleColor: ResourceColor = '#9C27B0'
  // 渐变色（appBar和按钮）
  static readonly kGradientStartColor: ResourceColor = '#2683BE' // 渐变开始色
  static readonly kGradientEndColor: ResourceColor = '#34CABE' // 渐变结束色

  // 导航条背景色（主题色背景白色文字，透明背景为黑色文字，暗黑模式是白色文字）
  static readonly kNavThemeBgColor: ResourceColor = this.kThemeColor
  // 导航条背景色（白色背景色黑色文字，透明背景为黑色文字，暗黑模式是白色文字）
  static readonly kNavWhiteBgColor: ResourceColor = '#EDEDED' //(237, 237, 237)
  static readonly kNavBgDarkColor: ResourceColor = this.kThemeDarkColor // (10, 10, 10)
  static readonly kNavTitleColor: Color = Color.White
  // tabBar背景颜色
  static readonly kTabBarBgColor: ResourceColor = Color.White
  static readonly kTabBarBgDarkColor: ResourceColor = '#1D1D1D' // (29, 29, 29)

  // tabBar默认文字颜色
  static readonly kTabBarNormalTextColor: ResourceColor = '#333333' // (51, 51, 51)
  static readonly kTabBarNormalTextDarkColor: ResourceColor = '#C6C6C6' // (198, 198, 198)
  // tabBar选中文字颜色
  static readonly kTabBarSelectTextColor: ResourceColor = this.kThemeColor
  static readonly kTabBarSelectTextDarkColor: ResourceColor = this.kThemeColor
  // 背景色
  static readonly kBgColor: ResourceColor = '#F8F8F8' // (248, 248, 248)
  static readonly kBgDarkColor: ResourceColor = '#111111' // (17, 17, 17)

  // cell背景
  static readonly kCellBgColor: ResourceColor = Color.White
  static readonly kCellBgDarkColor: ResourceColor = '#191919' // (25, 25, 25)

  static readonly kMaterialBgColor: ResourceColor = '#FFFFFF' // (255, 255, 255)
  static readonly kMaterialBgDarkColor: ResourceColor = '#303233' // (48, 50, 51)

  // btn背景颜色
  // static readonly kBtnBgColor : ResourceColor = kThemeColor
  // static readonly kBtnBgDarkColor : ResourceColor = Color(0xFF2B2B2B) // (43, 43, 43)

  // 黑色文字
  static readonly kBlackTextColor: ResourceColor = '#333333' // (51, 51, 51)
  static readonly kBlackTextDarkColor: ResourceColor = '#C6C6C6' // (198, 198, 198)

  // 灰色文字
  static readonly kGreyTextColor: ResourceColor = '#777777' // (119, 119, 119)
  static readonly kGreyTextDarkColor: ResourceColor = '#787878' // (120, 120, 120)

  // 浅灰色文字
  static readonly kLightGreyTextColor: ResourceColor = '#999999' // (153, 153, 153)
  static readonly kLightGreyTextDarkColor: ResourceColor = '#666666' // (102, 102, 102)

  // 表单title文字
  static readonly kFormTitleColor: ResourceColor = this.kBlackTextColor
  static readonly kFormTitleDarkColor: ResourceColor = this.kBlackTextDarkColor
  // 表单info文字
  static readonly kFormInfoColor: ResourceColor = this.kBlackTextColor
  static readonly kFormInfoDarkColor: ResourceColor = this.kBlackTextDarkColor
  // 表单hint文字
  static readonly kFormHintColor: ResourceColor = '#BBBBBB' // (187, 187, 187)
  static readonly kFormHintDarkColor: ResourceColor = '#575757' // (87, 87, 87)

  // 分割线
  static readonly kLineColor: ResourceColor = '#E6E6E6' // (230, 230, 230)
  static readonly kLineDarkColor: ResourceColor = '#232323' // (35, 35, 35)

  // 表单分割线
  static readonly kFormLineColor: ResourceColor = this.kLineColor
  static readonly kFormLineDarkColor: ResourceColor = this.kLineDarkColor
  // 表单暗黑模式Focused状态下划线颜色
  static readonly kFocusedBorderDarkColor: ResourceColor = this.kLineColor
  // error颜色
  static readonly kErrorTextColor: ResourceColor = '#FF4759' // (255, 71, 89)
  static readonly kErrorTextDarkColor: ResourceColor = '#E03E4E' // (224, 62, 78)


  // 搜索框颜色
  static readonly kSearchBarBgColor: ResourceColor = this.kCellBgColor
  static readonly kSearchBarBgDarkColor: ResourceColor = this.kCellBgDarkColor
  // textView背景颜色
  static readonly kTextViewBgColor: ResourceColor = '#FAFAFA' // (250, 250, 250)
  static readonly kTextViewBgDarkColor: ResourceColor = '#323232' // (50, 50, 50)

  // toast背景颜色
  static readonly kToastBgColor: ResourceColor = '#202020' // (32, 32, 32)
  static readonly kToastBgDarkColor: ResourceColor = '#2F2F2F' // (47, 47, 47)

  // alert背景颜色
  static readonly kAlertBgColor: ResourceColor = Color.White
  static readonly kAlertBgDarkColor: ResourceColor = '#2C2C2C' // (44, 44, 44)
  static readonly kAlertInputBgColor: ResourceColor = Color.White
  static readonly kAlertInputBgDarkColor: ResourceColor = '#1E1E1E' // (30, 30, 30)

  // picker、bottomSheet颜色
  static readonly kPickerBgColor: ResourceColor = Color.White
  static readonly kPickerBgDarkColor: ResourceColor = '#1E1E1E' // (30, 30, 30)
  static readonly kPickerTitleColor: ResourceColor = '#787878' // (120, 120, 120)
  static readonly kPickerTitleDarkColor: ResourceColor = '#878787' // (135, 135, 135)
  static readonly kPickerTextColor: ResourceColor = this.kBlackTextColor
  static readonly kPickerTextDarkColor: ResourceColor = this.kBlackTextDarkColor
  static readonly kPickerRedTextDarkColor: ResourceColor = '#E64242' // (230, 66, 66)
  static readonly kPickerHeaderColor: ResourceColor = this.kPickerBgColor
  static readonly kPickerHeaderDarkColor: ResourceColor = this.kPickerBgDarkColor
  static readonly kPickerHeaderLineColor: ResourceColor = this.kLineColor
  static readonly kPickerHeaderLineDarkColor: ResourceColor = this.kLineDarkColor
  static readonly kPickerBtnColor: ResourceColor = this.kBlackTextColor
  static readonly kPickerBtnDarkColor: ResourceColor = this.kBlackTextDarkColor
  // card颜色
  static readonly kCardBgColor: ResourceColor = Color.White
  static readonly kCardBgDarkColor: ResourceColor = '#2C2C2C' // (44, 44, 44)

  // icon颜色
  static readonly kIconColor: ResourceColor = '#646464' // (100, 100, 100)
  static readonly kIconDarkColor: ResourceColor = '#C8C8C8' // (200, 200, 200)

  static readonly kTagWarningColor: ResourceColor = '#FFBA00'
  static readonly kTagErrorColor: ResourceColor = '#FF4949'
  static readonly kTagSuccessColor: ResourceColor = '#13CE66'
  // 微信主题色 rgb(59,184,21)
  static readonly wxThemeColor: ResourceColor = '#3BB815'
  static readonly wxThemeDarkColor: ResourceColor = '#00BE66'
  // rgb(50, 179, 116)
  static readonly wxPayColor: ResourceColor = '#32B374'
  // rgb(0, 174, 91)
  static readonly wxTextColor: ResourceColor = '#00AE5B'
  // rgb(255, 139, 34)
  static readonly wxTextOrangeColor: ResourceColor = '#FF8B22'
  static readonly wxTitleColor: ResourceColor = Color.White
  // 微信背景色 rgb(237,237,237)
  static readonly wxBgColor: ResourceColor = '#EDEDED'
  // 深蓝色
  static readonly wxTextBlueColor: ResourceColor = '#586D98'
  static readonly transparent: ResourceColor = Color.Transparent
}