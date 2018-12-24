<!-- admin인지 확인 -->
<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<% request.setCharacterEncoding("utf-8"); %>
<%
	String id = request.getParameter("user_id");
	String password = request.getParameter("user_pw");

    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection(
          "jdbc:mysql://localhost:3306/m_project?characterEncoding=UTF-8&serverTimezone=UTC", "root", "root1234"); 
    String sqlStr = "SELECT * FROM user WHERE u_id = ?";
    PreparedStatement pstmt = conn.prepareStatement(sqlStr);
	pstmt.setString(1, id);
	ResultSet rset = pstmt.executeQuery();
    
    if(rset.next() == false) {
        out.println("<script>alert('ID가 존재하지 않습니다.'); location.href='index.jsp';</script>");
    } else {
        String pass;
        pass = rset.getString("password");

        if(pass.equals(password)){
            session.setAttribute("id", id);
            session.setAttribute("pw", password);
            out.println("<script>location.href='index.jsp';</script>");
        }
        else {
            out.println("<script>alert('PW가 일치하지 않습니다.'); location.href='index.jsp';</script>");
        }
    }
    rset.close();
    pstmt.close();
    conn.close();
%>