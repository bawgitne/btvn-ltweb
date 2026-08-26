package vn.iotstar.util;

import org.apache.commons.fileupload.FileItem;

import java.io.File;

public final class UploadUtil {
    private UploadUtil() {}

    public static String saveCategoryIcon(FileItem item) throws Exception {
        if (item == null || item.isFormField() || item.getSize() <= 0) return null;
        String original = new File(item.getName()).getName();
        String ext = "";
        int dot = original.lastIndexOf('.');
        if (dot >= 0 && dot < original.length() - 1) {
            ext = "." + original.substring(dot + 1).replaceAll("[^A-Za-z0-9]", "");
        }
        String fileName = System.currentTimeMillis() + "_" + Math.abs(original.hashCode()) + ext;
        File dir = new File(Constant.DIR, "category");
        if (!dir.exists() && !dir.mkdirs()) {
            throw new IllegalStateException("Không tạo được thư mục upload: " + dir.getAbsolutePath());
        }
        File output = new File(dir, fileName);
        item.write(output);
        return "category/" + fileName;
    }
}
