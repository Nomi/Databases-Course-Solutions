package project1;

import java.io.IOException;
import java.io.PrintWriter;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.naming.InitialContext;
import javax.naming.NamingException;

import javax.servlet.*;
import javax.servlet.http.*;

import javax.sql.DataSource;

public class Filter extends HttpServlet {
//Not going to use doPost because it will make passing values via hyperlinks complicated (due to need for hidden forms or AJAX)
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {     //tested with doPost and it works! Exept the above comment is still valid.
        response.setContentType(AppCommon.CONTENT_TYPE);
        PrintWriter out = response.getWriter();
        out.println("<html>");
        out.println("<body>");
        try {
            Connection con = AppCommon.createConnection();
            Statement statement = con.createStatement();
            PreparedStatement ps = null;
            ps = con.prepareStatement("select * from INVOICES where INVOICES.ACTIVATION_DATE between ? and ? and INVOICES.NET_AMOUNT between ? and ? ORDER BY INVOICES.ACTIVATION_DATE asc");
            ps.setDate(1, AppCommon.parseDate(request.getParameter("FromActDat")));
            ps.setDate(2, AppCommon.parseDate(request.getParameter("ToActDat")));
            ps.setDouble(3, AppCommon.parseDouble(request.getParameter("FromNetAmt")));
            ps.setDouble(4, AppCommon.parseDouble(request.getParameter("ToNetAmt")));
            out.println("FILTER COMPLETED!\n Data of all Invoices is:\n");    
            tableHandler.printTable(ps.executeQuery(),response.getWriter());
            out.println("&nbsp;&nbsp; | &nbsp;&nbsp; <a href=FilterData.html> Filter again with different criteria?</a>");
            statement.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        out.println("</body></html>");
        out.close();
    }
}
