package project1;

import java.io.IOException;
import java.io.PrintWriter;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Types;

import javax.servlet.*;
import javax.servlet.http.*;

public class deleterow extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException{
        response.setContentType(AppCommon.CONTENT_TYPE);
        PrintWriter out = response.getWriter();
        out.println("<html></head><body>");
        try {         
            Connection con = AppCommon.createConnection();
            Statement statement = con.createStatement();
            PreparedStatement ps = null;
            ps = con.prepareStatement("delete INVOICES where IMSI=?"); //didn't need to specify column names since we're using all of them in the order they are in, but still it makes for better comprehensibility
            ps.setInt(1, Integer.valueOf(request.getParameter("IMSI")));
            ps.executeUpdate();
            out.println("DELETE COMPLETE!\n");
            statement.close();
            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        out.println("<br><a href=\\Project1\\home>Go back home(whole table)?</a>");
        out.println("</body></html>");
        out.close();
    }
}

