package project1;

import java.io.IOException;
import java.io.PrintWriter;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import java.sql.Types;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

public class Insert extends HttpServlet {
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
            ps = con.prepareStatement("INSERT INTO INVOICES (IMSI,ACTIVATION_DATE,CUSTOMER_NUMBER,NET_AMOUNT,GROSS_AMOUNT,CURRENT_USAGE) VALUES(?,?,?,?,?,?)"); //didn't need to specify column names since we're using all of them in the order they are in, but still it makes for better comprehensibility
            ps.setInt(1, Integer.valueOf(request.getParameter("IMSI")));
            ps.setDate(2, AppCommon.parseDate(request.getParameter("ActDat")));
            ps.setInt(3, Integer.valueOf(request.getParameter("CstNo")));
            ps.setDouble(4, AppCommon.parseDouble(request.getParameter("NetAmt")));
            if((request.getParameter("GrsAmt")).equals("null")){            //these if-thens gave me greater pain than I have experienced all my life. IDK what I was doing in my sleep considering I don't know java. basically, some things I learned: never use == because it compares reference, also using contains,substring,and a lot of stuff. I lost a lot of braincells too. RIP my brain :'(
                ps.setNull(5,Types.DOUBLE);                                     //(continued)so much so that I wanna kms :'(
            }
            else {
               ps.setDouble(5, AppCommon.parseDouble(request.getParameter("GrsAmt")));      //(continued) equals part fixed these probably because == would compare references, I went through too much pain to describe anything else (because I'm tired)
            }
            if((request.getParameter("CrntUsg")).equals("null")){                           //(continued) except at the end I also realized this is line 41 where I have had the error since some time and I was using CrntAmt instead of CrntUsg
                ps.setNull(6,Types.DOUBLE);  
            }
            else {
                ps.setDouble(6, AppCommon.parseDouble(request.getParameter("CrntUsg")));
            }
            ps.executeUpdate();
            out.println("INSERT COMPLETE! The inserted record is:\n");
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
