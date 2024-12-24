///  JhEncryptUtils.ets
///
///  Created by iotjin on 2024/08/09. 
///  description: Base64、MD5、AES加解密(CBC/PKCS7)

import { CryptoJS } from '@ohos/crypto-js'

// 16或32位密钥
const SECRET_KEY: CryptoJS.lib.WordArray = CryptoJS.enc.Utf8.parse('1231231231231231')
// 16位密钥偏移量
const SECRET_IV: CryptoJS.lib.WordArray = CryptoJS.enc.Utf8.parse('4564564564564564')

export class JhEncryptUtils {
  /// Base64编码
  public static encodeBase64(data: string) {
    const encoded: string = CryptoJS.enc.Base64.stringify(CryptoJS.enc.Utf8.parse(data))
    return encoded
  }

  /// Base64解码
  public static decodeBase64(data: string) {
    const decoded: string = CryptoJS.enc.Base64.parse(data).toString(CryptoJS.enc.Utf8)
    return decoded
  }

  /// md5 加密 32位小写
  public static encodeMd5(plainText: string) {
    let hash: CryptoJS.lib.WordArray = CryptoJS.MD5(plainText)
    return hash.toString()
  }

  /// 字符串AES加密
  public static aesEncrypt(dataStr: string) {
    const dataHex: CryptoJS.lib.WordArray = CryptoJS.enc.Utf8.parse(dataStr)
    const encrypted: CryptoJS.lib.CipherParams = CryptoJS.AES.encrypt(dataHex, SECRET_KEY, {
      iv: SECRET_IV,
      mode: CryptoJS.mode.CBC,
      padding: CryptoJS.pad.Pkcs7
    })
    return encrypted.toString()
  }

  /// 字符串AES解密
  public static aesDecrypt(dataStr: string) {
    const encryptedStr: CryptoJS.lib.WordArray = CryptoJS.enc.Base64.parse(dataStr)
    const str: string = CryptoJS.enc.Base64.stringify(encryptedStr)
    const decrypt: CryptoJS.lib.WordArray = CryptoJS.AES.decrypt(str, SECRET_KEY, {
      iv: SECRET_IV,
      mode: CryptoJS.mode.CBC,
      padding: CryptoJS.pad.Pkcs7
    })
    const decryptedStr: string = CryptoJS.enc.Utf8.stringify(decrypt)
    return decryptedStr.toString()
  }
}