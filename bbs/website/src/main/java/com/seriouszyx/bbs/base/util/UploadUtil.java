package com.seriouszyx.bbs.base.util;

import java.io.File;
import java.io.IOException;
import java.util.UUID;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.springframework.web.multipart.MultipartFile;

public class UploadUtil {
    public UploadUtil() {
    }

    public static String upload(MultipartFile file, String basePath) {
        String orgFileName = file.getOriginalFilename();
        String fileName = UUID.randomUUID().toString() + "." + FilenameUtils.getExtension(orgFileName);

        try {
            File targetFile = new File(basePath, fileName);
            FileUtils.writeByteArrayToFile(targetFile, file.getBytes());
            File publicFile = new File("/usr/etc/bbs", fileName);
            FileUtils.writeByteArrayToFile(publicFile, file.getBytes());
        } catch (IOException var6) {
            var6.printStackTrace();
        }

        return fileName;
    }

    public static String replace(MultipartFile file, String name, String basePath) throws IOException {
        String orgFileName = name.substring(name.lastIndexOf(47) + 1).replaceAll("[.][^.]+$", "");
        File path = new File(basePath);
        File[] var5 = path.listFiles();
        int var6 = var5.length;

        int var7;
        for(var7 = 0; var7 < var6; ++var7) {
            File f = var5[var7];
            String filename = f.getName().replaceAll("[.][^.]+$", "");
            if (filename.equals(orgFileName)) {
                FileUtils.writeByteArrayToFile(new File(basePath, f.getName()), file.getBytes());
            }
        }

        File publicPath = new File("/usr/etc/bbs");
        File[] var12 = publicPath.listFiles();
        var7 = var12.length;

        for(int var13 = 0; var13 < var7; ++var13) {
            File f = var12[var13];
            String filename = f.getName().replaceAll("[.][^.]+$", "");
            if (filename.equals(orgFileName)) {
                FileUtils.writeByteArrayToFile(new File("/usr/etc/bbs", f.getName()), file.getBytes());
            }
        }

        return name;
    }

    public static void delete(String path, String basePath) {
        String filename = (new File(path)).getName();
        File file = new File(basePath, filename);
        File publicFile = new File("/usr/etc/bbs", filename);
        file.delete();
        publicFile.delete();
    }
}
