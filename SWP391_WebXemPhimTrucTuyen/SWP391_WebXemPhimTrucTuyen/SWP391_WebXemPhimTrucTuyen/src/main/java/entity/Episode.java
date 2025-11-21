package entity;

import java.sql.Time;
import java.util.Date;

public class Episode {
    private int episodeId;
    private int seriesId;
    private String episodeTitle;
    private int episodeNumber;
    private String episodeUrl;
    private String episodeDescription;
    private int episodeDuration;
    private Date episodeReleaseDate;
    private Time episodeReleaseTime;
    public Episode() {
    }

    public Episode(int episodeId, int seriesId, String episodeTitle, int episodeNumber, String episodeUrl, String episodeDescription, int episodeDuration, Date episodeReleaseDate, Time episodeReleaseTime) {
        this.episodeId = episodeId;
        this.seriesId = seriesId;
        this.episodeTitle = episodeTitle;
        this.episodeNumber = episodeNumber;
        this.episodeUrl = episodeUrl;
        this.episodeDescription = episodeDescription;
        this.episodeDuration = episodeDuration;
        this.episodeReleaseDate = episodeReleaseDate;
        this.episodeReleaseTime = episodeReleaseTime;
    }

    public Episode(int episodeId, int seriesId, String episodeTitle, int episodeNumber, String episodeUrl, String episodeDescription, int episodeDuration, Date episodeReleaseDate) {
        this.episodeId = episodeId;
        this.seriesId = seriesId;
        this.episodeTitle = episodeTitle;
        this.episodeNumber = episodeNumber;
        this.episodeUrl = episodeUrl;
        this.episodeDescription = episodeDescription;
        this.episodeDuration = episodeDuration;
        this.episodeReleaseDate = episodeReleaseDate;
    }

    public Episode(int episodeId, int seriesId, String episodeTitle, int episodeNumber, String episodeUrl) {
        this.episodeId = episodeId;
        this.seriesId = seriesId;
        this.episodeTitle = episodeTitle;
        this.episodeNumber = episodeNumber;
        this.episodeUrl = episodeUrl;
    }

    public Time getEpisodeReleaseTime() {
        return episodeReleaseTime;
    }

    public void setEpisodeReleaseTime(Time episodeReleaseTime) {
        this.episodeReleaseTime = episodeReleaseTime;
    }

    public String getEpisodeDescription() {
        return episodeDescription;
    }

    public void setEpisodeDescription(String episodeDescription) {
        this.episodeDescription = episodeDescription;
    }

    public int getEpisodeDuration() {
        return episodeDuration;
    }

    public void setEpisodeDuration(int episodeDuration) {
        this.episodeDuration = episodeDuration;
    }

    public Date getEpisodeReleaseDate() {
        return episodeReleaseDate;
    }

    public void setEpisodeReleaseDate(Date episodeReleaseDate) {
        this.episodeReleaseDate = episodeReleaseDate;
    }

    public int getEpisodeId() {
        return episodeId;
    }

    public void setEpisodeId(int episodeId) {
        this.episodeId = episodeId;
    }

    public int getSeriesId() {
        return seriesId;
    }

    public void setSeriesId(int seriesId) {
        this.seriesId = seriesId;
    }

    public String getEpisodeTitle() {
        return episodeTitle;
    }

    public void setEpisodeTitle(String episodeTitle) {
        this.episodeTitle = episodeTitle;
    }

    public int getEpisodeNumber() {
        return episodeNumber;
    }

    public void setEpisodeNumber(int episodeNumber) {
        this.episodeNumber = episodeNumber;
    }

    public String getEpisodeUrl() {
        return episodeUrl;
    }

    public void setEpisodeUrl(String episodeUrl) {
        this.episodeUrl = episodeUrl;
    }

    @Override
    public String toString() {
        return "Episode{" +
                "episodeId=" + episodeId +
                ", seriesId=" + seriesId +
                ", episodeTitle='" + episodeTitle + '\'' +
                ", episodeNumber=" + episodeNumber +
                ", episodeUrl='" + episodeUrl + '\'' +
                '}';
    }
}
