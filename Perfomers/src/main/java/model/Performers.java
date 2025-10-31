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

    private int performerID;
    private String name;
    private String photoUrl;
    private String gender;
    private String description;
    private String dateOfBirth;
    private String nationality;

    public Performers() {
    }

    public Performers(int performerID, String name, String photoUrl, String gender, String description, String dateOfBirth, String nationality) {
        this.performerID = performerID;
        this.name = name;
        this.photoUrl = photoUrl;
        this.gender = gender;
        this.description = description;
        this.dateOfBirth = dateOfBirth;
        this.nationality = nationality;
    }

    public int getPerformerID() {
        return performerID;
    }

    public void setPerformerID(int performerID) {
        this.performerID = performerID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhotoUrl() {
        return photoUrl;
    }

    public void setPhotoUrl(String photoUrl) {
        this.photoUrl = photoUrl;
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

    public String getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(String dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    public String getNationality() {
        return nationality;
    }

    public void setNationality(String nationality) {
        this.nationality = nationality;
    }

    @Override
    public String toString() {
        return "Performers{" + "performerID=" + performerID
                + ", name=" + name
                + ", photoUrl=" + photoUrl
                + ", gender=" + gender
                + ", description=" + description
                + ", dateOfBirth=" + dateOfBirth
                + ", nationality=" + nationality + '}';
    }

}
