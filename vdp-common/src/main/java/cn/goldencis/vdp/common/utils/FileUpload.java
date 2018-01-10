package cn.goldencis.vdp.common.utils;

import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletContext;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

/**
 * 文件上传公共类
 * Created by limingchao on 2018/1/10.
 */
public class FileUpload {

    /**
     * 上传文件
     */
    public void uploadFile(MultipartFile packageFile, String path, String fileName) {

        InputStream inStream = null;
        FileOutputStream fos = null;

        try {
            ServletContext servletContext = SysContext.getRequest().getSession().getServletContext();
            String realPath = servletContext.getRealPath(path);

            File dir = new File(realPath);
            if (!dir.exists()) {
                dir.mkdirs();
            }
            realPath = realPath  + "/" + fileName;
            File prePackageFile = new File(realPath);
            if (prePackageFile.exists()) {
                prePackageFile.delete();
            }

            // 用数据流的方式二次读取和保存数据保证上传的缓存效果和安全性
            if (packageFile != null) {
                inStream = packageFile.getInputStream();
                fos = new FileOutputStream(prePackageFile);
                byte[] buffer = new byte[1024];
                int byteread = 0;
                while ((byteread = inStream.read(buffer)) != -1) {
                    fos.write(buffer, 0, byteread);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("上传文件失败");
        } finally {
            if (inStream != null) {
                try {
                    inStream.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            if (fos != null) {
                try {
                    fos.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }

        }
    }

}
