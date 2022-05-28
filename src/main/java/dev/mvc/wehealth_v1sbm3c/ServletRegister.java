package dev.mvc.wehealth_v1sbm3c;

import com.ckfinder.connector.ConnectorServlet;
import dev.mvc.tool.Download;
import org.springframework.boot.web.servlet.ServletRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import javax.servlet.http.HttpServlet;
import java.util.HashMap;
import java.util.Map;

@Configuration
public class ServletRegister {
    @Bean
    public ServletRegistrationBean getServletRegistrationBean() {

        // urlPatterns: /download?dir=/items/storage&filename=winter_1.jpg&downname=winter.jpg
        // urlPatterns: /download?dir=/attachfile/storage&filename=winter_1.jpg&downname=winter.jpg
        ServletRegistrationBean registrationBean = new ServletRegistrationBean(new Download());
        registrationBean.addUrlMappings("/download"); // 접근 주소

        return registrationBean;
    }
    
    // CKEditor 서블릿 등록
    @Bean
    public ServletRegistrationBean<HttpServlet> getConnectorServlet()  {
      
      ServletRegistrationBean<HttpServlet> registrationBean = new ServletRegistrationBean<HttpServlet>(new ConnectorServlet());
      registrationBean.addUrlMappings("/ckfinder/core/connector/java/connector.java"); // 접근 주소
      Map<String, String> params = new HashMap<String, String>();
      params.put("XMLConfig", "/WEB-INF/ckfinder-config.xml");
      params.put("debug", "false");
      registrationBean.setInitParameters(params);
      
      registrationBean.setLoadOnStartup(1);

      return registrationBean;
    }
}
