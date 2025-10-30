/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Vo Thi Phi Yen - CE190428
 */
public class Series {

    private int seriesID;
    private String title;
    private String description;
    private int releaseYear;
    private String country;
    private String trailerUrl;
    private String posteUrl;
    private int typeId;

    public Series() {
    }

    public Series(int seriesID, String title, String description, int releaseYear, String country, String trailerUrl, String posteUrl) {
        this.seriesID = seriesID;
        this.title = title;
        this.description = description;
        this.releaseYear = releaseYear;
        this.country = country;
        this.trailerUrl = trailerUrl;
        this.posteUrl = posteUrl;
    }

    public Series(int seriesID, String title, String description, int releaseYear, String country, String trailerUrl, String posteUrl, int typeId) {
        this.seriesID = seriesID;
        this.title = title;
        this.description = description;
        this.releaseYear = releaseYear;
        this.country = country;
        this.trailerUrl = trailerUrl;
        this.posteUrl = posteUrl;
        this.typeId = typeId;
    }

    public int getTypeId() {
        return typeId;
    }

    public void setTypeId(int typeId) {
        this.typeId = typeId;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getReleaseYear() {
        return releaseYear;
    }

    public void setReleaseYear(int releaseYear) {
        this.releaseYear = releaseYear;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getTrailerUrl() {
        return trailerUrl;
    }

    public void setTrailerUrl(String trailerUrl) {
        this.trailerUrl = trailerUrl;
    }

    public Series(int seriesID, String title, String posteUrl) {
        this.seriesID = seriesID;
        this.title = title;
        this.posteUrl = posteUrl;
    }

    public int getSeriesID() {
        return seriesID;
    }

    public void setSeriesID(int seriesID) {
        this.seriesID = seriesID;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getPosteUrl() {
        return posteUrl;
    }

    public void setPosteUrl(String posteUrl) {
        this.posteUrl = posteUrl;
    }

    @Override
    public String toString() {
        return "Series{" + "seriesID=" + seriesID + ", title=" + title + ", description=" + description + ", releaseYear=" + releaseYear + ", country=" + country + ", trailerUrl=" + trailerUrl + ", posteUrl=" + posteUrl + '}';
    }

}
