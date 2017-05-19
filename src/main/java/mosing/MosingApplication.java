package mosing;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.support.SpringBootServletInitializer;
//import org.springframework.boot.CommandLineRunner;
//import org.springframework.boot.context.properties.EnableConfigurationProperties;
//import org.springframework.context.annotation.Bean;
//import mosing.service.StorageProperties;
//import mosing.service.StorageService;

@SpringBootApplication
//@EnableConfigurationProperties(StorageProperties.class)
public class MosingApplication extends SpringBootServletInitializer {
	
	@Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
        return application.sources(MosingApplication.class);
    }

	public static void main(String[] args) {
		SpringApplication.run(MosingApplication.class, args);
	}
	
//	@Bean
//	CommandLineRunner init(StorageService storageService) {
//		return (args) -> {
//            storageService.deleteAll();
//            storageService.init();
//		};
//	}
}