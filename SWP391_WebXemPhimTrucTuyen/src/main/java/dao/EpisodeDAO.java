package dao;

import entity.Episode;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class EpisodeDAO {
    public List<Episode> getEpisodesBySeriesId(int seriesId) {
        List<Episode> episodes = new ArrayList<>();
        String sql = "SELECT episode_id, series_id, title, description, episode_number, duration_minutes, release_date, video_url, release_time "
                + "FROM Episode WHERE series_id = ? ORDER BY episode_number ASC";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, seriesId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    episodes.add(new Episode(
                            rs.getInt("episode_id"),
                            rs.getInt("series_id"),
                            rs.getString("title"),
                            rs.getInt("episode_number"),
                            rs.getString("video_url"),
                            rs.getString("description"),
                            rs.getInt("duration_minutes"),
                            rs.getDate("release_date"),
                            rs.getTime("release_time")
                    ));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return episodes;
    }

    public static void main(String[] args) {
        EpisodeDAO dao = new EpisodeDAO();
        List<Episode> list = dao.getEpisodesBySeriesId(17);
        for (Episode o : list) {
            System.out.println(o);}
    }



    public Episode getEpisodeById(int episodeId) {
        String sql = "SELECT * FROM Episode WHERE episode_id = ?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, episodeId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Episode(
                            rs.getInt("episode_id"),
                            rs.getInt("series_id"),
                            rs.getString("title"),
                            rs.getInt("episode_number"),
                            rs.getString("video_url"),
                            rs.getString("description"),
                            rs.getInt("duration_minutes"),
                            rs.getDate("release_date"),
                            rs.getTime("release_time")
                    );
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }



    public Episode getFirstEpisodeBySeriesId(int seriesId) {
        String sql = "SELECT TOP 1 * FROM Episode WHERE series_id = ? ORDER BY episode_number ASC";
        try  {
            Connection conn = new DBContext().getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, seriesId);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Episode ep = new Episode();
                ep.setEpisodeId(rs.getInt("episode_id"));
                ep.setSeriesId(rs.getInt("series_id"));
                ep.setEpisodeTitle(rs.getString("title"));
                ep.setEpisodeNumber(rs.getInt("episode_number"));
                ep.setEpisodeUrl(rs.getString("video_url"));
                return ep;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }


}
