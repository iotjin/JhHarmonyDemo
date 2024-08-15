import { BaseNavigation, JhAESPreferencesUtils, JhEncryptUtils } from 'JhCommon';

@Entry
@Component
struct AESTestPage {
  aboutToAppear() {
    this.test('123')
    this.storageTest()
  }

  build() {
    Column() {
      BaseNavigation({ title: "AES/MD5和本地加密存储" })
    }
  }

  test(str: string) {
    console.log('-------------------数据加解密-------------------')
    const text = str
    console.log(`明文：${text}`)

    const base64encodeStr = JhEncryptUtils.encodeBase64(text)
    console.log(`base64编码: ${base64encodeStr}`)
    const base64decodeStr = JhEncryptUtils.decodeBase64(base64encodeStr)
    console.log(`base64解码: ${base64decodeStr}`)

    const enStr = JhEncryptUtils.aesEncrypt(text)
    console.log(`AES 加密：${enStr}`)
    const deStr = JhEncryptUtils.aesDecrypt(enStr)
    console.log(`AES 解密：${deStr}`)

    const md5 = JhEncryptUtils.encodeMd5(text)
    console.log(`md5 ：${md5}`)
  }

  storageTest() {
    console.log('-------------------本地加密存储-------------------')
    JhAESPreferencesUtils.saveString('testStr', '这是测试本地加密存储的字符串')
    const testStr = JhAESPreferencesUtils.getString('testStr')
    console.log(`testStr : ${testStr}`)

    JhAESPreferencesUtils.saveBool('testBool', true)
    const testBool = JhAESPreferencesUtils.getBool('testBool')
    console.log(`testBool : ${testBool}`)

    JhAESPreferencesUtils.saveNumber('testInt', 1111)
    const testInt = JhAESPreferencesUtils.getNumber('testInt')
    console.log(`testInt : ${testInt}`)

    JhAESPreferencesUtils.saveNumber('testDouble', 222.333354)
    const testDouble = JhAESPreferencesUtils.getNumber('testDouble')
    console.log(`testDouble : ${testDouble}`)

    const dic = { 'a': 'aaa', 'b': 'bbb', 'c': 'ccc' } as Record<string, string>
    console.log('原始dic', JSON.stringify(dic))
    JhAESPreferencesUtils.saveModel('testDic', dic)
    const testDic = JhAESPreferencesUtils.getModel('testDic')
    console.log('testDic', JSON.stringify(testDic))

    // 取不存在的key
    console.log('-------------------取不存在的key----------------------')

    const testStr2 = JhAESPreferencesUtils.getString('testStr222')
    console.log(`testStr2原始 : ${testStr2}`)
    const test = testStr2 == '' ? '1' : '2222'
    console.log(test)
    console.log(`testStr2 : ${testStr2}`)

    const testBool2 = JhAESPreferencesUtils.getBool('testBool222')
    console.log(`testBool2 : ${testBool2}`)

    const testInt2 = JhAESPreferencesUtils.getNumber('testInt222')
    console.log(`testInt2: ${testInt2}`)

    const testDouble2 = JhAESPreferencesUtils.getNumber('testDouble222')
    console.log(`testDouble2 : ${testDouble2}`)

    const testDic2 = JhAESPreferencesUtils.getModel('testDic222')
    console.log(`testDic2 : ${testDic2}`)
  }
}