/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

import java.util.Random;

/**
 *
 * @author Nguyen Quoc Hung - CE190870
 */
public class CDKeyGenerator {
    private static final String CHARSET = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    private static final int GROUPS = 3;
    private static final int GROUP_LENGTH = 5;
    private final Random random = new Random();

    /**
     * Generates a random CD key in the format XXXXX-XXXXX-XXXXX.
     *
     * @return generated CD key string
     */
    public String generateKey() {
        StringBuilder key = new StringBuilder();
        for (int g = 0; g < GROUPS; g++) {
            if (g > 0) key.append('-');
            for (int i = 0; i < GROUP_LENGTH; i++) {
                int idx = random.nextInt(CHARSET.length());
                key.append(CHARSET.charAt(idx));
            }
        }
        return key.toString();
    }
}