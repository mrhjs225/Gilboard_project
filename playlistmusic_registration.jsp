<%@ page import="java.sql.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8"); %>

<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rset = null;

	conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/m_project?characterEncoding=UTF-8&serverTimezone=UTC", "root", "root1234");

	String l_title = request.getParameter("p_title");
	String number = request.getParameter("pm_number");
	String title = request.getParameter("pm_title");
	String artist = request.getParameter("pm_artist");
	String l_id = "";
	String select_sql = "SELECT * FROM playlist WHERE playlist_title=?";
	pstmt = conn.prepareStatement(select_sql);
	pstmt.setString(1, l_title);
	rset = pstmt.executeQuery();
	if (!rset.next()) {
		out.println("<script>alert('존재하지 않는 재생목록 입니다.'); location.href='playlist.jsp';</script>");
	} else {
		l_id = rset.getString("l_id");

		select_sql = "SELECT * FROM music WHERE title=? AND m_artist =?";
		pstmt = conn.prepareStatement(select_sql);
		pstmt.setString(1, title);
		pstmt.setString(2, artist);
		rset = pstmt.executeQuery();
		if (!rset.next()) {
			out.println("<script>alert('제목 혹은 아티스트명이 일치하지 않습니다.'); location.href='playlist.jsp';</script>");
		} else {
			select_sql = "SELECT * FROM playlist_music WHERE l_id=? and order_number=?";
			pstmt = conn.prepareStatement(select_sql);
			pstmt.setString(1, l_id);
			pstmt.setString(2, number);
			rset = pstmt.executeQuery();
			if (rset.next()) {
				out.println("<script>alert('음악 순서가 중복됩니다.'); location.href='playlist.jsp';</script>");
			} else {
				String insert_sql = "INSERT INTO playlist_music VALUES(?,?,?,?);";
				pstmt = conn.prepareStatement(insert_sql);
				pstmt.setString(1, l_id);
				pstmt.setString(2, number);
				pstmt.setString(3, title);
				pstmt.setString(4, artist);
				pstmt.executeUpdate();

				out.println("<script>alert('음악이 등록되었습니다.'); location.href='playlist.jsp';</script>");
			}
		}
	}

	if(rset != null) rset.close();
	if(pstmt != null) pstmt.close();
	if(conn != null) conn.close();
%>