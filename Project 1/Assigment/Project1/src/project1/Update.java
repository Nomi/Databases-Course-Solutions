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

public class Update extends HttpServlet {
    private static final String CONTENT_TYPE = "text/html; charset=windows-1252";

    public void init(ServletConfig config) throws ServletException {
        super.init(config);
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException{
        response.setContentType(AppCommon.CONTENT_TYPE);
        PrintWriter out = response.getWriter();
        out.println("<html></head><body>");
        try {         
            Connection con = AppCommon.createConnection();
            Statement statement = con.createStatement();
            PreparedStatement ps = null;
            ps = con.prepareStatement("UPDATE INVOICES SET IMSI=?,ACTIVATION_DATE=?,CUSTOMER_NUMBER=?,NET_AMOUNT=?,GROSS_AMOUNT=?,CURRENT_USAGE=? where IMSI=?"); //didn't need to specify column names since we're using all of them in the order they are in, but still it makes for better comprehensibility
            ps.setInt(1, Integer.valueOf(request.getParameter("IMSI")));
            ps.setDate(2, AppCommon.parseDate(request.getParameter("ActDat")));
            ps.setInt(3, Integer.valueOf(request.getParameter("CstNo")));
            ps.setDouble(4, AppCommon.parseDouble(request.getParameter("NetAmt")));
            if((request.getParameter("GrsAmt")).equals("null")){           
                ps.setNull(5,Types.DOUBLE);                                    
            }
            else {
               ps.setDouble(5, AppCommon.parseDouble(request.getParameter("GrsAmt")));     
            }
            if((request.getParameter("CrntUsg")).equals("null")){                      
                ps.setNull(6,Types.DOUBLE);  
            }
            else {
                ps.setDouble(6, AppCommon.parseDouble(request.getParameter("CrntUsg")));
            }
            ps.setInt(7, Integer.valueOf(request.getParameter("PrvsIMSI")));
            ps.executeUpdate();
            out.println("UPDATE COMPLETE! The new/modified record is:\n");
            ResultSet rs=statement.executeQuery("SELECT * FROM Invoices WHERE Invoices.IMSI="+request.getParameter("IMSI"));
            tableHandler.printTable(rs, response.getWriter());
            statement.close();
            ps.close();rs.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        out.println("</body></html>");
        out.close();
    }
}

