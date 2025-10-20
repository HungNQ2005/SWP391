/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Vo Thi Phi Yen - CE190428
 */
public class Performers {

    private int performer_id;
    private String name;
    private String photo_url;
    private String gender;
    private String description;
    private String date_of_birth;
    private String nationality;
    public Performers() {
    }

    public Performers(int performer_id, String name, String photo_url, String gender, String description, String date_of_birth) {
        this.performer_id = performer_id;
        this.name = name;
        this.photo_url = photo_url;
        this.gender = gender;
        this.description = description;
        this.date_of_birth = date_of_birth;
    }

    public Performers(int performer_id, String name, String photo_url, String gender, String description, String date_of_birth, String nationality) {
        this.performer_id = performer_id;
        this.name = name;
        this.photo_url = photo_url;
        this.gender = gender;
        this.description = description;
        this.date_of_birth = date_of_birth;
        this.nationality = nationality;
    }
     
    public int getPerformer_id() {
        return performer_id;
    }

    public void setPerformer_id(int performer_id) {
        this.performer_id = performer_id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhoto_url() {
        return photo_url;
    }

    public void setPhoto_url(String photo_url) {
        this.photo_url = photo_url;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getDate_of_birth() {
        return date_of_birth;
    }

    public void setDate_of_birth(String date_of_birth) {
        this.date_of_birth = date_of_birth;
    }

    public String getNationality() {
        return nationality;
    }

    public void setNationality(String nationality) {
        this.nationality = nationality;
    }

    @Override
    public String toString() {
        return "Performers{" + "performer_id=" + performer_id + ", name=" + name + ", photo_url=" + photo_url + ", gender=" + gender + ", description=" + description + ", date_of_birth=" + date_of_birth + ", nationality=" + nationality + '}';
    }
}
