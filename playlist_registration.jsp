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

	String title = request.getParameter("p_title");
	String id = session.getAttribute("id").toString();

	String select_sql = "SELECT * FROM playlist WHERE playlist_title=?";
	pstmt = conn.prepareStatement(select_sql);
	pstmt.setString(1, title);
	rset = pstmt.executeQuery();
	if (rset.next()) {
		out.println("<script>alert('존재하는 재생목록 입니다.'); location.href='playlist.jsp';</script>");
	} else {
		String select_sql2 = "select l_id from playlist where l_id=(select max(l_id) from playlist)";
		pstmt = conn.prepareStatement(select_sql2);
		rset = pstmt.executeQuery();
		int l_id = 1;
		if(rset.next()) {
			l_id = Integer.parseInt(rset.getString("l_id"));
			l_id++;
		}
		String insert_sql = "INSERT INTO playlist VALUES(?,?,?)";
		pstmt = conn.prepareStatement(insert_sql);
		pstmt.setString(1, Integer.toString(l_id));
		pstmt.setString(2, id);
		pstmt.setString(3, title);
		pstmt.executeUpdate();

		insert_sql = "INSERT INTO playlist_evaluation VALUES(?,?,?)";
		pstmt = conn.prepareStatement(insert_sql);
		pstmt.setString(1, title);
		pstmt.setString(2, "0");
		pstmt.setString(3, "0");
		pstmt.executeUpdate();
		out.println("<script>alert('재생목록이 등록되었습니다.'); location.href='playlist.jsp';</script>");
	}

	if(rset != null) rset.close();
	if(pstmt != null) pstmt.close();
	if(conn != null) conn.close();
%>