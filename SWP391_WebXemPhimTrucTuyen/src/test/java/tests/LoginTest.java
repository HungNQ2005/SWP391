package tests;

import io.github.bonigarcia.wdm.WebDriverManager;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.testng.Assert;
import org.testng.annotations.*;

public class LoginTest {
    private WebDriver driver;
    private final String BASE_URL = "http://localhost:8080/SWP391_WebXemPhimTrucTuyen";

    @BeforeClass
    public void setup() {
        // ✅ Tự động tải chromedriver đúng phiên bản
        WebDriverManager.chromedriver().setup();
        driver = new ChromeDriver();
        driver.manage().window().maximize();
    }

    @Test(priority = 1)
    public void TC001_Login_Success() {
        driver.get(BASE_URL + "/login.jsp");

        driver.findElement(By.name("username")).sendKeys("AdminTest");
        driver.findElement(By.name("password")).sendKeys("123");

        driver.findElement(By.cssSelector("button.btn-danger")).click();

        try { Thread.sleep(2000); } catch (InterruptedException e) {}

        String currentUrl = driver.getCurrentUrl();
        boolean loginSuccess = currentUrl.contains("series?action=allOfSeries")
                || currentUrl.contains("homepage")
                || currentUrl.contains("index.jsp");

        Assert.assertTrue(loginSuccess, "❌ Login failed - not redirected to homepage.");
        System.out.println("✅ TC001 - Login thành công");
    }

    @Test(priority = 2)
    public void TC002_Login_InvalidPassword() {
        driver.get(BASE_URL + "/login.jsp");

        driver.findElement(By.name("username")).sendKeys("admin");
        driver.findElement(By.name("password")).sendKeys("sai_mat_khau");

        driver.findElement(By.cssSelector("button.btn-danger")).click();

        try { Thread.sleep(1000); } catch (InterruptedException e) {}

        WebElement alert = driver.findElement(By.className("alert-danger"));
        String errorText = alert.getText();

        Assert.assertTrue(errorText.toLowerCase().contains("invalid") || errorText.toLowerCase().contains("sai"),
                "❌ Không thấy thông báo lỗi đăng nhập.");
        System.out.println("✅ TC002 - Hiển thị lỗi khi đăng nhập sai");
    }

    @AfterClass
    public void tearDown() {
        if (driver != null) {
            driver.quit();
        }
    }
}
