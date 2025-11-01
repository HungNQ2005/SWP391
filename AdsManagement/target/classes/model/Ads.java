/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
import java.sql.Timestamp;
/**
 *
 * @author PHUOCSANH
 */


public class Ads {
    private int ads_ID;
    private String ads_name;
    private String ads_image;
    private String ads_link;
    private String status;
    private Timestamp created_at;
    private Timestamp updated_at;

    public Ads() {}

    public Ads(int ads_ID, String ads_name, String ads_image, String ads_link, String status, Timestamp created_at, Timestamp updated_at) {
        this.ads_ID = ads_ID;
        this.ads_name = ads_name;
        this.ads_image = ads_image;
        this.ads_link = ads_link;
        this.status = status;
        this.created_at = created_at;
        this.updated_at = updated_at;
    }

    public int getAds_ID() {
        return ads_ID;
    }

    public void setAds_ID(int ads_ID) {
        this.ads_ID = ads_ID;
    }

    public String getAds_name() {
        return ads_name;
    }

    public void setAds_name(String ads_name) {
        this.ads_name = ads_name;
    }

    public String getAds_image() {
        return ads_image;
    }

    public void setAds_image(String ads_image) {
        this.ads_image = ads_image;
    }

    public String getAds_link() {
        return ads_link;
    }

    public void setAds_link(String ads_link) {
        this.ads_link = ads_link;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getCreated_at() {
        return created_at;
    }

    public void setCreated_at(Timestamp created_at) {
        this.created_at = created_at;
    }

    public Timestamp getUpdated_at() {
        return updated_at;
    }

    public void setUpdated_at(Timestamp updated_at) {
        this.updated_at = updated_at;
    }
}