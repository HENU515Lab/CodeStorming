package com.seriouszyx.bbs.base.util;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

/**
 * 上传工具
 */
public class UploadUtil {

    /**
     * 处理文件上传
     *
     * @param file
     * @param basePath 存放文件的目录的绝对路径 servletContext.getRealPath("/upload")
     * @return
     */
    public static String upload(MultipartFile file, String basePath) {
        String orgFileName = file.getOriginalFilename();
        String fileName = UUID.randomUUID().toString() + "."
                + FilenameUtils.getExtension(orgFileName);
        try {
            File targetFile = new File(basePath, fileName);
            FileUtils.writeByteArrayToFile(targetFile, file.getBytes());

            //把文件同步到公共文件夹
            File publicFile = new File(BidConst.PUBLIC_IMG_SHARE_PATH, fileName);
            FileUtils.writeByteArrayToFile(publicFile, file.getBytes());
        } catch (IOException e) {
            e.printStackTrace();
        }
        return fileName;
    }

    public static String replace(MultipartFile file, String name, String basePath) throws IOException {
        String orgFileName = name.substring(name.lastIndexOf('/') + 1).replaceAll("[.][^.]+$", ""); // 无文件后缀
        File path = new File(basePath);
        for (File f : path.listFiles()) {
            String filename = f.getName().replaceAll("[.][^.]+$", "");
            if (filename.equals(orgFileName)) {
                FileUtils.writeByteArrayToFile(new File(basePath, f.getName()), file.getBytes());
            }
        }
        File publicPath = new File(BidConst.PUBLIC_IMG_SHARE_PATH);
        for (File f : publicPath.listFiles()) {
            String filename = f.getName().replaceAll("[.][^.]+$", "");
            if (filename.equals(orgFileName)) {
                FileUtils.writeByteArrayToFile(new File(BidConst.PUBLIC_IMG_SHARE_PATH,
                        f.getName()), file.getBytes());
            }
        }
        return name;
    }

}
