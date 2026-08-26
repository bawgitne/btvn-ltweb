package vn.iotstar.controller;

import org.apache.commons.io.IOUtils;
import vn.iotstar.util.Constant;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.nio.file.Files;

@WebServlet(urlPatterns = "/image")
public class DownloadImageController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String fileName = req.getParameter("fname");
        if (fileName == null || fileName.isBlank()) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        File base = new File(Constant.DIR).getCanonicalFile();
        File file = new File(base, fileName).getCanonicalFile();
        if (!file.getPath().startsWith(base.getPath() + File.separator) || !file.exists() || !file.isFile()) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        String type = Files.probeContentType(file.toPath());
        resp.setContentType(type != null ? type : "application/octet-stream");
        resp.setContentLengthLong(file.length());
        try (InputStream in = new FileInputStream(file)) {
            IOUtils.copy(in, resp.getOutputStream());
        }
    }
}
