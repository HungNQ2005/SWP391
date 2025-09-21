/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.sql.Timestamp;

/**
 *
 * @author Chau Tan Cuong - CE190026
 */
public class User {
    private int user_id;
    private String username;
    private String email;
    private String hash_password;
    private String full_name;
    private String user_level;
    private String avatar_url;
    private String reset_token;
    private java.sql.Timestamp token_expiry;
    
    

    public User() {
    }

    public User(int user_id, String username, String email, String hash_password, String full_name, String user_level, String avatar_url) {
        this.user_id = user_id;
        this.username = username;
        this.email = email;
        this.hash_password = hash_password;
        this.full_name = full_name;
        this.user_level = user_level;
        this.avatar_url = avatar_url;
    }

    public User(int user_id, String username, String email, String hash_password, String full_name, String user_level, String avatar_url, String reset_token, Timestamp token_expiry) {
        this.user_id = user_id;
        this.username = username;
        this.email = email;
        this.hash_password = hash_password;
        this.full_name = full_name;
        this.user_level = user_level;
        this.avatar_url = avatar_url;
        this.reset_token = reset_token;
        this.token_expiry = token_expiry;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getReset_token() {
        return reset_token;
    }

    public void setReset_token(String reset_token) {
        this.reset_token = reset_token;
    }

    public Timestamp getToken_expiry() {
        return token_expiry;
    }

    public void setToken_expiry(Timestamp token_expiry) {
        this.token_expiry = token_expiry;
    }
    

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getHash_password() {
        return hash_password;
    }

    public void setHash_password(String hash_password) {
        this.hash_password = hash_password;
    }

    public String getFull_name() {
        return full_name;
    }

    public void setFull_name(String full_name) {
        this.full_name = full_name;
    }

    public String getUser_level() {
        return user_level;
    }

    public void setUser_level(String user_level) {
        this.user_level = user_level;
    }

    public String getAvatar_url() {
        return avatar_url;
    }

    public void setAvatar_url(String avatar_url) {
        this.avatar_url = avatar_url;
    }
    
    
}
