/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

import org.mindrot.jbcrypt.BCrypt;

/**
 *
 * @author Chau Tan Cuong - CE190026
 */
public class HashUtil {

    public static String hashPassword(String plainPassword) {
        return BCrypt.hashpw(plainPassword, BCrypt.gensalt());
    }

    public static boolean checkPassword(String plainPassword, String hashedPassword) {
        return BCrypt.checkpw(plainPassword, hashedPassword);
    }

    public static void main(String[] args) {
        // Tao cai moi
        String newHashedPassword = HashUtil.hashPassword("admin123");
        System.out.println("Mật khẩu băm mới: " + newHashedPassword);

        // Test pass hash
//        String dbPassword = "$2a$10$bu./TAAUEALiHC9l0DVlUOTJMllvtb9Byll1YDmSlLcIsGvB236X2"; // Giá trị từ database
//        String inputPassword = "123"; // Mật khẩu bạn muốn kiểm tra
//        boolean matches = HashUtil.checkPassword(inputPassword, dbPassword);
//        System.out.println("Mật khẩu khớp: " + matches);
    }

}
