<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8"); %>

<%
Class.forName("com.mysql.jdbc.Driver");
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rset = null;

conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/m_project?characterEncoding=UTF-8&serverTimezone=UTC", "root", "root1234");
String title = request.getParameter("title");

String select_sql = "Select good from playlist_evaluation where playlist_title =?";
pstmt = conn.prepareStatement(select_sql);
pstmt.setString(1, title);
pstmt.executeQuery();
rset = pstmt.executeQuery();
rset.next();
int good = Integer.parseInt(rset.getString("good"));
good++;

select_sql = "UPDATE playlist_evaluation SET good = ? where playlist_title =? ";
pstmt = conn.prepareStatement(select_sql);
pstmt.setInt(1, good);
pstmt.setString(2, title);
pstmt.executeUpdate();

out.println("<script>alert('좋아요!를 표현하셨습니다.'); location.href='search.jsp';</script>");
if(rset != null) rset.close();
if(pstmt != null) pstmt.close();
if(conn != null) conn.close();
%>