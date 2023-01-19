import java.io.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class score
 */
public class scores extends HttpServlet {
	private static final long serialVersionUID = 1L;  
    /**
     * @see HttpServlet#HttpServlet()
     */
    public scores() {
        super();
        // TODO Auto-generated constructor stub
    }
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		PrintWriter pw=response.getWriter();
		String u_id=request.getParameter("uid");
		System.out.println(u_id);
		String [] answers= {"ans1","ans2","ans3","ans4","ans5"};
		for (int i=0;i<5;i++) {
			answers[i]=(String) request.getParameter("set"+String.valueOf(i+1));
		}
//		System.out.println(answers[0]+answers[1]+answers[2]+answers[3]+answers[4]);
	    String [] ques= {"ques1","ques2","ques3","ques4","ques5"};
		for (int i=0;i<5;i++) {
			ques[i]=(String) request.getParameter("ques"+String.valueOf(i+1));
		}
//		System.out.println(ques[0]+ques[1]+ques[2]+ques[3]+ques[4]);	    
	    int score=1;
		try {
			Connection con;PreparedStatement st;ResultSet rs;
			Class.forName("oracle.jdbc.driver.OracleDriver");
			con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","system","manager");
		String sql="select answer from questions where name=?";
		st=con.prepareStatement(sql);
		st.setString(1,"java");
		rs=st.executeQuery();
		String sql2="select score from result where u_id=?";
		PreparedStatement	st1=con.prepareStatement(sql2);
		st1.setString(1,u_id);
		ResultSet rs1=st1.executeQuery();
	if (rs1.next()) {
	score=Integer.parseInt(rs1.getString(1));
	}	
	int p=0;
		while (rs.next()) {
			
			if (rs.getString(1).equals(answers[p])) {
				score=score+1;
				try {
					Connection con1;
					PreparedStatement st2;
					ResultSet rs2;
					Class.forName("oracle.jdbc.driver.OracleDriver");
					con1 = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "system", "manager");
					String sql1 = "update result set score=? where u_id=?";
					st2 = con1.prepareStatement(sql1);
					System.out.println(score);
					st2.setString(1,String.valueOf(score));
					st2.setString(2,u_id);
					int g1=st2.executeUpdate();
					con1.close();
					pw.print("record updated");
				} catch (Exception e2) {
					System.out.println(e2.toString());
					pw.print("record failed");	
				}
				
			}
			else {
				System.out.println("wrong");
			}
//			response.sendRedirect("question.jsp");
			p++;
		}
		con.close();
		}
	catch (Exception e2) {
		System.out.println(e2.toString());
	}	
	
	}
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
}
