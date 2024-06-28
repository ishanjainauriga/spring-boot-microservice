//package aws;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.boot.ApplicationArguments;
//import org.springframework.boot.ApplicationRunner;
//import org.springframework.core.env.ConfigurableEnvironment;
//import org.springframework.core.env.MapPropertySource;
//import org.springframework.stereotype.Component;
//import com.fasterxml.jackson.databind.ObjectMapper;
//import com.fasterxml.jackson.core.type.TypeReference;
//
//import java.util.HashMap;
//import java.util.Map;
//
//@Component
//public class SecretsLoader implements ApplicationRunner {
//
//    @Autowired
//    private SecretsManagerService secretsManagerService;
//
//    @Autowired
//    private ConfigurableEnvironment env;
//
//    @Override
//    public void run(ApplicationArguments args) {
//        String secretName = "service-discovery-secret"; // Replace with your secret name
//        String secret = secretsManagerService.getSecret(secretName);
//
//        Map<String, Object> properties = parseSecret(secret);
//        env.getPropertySources().addFirst(new MapPropertySource("aws-secrets", properties));
//    }
//
//    private Map<String, Object> parseSecret(String secret) {
//        Map<String, Object> properties = new HashMap<>();
//        ObjectMapper objectMapper = new ObjectMapper();
//        try {
//            properties = objectMapper.readValue(secret, new TypeReference<Map<String, Object>>() {
//            });
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        return properties;
//    }
//}
