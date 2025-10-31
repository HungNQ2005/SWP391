package model;

public class Account {
    private int id;
    private String email;
    private String password;

    // 🔹 Constructor trống (bắt buộc cho JSP/Servlet)
    public Account() {
    }

    // 🔹 Constructor có tham số (id, email, password)
    public Account(int id, String email, String password) {
        this.id = id;
        this.email = email;
        this.password = password;
    }

    // 🔹 Getter và Setter
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
