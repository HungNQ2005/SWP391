package tests;

import io.github.bonigarcia.wdm.WebDriverManager;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.testng.Assert;
import org.testng.annotations.*;

import java.time.Duration;

public class SignUpTest {

    private WebDriver driver;
    private final String baseUrl = "http://localhost:8080/SWP391_WebXemPhimTrucTuyen/SignUp.jsp";

    @BeforeClass
    public void setUp() {
        // ✅ WebDriverManager sẽ tự động tải và cấu hình ChromeDriver phù hợp
        WebDriverManager.chromedriver().setup();
        driver = new ChromeDriver();
        driver.manage().window().maximize();
        driver.manage().timeouts().implicitlyWait(Duration.ofSeconds(10));
    }

    // --- Test Case 1: Đăng ký thành công ---
    @Test(priority = 1)
    public void testSignUpSuccess() {
        driver.get(baseUrl);

        driver.findElement(By.name("username")).sendKeys("Tester" + System.currentTimeMillis());
        driver.findElement(By.name("email")).sendKeys("tester@gmail.com");
        driver.findElement(By.name("password")).sendKeys("Testser@123");
        driver.findElement(By.name("passwordConfirm")).sendKeys("Testser@123");

        driver.findElement(By.cssSelector("button[type='submit']")).click();

        // ✅ Kiểm tra có thông báo đăng ký thành công không
        WebElement message = driver.findElement(By.xpath("//*[contains(text(),'Đăng ký thành công')]"));
        Assert.assertTrue(message.isDisplayed(), "❌ Không thấy thông báo đăng ký thành công!");
    }

    // --- Test Case 2: Mật khẩu không khớp ---
    @Test(priority = 2)
    public void testSignUpPasswordMismatch() {
        driver.get(baseUrl);

        driver.findElement(By.name("username")).sendKeys("userMismatch");
        driver.findElement(By.name("email")).sendKeys("userMismatch@gmail.com");
        driver.findElement(By.name("password")).sendKeys("Password@123");
        driver.findElement(By.name("passwordConfirm")).sendKeys("Password@999");

        driver.findElement(By.cssSelector("button[type='submit']")).click();

        // ✅ Kiểm tra lỗi “Mẫu khẩu không khớp”
        WebElement error = driver.findElement(By.xpath("//*[contains(text(),'Mẫu khẩu không khớp')]"));
        Assert.assertTrue(error.isDisplayed(), "❌ Không thấy thông báo mật khẩu không khớp!");
    }

    // --- Test Case 3: Email không hợp lệ ---
    @Test(priority = 3)
    public void testSignUpInvalidEmail() {
        driver.get(baseUrl);

        driver.findElement(By.name("username")).sendKeys("invalidEmailUser");
        driver.findElement(By.name("email")).sendKeys("invalidemail");
        driver.findElement(By.name("password")).sendKeys("Password@123");
        driver.findElement(By.name("passwordConfirm")).sendKeys("Password@123");

        driver.findElement(By.cssSelector("button[type='submit']")).click();

        // ✅ Kiểm tra lỗi “Định dạng email không hợp lệ”
        WebElement error = driver.findElement(By.xpath("//*[contains(text(),'Định dạng email không hợp lệ')]"));
        Assert.assertTrue(error.isDisplayed(), "❌ Không thấy thông báo email không hợp lệ!");
    }

    @AfterClass
    public void tearDown() {
        if (driver != null) {
            driver.quit();
        }
    }
}
