/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

/**
 *
 * @author Chau Tan Cuong - CE190026
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
    private String countryName;
    private String categoryName;
    private String filmUrl;
    public Series() {
    }

    public Series(int seriesID, String title, String description, int releaseYear, String country, String trailerUrl, String posteUrl, int typeId, String filmUrl) {
        this.seriesID = seriesID;
        this.title = title;
        this.description = description;
        this.releaseYear = releaseYear;
        this.country = country;
        this.trailerUrl = trailerUrl;
        this.posteUrl = posteUrl;
        this.typeId = typeId;
        this.filmUrl = filmUrl;
    }

  

    public Series(int seriesID, String title, String description, int releaseYear, String country, String trailerUrl, String posteUrl, int typeId, String countryName, String categoryName, String filmUrl) {
        this.seriesID = seriesID;
        this.title = title;
        this.description = description;
        this.releaseYear = releaseYear;
        this.country = country;
        this.trailerUrl = trailerUrl;
        this.posteUrl = posteUrl;
        this.typeId = typeId;
        this.countryName = countryName;
        this.categoryName = categoryName;
        this.filmUrl = filmUrl;
    }

    public String getFilmUrl() {
        return filmUrl;
    }

    public void setFilmUrl(String filmUrl) {
        this.filmUrl = filmUrl;
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


    public Series(int seriesID, String categoryName, String countryName, int typeId, String posteUrl, String description, int releaseYear, String trailerUrl, String country, String title) {
        this.seriesID = seriesID;
        this.categoryName = categoryName;
        this.countryName = countryName;
        this.typeId = typeId;
        this.posteUrl = posteUrl;
        this.description = description;
        this.releaseYear = releaseYear;
        this.trailerUrl = trailerUrl;
        this.country = country;
        this.title = title;
    }

    public String getCountryName() {
        return countryName;
    }

    public void setCountryName(String countryName) {
        this.countryName = countryName;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
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
