<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8"); %>

<%
	if (request.getParameter("user_id") == null) {
		out.println("<script>alert('id를 입력하십시오.'); location.href='signup.jsp';</script>;");
	}
	if (!request.getParameter("user_pw").equals(request.getParameter("user_pwcheck"))) {
		out.println("<script>alert('패스워드가 일치하지 않습니다.'); location.href='signup.jsp';</script>;");
	} else {
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;

		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/m_project?characterEncoding=UTF-8&serverTimezone=UTC", "root", "root1234");

		String user_id = request.getParameter("user_id");
		String user_pw = request.getParameter("user_pw");
		String user_pwcheck = request.getParameter("user_pwcheck");

		// 중복 학번 체크
		String select_sql = "SELECT * FROM user WHERE u_id=?";
		pstmt = conn.prepareStatement(select_sql);
		pstmt.setString(1, user_id);
		rset = pstmt.executeQuery();

		if(!rset.next()) {
			// table에 tuple 추가하는 부분
			String insert_sql = "INSERT INTO user VALUES(?,?);";
			pstmt = conn.prepareStatement(insert_sql);
			pstmt.setString(1, user_id);
			pstmt.setString(2, user_pw);
			pstmt.executeUpdate();
			out.println("<script>alert('가입이 완료되었습니다.'); location.href='index.jsp';</script>");
		}
		else {
			out.println("<script>alert('이미 등록된 사용자입니다.'); location.href='signup.jsp';</script>");
		}

		if(rset != null) rset.close();
		if(pstmt != null) pstmt.close();
		if(conn != null) conn.close();
	}
%>