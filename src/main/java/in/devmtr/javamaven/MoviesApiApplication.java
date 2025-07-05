package in.devmtr.javamaven;

import java.io.InputStream;
import java.nio.charset.StandardCharsets;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.core.io.ClassPathResource;
import org.springframework.util.StreamUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
@RestController
public class MoviesApiApplication {

    public static void main(String[] args) {
        SpringApplication.run(MoviesApiApplication.class, args);
    }

    @Value("${server.port}")
    private String serverPort;

    @GetMapping("/")
    public String healthPage() {
        try {
            // Load the HTML file from classpath
            InputStream in = new ClassPathResource("static/healthCheck.html").getInputStream();
            String html = StreamUtils.copyToString(in, StandardCharsets.UTF_8);

            // Replace placeholder
            html = html.replace("{{PORT}}", serverPort);

            return html;
        } catch (Exception e) {
            return "<h1>Error loading page</h1><p>" + e.getMessage() + "</p>";
        }
    }

    @GetMapping("heads_or_tails")
    public String headsOrTails() {
        try {
            InputStream in = new ClassPathResource("static/headsOrTails.html").getInputStream();

            String html = StreamUtils.copyToString(in, StandardCharsets.UTF_8);

            return html;

        } catch (Exception e) {
            // TODO: handle exception
            return "<h1>Error loading page</h1><p>" + e.getMessage() + "</p>";
        }
    }

}
