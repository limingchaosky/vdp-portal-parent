/**
 *
 */
package cn.goldencis.vdp.core.utils;

import org.springframework.beans.factory.annotation.Value;

import java.util.ResourceBundle;

/**
 * 读取配置文件
 * @author Administrator
 *
 */
public class PathConfig {
    private static ResourceBundle bundle;
    public final static String HOM_PATH;
    public final static String JEDIS_HOST;
    public final static Integer JEDIS_PORT;
    public final static String JEDIS_OPEN;
    public final static String DEVICE_UNIQUE_CMD; //设备唯一码查询命令
    public final static String TSA_AUTH_FILE_NAME; //TSA授权文件名
    public final static String TSA_URL; //TSA统一登录页面
    public final static String TSA_LOGIN_URL;//TSA单一登录页面
    public final static String READ_AUTH_PATH;//解密授权信息文件
    public final static String POLICY_BASECATALOG;//策略json文件的存放根目录
    public final static String POLICY_JSONFILENAME;//策略json文件的保存的文件名

    public final static String PACKAGEUPLOADPATH;

    public final static String PACKAGEUPLOADFILENAME;

    public final static String UPDATEUPLOADPATH;

    public final static String UPDATEUPLOADFILENAME;

    public final static String GOLBALCFG_PATH;//全局配置文件路径golbalcfg.path


    static {
        bundle = ResourceBundle.getBundle("vdp-common");

        HOM_PATH = bundle.getString("homepath");
        JEDIS_HOST = bundle.getString("jedis.host");
        JEDIS_PORT = Integer.parseInt(bundle.getString("jedis.port"));
        JEDIS_OPEN = bundle.getString("jedis.open");
        DEVICE_UNIQUE_CMD = bundle.getString("device.unique.cmd");
        TSA_AUTH_FILE_NAME = bundle.getString("tsa_auth_file_name");
        TSA_URL = bundle.getString("tsa_url");
        TSA_LOGIN_URL = bundle.getString("tsa_login_url");
        READ_AUTH_PATH = bundle.getString("readauthpath");
        POLICY_BASECATALOG = bundle.getString("policy.BaseCatalog");
        POLICY_JSONFILENAME = bundle.getString("policy.JsonFileName");

        PACKAGEUPLOADPATH = bundle.getString("packageupload.path");
        PACKAGEUPLOADFILENAME = bundle.getString("packageupload.fileName");
        UPDATEUPLOADPATH = bundle.getString("updateupload.path");
        UPDATEUPLOADFILENAME = bundle.getString("updateupload.fileName");
        GOLBALCFG_PATH = bundle.getString("golbalcfg.path");
    }

}
