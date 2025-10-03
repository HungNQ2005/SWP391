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
    private String posteUrl;

    public Series() {
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
    
    
}
