package tests;

import io.github.bonigarcia.wdm.WebDriverManager;
import org.openqa.selenium.*;
import org.openqa.selenium.chrome.ChromeDriver;
import org.testng.Assert;
import org.testng.annotations.*;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import java.time.Duration;
import org.openqa.selenium.JavascriptExecutor;

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
        // Mở trang MovieInfo của phim id=1
        driver.get(BASE_URL + "/series?action=sendMovieInfo&id=2");

        // Tìm nút Yêu thích bằng selector tổng quát hơn
        By addFavSelector = By.cssSelector("a[href*='wishlist?action=addFilmInFavorite&seriesId=2']");

        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));

        // Chờ phần tử có mặt trong DOM và visible
        WebElement addToFavBtn = wait.until(ExpectedConditions.visibilityOfElementLocated(addFavSelector));

        // Scroll vào view (tránh header cố định che phần tử)
        ((JavascriptExecutor) driver).executeScript("arguments[0].scrollIntoView({block: 'center'});", addToFavBtn);

        // Chờ element clickable
        wait.until(ExpectedConditions.elementToBeClickable(addFavSelector));

        // Dùng JS click (an toàn khi bị che bởi overlay nhỏ)
        ((JavascriptExecutor) driver).executeScript("arguments[0].click();", addToFavBtn);

        // Chờ server xử lý và redirect/hoặc cập nhật
        try { Thread.sleep(1000); } catch (InterruptedException ignored) {}

        // Mở trang wishlist (dùng URL thật bạn có)
        driver.get(BASE_URL + "/wishlist?action=viewFavorite");

        // Chờ xuất hiện link tới phim (dùng seriesID) trong wishlist
        By movieLinkInWishlist = By.cssSelector("a[href*='series?action=sendMovieInfo&id=2']");
        wait = new WebDriverWait(driver, Duration.ofSeconds(8));
        boolean added;
        try {
            wait.until(ExpectedConditions.presenceOfElementLocated(movieLinkInWishlist));
            added = true;
        } catch (TimeoutException te) {
            added = false;
        }

        Assert.assertTrue(added, "❌ Phim chưa được thêm vào danh sách yêu thích.");
        System.out.println("✅ TC008 - Thêm phim vào danh sách yêu thích thành công.");
    }



    @AfterClass
    public void tearDown() {
        if (driver != null) driver.quit();
    }
}
