package model;

public class Genre {
    private int genreId;
    private String genreName;
    private String description;

    public Genre() {}

    public Genre(int genreId, String genreName, String description) {
        this.genreId = genreId;
        this.genreName = genreName;
        this.description = description;
    }

    public int getGenreId() {
        return genreId;
    }

    public void setGenreId(int genreId) {
        this.genreId = genreId;
    }

    public String getGenreName() {
        return genreName;
    }

    public void setGenreName(String genreName) {
        this.genreName = genreName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
