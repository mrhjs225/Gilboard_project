<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8"); %>

<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rset = null;

	conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/m_project?characterEncoding=UTF-8&serverTimezone=UTC", "root", "root1234");

	String title = request.getParameter("a_title");
	String artist = request.getParameter("a_artist");

	String select_sql = "SELECT * FROM album WHERE a_artist=?";
	pstmt = conn.prepareStatement(select_sql);
	pstmt.setString(1, artist);
	rset = pstmt.executeQuery();
	if (rset.next()) {
		out.println("<script>alert('아티스트당 한개의 앨범만 등록할 수 있습니다.'); location.href='mupload.jsp';</script>");
	} else {
		select_sql = "SELECT * FROM album WHERE album_name=?";
		pstmt = conn.prepareStatement(select_sql);
		pstmt.setString(1, title);
		rset = pstmt.executeQuery();

		if(!rset.next()) {
			String select_sql2 = "select a_id from album where a_id=(select max(a_id) from album)";
			pstmt = conn.prepareStatement(select_sql2);
			rset = pstmt.executeQuery();
			int a_id = 1;
			if (rset.next()) {
				a_id = Integer.parseInt(rset.getString("a_id"));
				a_id++;
			}
			
			String insert_sql = "INSERT INTO album VALUES(?,?,?);";
			pstmt = conn.prepareStatement(insert_sql);
			pstmt.setString(1, Integer.toString(a_id));
			pstmt.setString(2, title);
			pstmt.setString(3, artist);
			pstmt.executeUpdate();
			out.println("<script>alert('앨범이 등록되었습니다.'); location.href='mupload.jsp';</script>");
		}
		else {
			out.println("<script>alert('이미 등록된 앨범입니다.'); location.href='mupload.jsp';</script>");
		}
	}

	if(rset != null) rset.close();
	if(pstmt != null) pstmt.close();
	if(conn != null) conn.close();
%>