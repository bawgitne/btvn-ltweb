package vn.iotstar.util;

import java.io.File;

public final class Constant {
    private Constant() {}

    public static final String SESSION_ACCOUNT = "account";
    public static final String SESSION_USERNAME = "username";
    public static final String COOKIE_REMEMBER = "username";

    // Thay cho hard-code E:\\upload trong slide để chạy đa nền tảng.
    public static final String DIR = System.getProperty("user.home")
            + File.separator + "mvc3tier-upload";

    public static final class Path {
        private Path() {}
        public static final String LOGIN = "/views/login.jsp";
        public static final String REGISTER = "/views/register.jsp";
        public static final String HOME = "/views/home.jsp";
        public static final String MANAGER_HOME = "/views/manager/home.jsp";
        public static final String ADMIN_HOME = "/views/admin/home.jsp";
        public static final String CATEGORY_LIST = "/views/admin/list-category.jsp";
        public static final String CATEGORY_ADD = "/views/admin/add-category.jsp";
        public static final String CATEGORY_EDIT = "/views/admin/edit-category.jsp";
    }
}
