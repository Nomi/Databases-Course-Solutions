package project1;

import java.io.IOException;
import java.io.PrintWriter;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.*;
import javax.servlet.http.*;

public class Home extends HttpServlet {
    private static final String CONTENT_TYPE = "text/html; charset=windows-1252";

    public void init(ServletConfig config) throws ServletException {
        super.init(config);
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType(AppCommon.CONTENT_TYPE);
        PrintWriter out = response.getWriter();             
        out.println("<html><body>");
        try {
            Connection con = AppCommon.createConnection();
            Statement statement = con.createStatement();
            ResultSet rs = statement.executeQuery("SELECT * FROM INVOICES");
            tableHandler.printWholeTable(rs,response.getWriter());       //dont use out for the second parameter or the method will close it
            statement.close();
            rs.close();
            con.close();
            
            } catch (Exception e) {
            e.printStackTrace();
            }
            out.println("</body></html>");
            out.close();
    }
}
