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

	String title = request.getParameter("m_title");
	String artist = request.getParameter("m_artist");
	String composer = request.getParameter("composer");
	String lyricist = request.getParameter("lyricist");
	String album_name = request.getParameter("album_name");
	String numbering = request.getParameter("numbering");

	String select_sql = "SELECT * FROM album WHERE album_name=? AND a_artist =?";
	pstmt = conn.prepareStatement(select_sql);
	pstmt.setString(1, album_name);
	pstmt.setString(2, artist);
	rset = pstmt.executeQuery();
	if (!rset.next()) {
		out.println("<script>alert('존재하지 않는 앨범 혹은 아티스트 입니다.'); location.href='mupload.jsp';</script>");
	} else {
		select_sql = "SELECT * FROM music WHERE title=?";
		pstmt = conn.prepareStatement(select_sql);
		pstmt.setString(1, title);
		rset = pstmt.executeQuery();
		if(!rset.next()) {
			String select_sql2 = "select m_id from music where m_id=(select max(m_id) from music)";
			pstmt = conn.prepareStatement(select_sql2);
			rset = pstmt.executeQuery();
			int m_id =1;
			if (rset.next()) {
				m_id = Integer.parseInt(rset.getString("m_id"));
				m_id++;
			}
			String insert_sql = "INSERT INTO music VALUES(?,?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(insert_sql);
			pstmt.setString(1, Integer.toString(m_id));
			pstmt.setString(2, title);
			pstmt.setString(3, artist);
			pstmt.setString(4, composer);
			pstmt.setString(5, lyricist);
			pstmt.setString(6, album_name);
			pstmt.setString(7, numbering);
			Date release = new Date();
			SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");
			pstmt.setString(8, transFormat.format(release));
			pstmt.executeUpdate();
			insert_sql = "INSERT INTO evaluation VALUES(?,?,?)";
			pstmt = conn.prepareStatement(insert_sql);
			pstmt.setString(1, title);
			pstmt.setString(2, "0");
			pstmt.setString(3, "0");
			pstmt.executeUpdate();


			out.println("<script>alert('음악이 등록되었습니다.'); location.href='mupload.jsp';</script>");
		}
		else {
			out.println("<script>alert('이미 등록한 음악입니다.'); location.href='mupload.jsp';</script>");
		}
	}

	if(rset != null) rset.close();
	if(pstmt != null) pstmt.close();
	if(conn != null) conn.close();
%>