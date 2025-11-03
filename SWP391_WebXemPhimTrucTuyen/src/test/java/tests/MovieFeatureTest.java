package tests;

import io.github.bonigarcia.wdm.WebDriverManager;
import org.openqa.selenium.*;
import org.openqa.selenium.chrome.ChromeDriver;
import org.testng.Assert;
import org.testng.annotations.*;

public class MovieFeatureTest {
    private WebDriver driver;
    private final String BASE_URL = "http://localhost:8080/SWP391_WebXemPhimTrucTuyen";

    @BeforeClass
    public void setup() {
        WebDriverManager.chromedriver().setup();
        driver = new ChromeDriver();
        driver.manage().window().maximize();

        // Đăng nhập trước khi test các chức năng cần tài khoản
        driver.get(BASE_URL + "/login.jsp");
        driver.findElement(By.name("username")).sendKeys("AdminTest");
        driver.findElement(By.name("password")).sendKeys("123");
        driver.findElement(By.cssSelector("button.btn-danger")).click();
        try { Thread.sleep(2000); } catch (InterruptedException e) {}
    }

    // ✅ TC006 - Xem phim
    @Test(priority = 1)
    public void TC006_ViewMovie() {
        // Giả sử đường dẫn movie info:
        driver.get(BASE_URL + "/series?action=sendMovieInfo&id=1");

        // Nhấn nút "Xem ngay"
        WebElement playButton = driver.findElement(By.cssSelector("a.btn-watch[href*='playFilm']"));
        playButton.click();

        try { Thread.sleep(2000); } catch (InterruptedException e) {}

        // Kiểm tra đã chuyển sang trang playFilm
        String currentUrl = driver.getCurrentUrl();
        Assert.assertTrue(currentUrl.contains("playFilm?id="),
                "❌ Không điều hướng đến trang phát phim.");
        System.out.println("✅ TC006 - Chức năng xem phim hoạt động đúng.");
    }

    // ✅ TC008 - Thêm phim vào danh sách yêu thích
    @Test(priority = 2)
    public void TC008_AddToWishlist() {
        // Mở lại trang MovieInfo của 1 phim cụ thể
        driver.get(BASE_URL + "/series?action=sendMovieInfo&id=1");

        // Nhấn nút "Yêu thích"
        WebElement addToFavBtn = driver.findElement(By.cssSelector("a[href*='wishlist?action=addFilmInFavorite']"));
        addToFavBtn.click();

        try { Thread.sleep(2000); } catch (InterruptedException e) {}

        // Mở trang wishlist
        driver.get(BASE_URL + "/wishlist?action=viewFavorite");

        // Kiểm tra phim đã xuất hiện trong danh sách yêu thích
        String pageSource = driver.getPageSource();
        boolean movieAdded = pageSource.toLowerCase().contains("conjuring")
                || pageSource.toLowerCase().contains("nghi lễ cuối cùng");

        Assert.assertTrue(movieAdded, "❌ Phim chưa được thêm vào danh sách yêu thích.");
        System.out.println("✅ TC008 - Thêm phim vào danh sách yêu thích thành công.");
    }

    @AfterClass
    public void tearDown() {
        if (driver != null) driver.quit();
    }
}
