package project1;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.*;
import javax.servlet.http.*;

public class UpdateForm extends HttpServlet {
    private static final String CONTENT_TYPE = "text/html; charset=windows-1252";

    public void init(ServletConfig config) throws ServletException {
        super.init(config);
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {      //thought of this myself and only looked to the sample code for confirmation lol
        response.setContentType(AppCommon.CONTENT_TYPE);
        int maximsiplusone=(tableHandler.getMaxIMSI()+1);
        PrintWriter out = response.getWriter();
        out.println("<html><head><title>Update</title></head><body>");
        out.println("<form name=\"UpdateFeedForm\" action=\"update\" method=\"get\">");
        out.println("<table cellspacing=\"2\" cellpadding=\"3\" border=\"1\" width=\"50%\">");
        out.println("<tr> <td width=\"50%\">Invoice Number</td><td width=\"50%\"><input type=\"text\" name=\"IMSI\" value=\"" 
                    + request.getParameter("IMSI") + "\"/> (It is recommended to use the Invoice Number:"+String.valueOf(maximsiplusone)+")</td> WARNING: MAKE SURE THE CHOSEN IMSI DOESN'T EXIST ALREADY!");
        out.println("</tr><tr><td width=\"50%\">Activation Date</td><td width=\"50%\"><input type=\"text\" name=\"ActDat\" value=\"" 
                    + request.getParameter("ActDat") + "\"/></td>");
        out.println("</tr><tr><td width=\"50%\">Account Number</td><td width=\"50%\"><input type=\"text\" name=\"CstNo\" value=\"" 
                    + request.getParameter("CstNo") + "\"/></td>");
        out.println("</tr><tr><td width=\"50%\">Net Amount</td><td width=\"50%\"><input type=\"text\" name=\"NetAmt\" value=\"" 
                    + request.getParameter("NetAmt") + "\"/></td>");
        out.println("</tr><tr><td width=\"50%\">Gross Amount</td><td width=\"50%\"><input type=\"text\" name=\"GrsAmt\" value=\"" 
                    + request.getParameter("GrsAmt") + "\"/></td>");
        out.println("</tr><tr><td width=\"50%\">Discount</td><td width=\"50%\"><input type=\"text\" name=\"CrntUsg\" value=\"" 
                    + request.getParameter("CrntUsg") + "\"/></td>");
        out.println("<input type=\"hidden\" name=\"PrvsIMSI\" value=\"" + request.getParameter("IMSI") + "\"/></td>");      //hidden field to be able to change IMSI (because update statement needs current IMSI as well as new one)
        out.println("</tr><tr><td width=50%>&nbsp;</td><td width=\"50%\"><input type=\"submit\" name=\"Submit\"/></td></tr></table></form>");
        out.println("<br><a href=\\Project1\\home>Go back home(whole table)?</a>");
        out.println("</body></html>");
        out.close();
    }
}
