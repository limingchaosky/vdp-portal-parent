package cn.goldencis.vdp.common.utils;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

/**
 *
 * String工具类. <br>
 *

 */
public class StringUtil {

    /**
     * 功能：检查这个字符串是不是空字符串。<br/>
     * 如果这个字符串为null或者trim后为空字符串则返回true，否则返回false。
     *
     * @param chkStr
     *            被检查的字符串
     * @return boolean
     */
    public static boolean isEmpty(String chkStr) {
        if (chkStr == null) {
            return true;
        } else {
            return "".equals(chkStr.trim()) ? true : false;
        }
    }

    /**
     * 如果字符串没有超过最长显示长度返回原字符串，否则从开头截取指定长度并加...返回。
     *
     * @param str
     *            原字符串
     * @param length
     *            字符串最长显示的长度
     * @return 转换后的字符串
     */
    public static String trimString(String str, int length) {
        if (str == null) {
            return "";
        } else if (str.length() > length) {
            return str.substring(0, length - 3) + "...";
        } else {
            return str;
        }
    }

    /**
     * 根据绝对路径返回最后文件名称
     * @author mll
     * @param path
     * @return String
     */
    public static String subLastPath(String path) {
        int index = path.lastIndexOf("\\");
        char[] ch = path.toCharArray();
        String lastString = String.copyValueOf(ch, index + 1, ch.length - index - 1);
        return lastString;
    }

    /**
     * 将数组转化成字符
     * @param list
     * @param separator
     * @return
     */
    public static String listToString(List<String> list, char separator) {
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < list.size(); i++) {
            sb.append(list.get(i));
            if (i < list.size() - 1) {
                sb.append(separator);
            }
        }
        return sb.toString();
    }

    /**
     * 字符串数组转list
     * @param arrayStr
     * @return
     */
    public static List<String> arrayToList(String[] arrayStr){
        if (arrayStr != null) {
            List<String> rlist = new ArrayList<>();
            for (String str : arrayStr) {
                rlist.add(str.trim());
            }
            return rlist;
        }
        return null;
    }

    public static String stringToHex(String str) {
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < str.length(); i++) {
            char c = str.charAt(i);
            int n_1, n_2, n_3, n_4;
            char cT;
            int nC;
            if (c > '9') {
                cT = 'a';
                nC = (c - cT) + 10;
            } else {
                cT = '0';
                nC = (c - cT);
            }
            n_1 = nC / 8;
            n_2 = (nC % 8) / 4;
            n_3 = (nC % 4) / 2;
            n_4 = nC % 2;

            sb.append("" + n_1 + n_2 + n_3 + n_4);
        }
        return sb.toString();
    }

    public static String generateScrnwatermarkId(String authId, Integer markRecordId) {
        StringBuffer sb = new StringBuffer();
        sb.append("s");
        String last4Str = authId.substring(authId.length() - 4);
        sb.append(StringUtil.stringToHex(last4Str));
        sb.append(intToStr32(markRecordId));
        return sb.toString();
    }

    /**
     *
     * 将int转换为32位的二进制，保存在字符串中返回。
     * @param num
     * @return
     */
    public static String intToStr32(int num) {
        StringBuffer sb = new StringBuffer();
        for (int i = 31; i >= 0; i--) {
            // &1 也可以改为num&0x01,表示取最地位数字.
            sb.insert(0, (byte) (num & 1));
            // 右移一位.
            num >>= 1;
        }
        return sb.toString();
    }
}