package lk.ijse.gdse71;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebFilter("/*")
public class CORSFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletResponse rsp = (HttpServletResponse) response;
        rsp.addHeader("Access-Control-Allow-Origin", "*");
        rsp.addHeader("Access-Control-Allow-Methods", "POST, GET,PUT, OPTIONS, DELETE");
        rsp.addHeader("Access-Control-Allow-Headers","Content-Type");
        chain.doFilter(request, response);
    }
}
