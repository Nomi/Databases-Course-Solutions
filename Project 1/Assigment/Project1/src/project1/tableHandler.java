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

public class tableHandler 
{
    public static void printTable(ResultSet rs, PrintWriter out) throws IOException {   //sets default value, kind of
        printTable(rs,out, false);
    }
    private static void printTable(ResultSet rs, PrintWriter out, boolean rsIsWholeTable) throws IOException {      //private because I want two seperate functions for printtable and whole table so this avoids confusions
        out.println("<html>");
        out.println("<body>");
        out.println("<table border=\"1\" style=\"width:100%\">\n");
       try{
            out.println("<tr><th>Invoice No.</th><th>Invoice Date</th><th>Account_Number</th><th>Net Amountt</th><th>Gross Amount</th><th>Discount</th><th>Actions</th></tr>\n");
           
            while (rs.next()) {
                out.println("<tr> <td>" 
                + rs.getString("IMSI") + " </td><td>" 
                + rs.getString("ACTIVATION_DATE") + "</td><td>"
                + rs.getString("CUSTOMER_NUMBER") + "</td><td>"
                + rs.getString("NET_AMOUNT") + "</td><td>"
                + rs.getString("GROSS_AMOUNT") + "</td><td>"
                + rs.getString("CURRENT_USAGE") + "</td><td>"
                + "<a href=\\Project1\\insertsimilar?IMSI="+rs.getString("IMSI")+"&ActDat="+rs.getString("ACTIVATION_DATE")+"&CstNo="+rs.getString("CUSTOMER_NUMBER")+"&NetAmt="+rs.getString("NET_AMOUNT")+"&GrsAmt="+rs.getString("GROSS_AMOUNT")+"&CrntUsg="+rs.getString("CURRENT_USAGE")+">INSERT_SIMILAR</a> "
                + "&nbsp;&nbsp; | &nbsp;&nbsp; " 
                +"<a href=\\Project1\\updateform?IMSI="+rs.getString("IMSI")+"&ActDat="+rs.getString("ACTIVATION_DATE")+"&CstNo="+rs.getString("CUSTOMER_NUMBER")+"&NetAmt="+rs.getString("NET_AMOUNT")+"&GrsAmt="+rs.getString("GROSS_AMOUNT")+"&CrntUsg="+rs.getString("CURRENT_USAGE")+">UPDATE_ROW</a> "
                + "&nbsp;&nbsp; | &nbsp;&nbsp;" 
                +"<a href=\\Project1\\deleterow?IMSI="+rs.getString("IMSI")+">DELETE_ROW</a>" 
                + "</td></tr>");            }
            rs.close();
        }
        catch(Exception e) {
            e.printStackTrace();
        }
        out.println("</table>");
        out.println("<br>");
        if(rsIsWholeTable) {
            out.println("<a href=FilterData.html>Filter Invoices?</a>");
        }
        else {
            out.println("<br><a href=\\Project1\\home>Go back home(whole table)?</a>");      //pay attention to the escape characters!
       }
        out.close();
    }
    
    
    
    public static void printWholeTable(ResultSet rs, PrintWriter out) throws IOException{
        printTable(rs,out,true);
    }
    
    
    public static int getMaxIMSI(){
        try{
                Connection con = AppCommon.createConnection();
                Statement statement = con.createStatement();
                ResultSet rs = statement.executeQuery("select max(IMSI) max_val from INVOICES");
                int max_val=-9998;
                if(rs.next()) {
                    max_val=rs.getInt("max_val"); 
                }
                return max_val;
            }
        catch(Exception e) {
            e.printStackTrace();
            return -9999;
        }
    }
    
}
