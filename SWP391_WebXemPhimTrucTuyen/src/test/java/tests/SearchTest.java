package tests;

import io.github.bonigarcia.wdm.WebDriverManager;
import org.openqa.selenium.*;
import org.openqa.selenium.chrome.ChromeDriver;
import org.testng.Assert;
import org.testng.annotations.*;

public class SearchTest {
    private WebDriver driver;
    private final String BASE_URL = "http://localhost:8080/SWP391_WebXemPhimTrucTuyen";

    @BeforeClass
    public void setup() {
        WebDriverManager.chromedriver().setup();
        driver = new ChromeDriver();
        driver.manage().window().maximize();
    }

    // ✅ TC004 - Verify movie search by valid title
    @Test(priority = 1)
    public void TC004_SearchMovie_ValidTitle() {
        driver.get(BASE_URL + "/series?action=allOfSeries");

        // Nhập tên phim hợp lệ (ví dụ: "Avengers")
        WebElement searchBox = driver.findElement(By.name("query"));
        searchBox.clear();
        searchBox.sendKeys("Avengers");
        searchBox.sendKeys(Keys.ENTER);

        // Chờ tải trang
        try { Thread.sleep(2000); } catch (InterruptedException e) {}

        // Kiểm tra tiêu đề kết quả và có ít nhất 1 phim được hiển thị
        String pageSource = driver.getPageSource();
        boolean hasResult = pageSource.contains("Kết quả tìm kiếm cho") && !pageSource.contains("Không tìm thấy phim");

        Assert.assertTrue(hasResult, "❌ Không thấy kết quả tìm kiếm hợp lệ.");
        System.out.println("✅ TC004 - Tìm kiếm phim hợp lệ hiển thị kết quả.");
    }

    // ✅ TC005 - Verify movie search with invalid title
    @Test(priority = 2)
    public void TC005_SearchMovie_InvalidTitle() {
        driver.get(BASE_URL + "/series?action=allOfSeries");

        // Nhập tiêu đề phim không tồn tại
        WebElement searchBox = driver.findElement(By.name("query"));
        searchBox.clear();
        searchBox.sendKeys("phimkhongtontai123");
        searchBox.sendKeys(Keys.ENTER);

        try { Thread.sleep(2000); } catch (InterruptedException e) {}

        // Kiểm tra thông báo "Không tìm thấy phim nào phù hợp."
        String pageSource = driver.getPageSource();
        boolean noResultMessage = pageSource.contains("Không tìm thấy phim nào phù hợp");

        Assert.assertTrue(noResultMessage, "❌ Không hiển thị thông báo khi tìm kiếm sai.");
        System.out.println("✅ TC005 - Hiển thị thông báo khi tìm kiếm không hợp lệ.");
    }

    @AfterClass
    public void tearDown() {
        if (driver != null) {
            driver.quit();
        }
    }
}
