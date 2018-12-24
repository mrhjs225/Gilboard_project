<!DOCTYPE HTML>
<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8"); %>

<%
	if (session.getAttribute("id") == null) {
		out.println("<script>alert('로그인후 이용 가능합니다.'); location.href='index.jsp';</script>");
	}
%>
<html>
	<head>
		<title>검색</title>
		<meta http-equiv="content-type" content="text/html; charset=utf-8" />
		<meta name="description" content="" />
		<meta name="keywords" content="" />
		<link href="http://fonts.googleapis.com/css?family=Oswald:400,300" rel="stylesheet" type="text/css" />
		<!--[if lte IE 8]><script src="js/html5shiv.js"></script><![endif]-->
		<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
		<script src="js/skel.min.js"></script>
		<script src="js/skel-panels.min.js"></script>
		<script src="js/init.js"></script>
		<noscript>
			<link rel="stylesheet" href="css/skel-noscript.css" />
			<link rel="stylesheet" href="css/style.css" />
			<link rel="stylesheet" href="css/style-desktop.css" />
		</noscript>
	</head>
	<body>
		<div id="header-wrapper">
			<div class="container">
				<div id="header">
					<div id="logo">
						<h1><a href="index.jsp">Gillboard</a></h1>
					</div>
					<nav id="nav">
						<ul>
							<li class="current_page_item"><a href="search.jsp">검색</a></li>
							<li ><a href="top100.jsp">Top 100</a></li>
							<li ><a href="topplaylist.jsp">재생목록 순위</a></li>
							<li><a href="playlist.jsp">재생목록</a></li>
							<li><a href="mupload.jsp">음악 업로드</a></li>
						</ul>
					</nav>
				</div>
				<div id = "sublogin">
					<%
					if (session.getAttribute("id") == null) {
					%>
					<form action="login.jsp" method="POST">
						<span>
							ID <input type="text" size="10" name="user_id">
							PW <input type="password" size="10" name="user_pw">
							<input type="submit" value="Login">
							<a href="index.html">회원가입</a>
						</span>
					</form>
					<% 
						} else {
						String id = session.getAttribute("id").toString();
					%>
					<span class = "index_subspan">
						<%=id%>님 환영합니다. <button onclick="location.href='logout.jsp'">로그아웃</button>
					</span>
					<%
						}
					%>
				</div>
			</div>
		</div>
        <div id="wrapper">
            <div id="page">
                <div class="container">
                    <div class="row1">
                        <h2 class = "index_subtitle">음악 검색</h2>
                        <div class = "chart100">
							<form method="POST">
								<select name ="options" id="option">
									<option value="title">제목명</option>
									<option value="artist">아티스트</option>
									<option value ="album">앨범명</option>
									<option value = "playlist">재생목록</option>
								</select>
								<input type="text" size="15" name="query">
								<input type="submit" value="검색">
							</form>
                        </div>
						<hr>
						<div class = "chart100">
							<%
								String query = request.getParameter("query");
								String option = request.getParameter("options");
								if (query != null) {
									if (option.equals("playlist")) {
									Class.forName("com.mysql.jdbc.Driver");
								
									Connection conn = DriverManager.getConnection(
									"jdbc:mysql://localhost:3306/m_project?characterEncoding=UTF-8&serverTimezone=UTC", "root", "root1234"); 
									Statement stmt = conn.createStatement();
									String sqlStr = "SELECT * FROM playlist p, playlist_evaluation e WHERE p.playlist_title=e.playlist_title and p.playlist_title LIKE ";
									sqlStr += "'%" + query + "%'";
									sqlStr += "ORDER BY p.playlist_title ASC";
									ResultSet rset = stmt.executeQuery(sqlStr);
							%>
							<table class="gilboard_chart" border="1">
								<tr>
									<th>제목</th>
									<th>작성자</th>
									<th>좋아요</th>
									<th>싫어요</th>
									<th></th>
									<th></th>
									
								</tr>
								<%
								while (rset.next()) {
							%>
								<tr>
									<td><%= rset.getString("playlist_title") %></td>
									<td><%= rset.getString("u_id")%></td>
									<td><%= rset.getString("good") %></td>
									<td><%= rset.getString("bad") %></td>
									<td><a href="slist_good.jsp?title=<%=rset.getString("playlist_title")%>">좋아요</a></td>
									<td><a href="slist_bad.jsp?title=<%=rset.getString("playlist_title")%>">싫어요</td>
								</tr>
							<%
								}
							%>
							</table>
							<%
								rset.close();
								stmt.close();
								conn.close();
							%>
							<%
									} else {
									Class.forName("com.mysql.jdbc.Driver");
								
									Connection conn = DriverManager.getConnection(
									"jdbc:mysql://localhost:3306/m_project?characterEncoding=UTF-8&serverTimezone=UTC", "root", "root1234"); 
									Statement stmt = conn.createStatement();
									String sqlStr = "";
									if (option.equals("title")) {
										sqlStr = "SELECT * FROM music m, evaluation e WHERE m.title=e.music_name and m.title LIKE ";
									} else if (option.equals("artist")) {
										sqlStr = "SELECT * FROM music m, evaluation e WHERE m.title=e.music_name and m.m_artist LIKE ";
									} else {
										sqlStr = "SELECT * FROM music m, evaluation e WHERE m.title=e.music_name and m.album_name LIKE";
									}
									sqlStr += "'%" + query + "%'";
									sqlStr += "ORDER BY title ASC";
									ResultSet rset = stmt.executeQuery(sqlStr);
							%>
							<table class="gilboard_chart" >
								<tr>
									<th>제목</th>
									<th>아티스트</th>
									<th>작곡가</th>
									<th>작사가</th>
									<th>앨범 이름</th>
									<th>좋아요</th>
									<th>싫어요</th>
									<th></th>
									<th></th>
									
								</tr>
								<%
									while (rset.next()) {
								%>
									<tr>
										<td><%= rset.getString("title") %></td>
										<td><%= rset.getString("m_artist")%></td>
										<td><%= rset.getString("composer")%></td>
										<td><%= rset.getString("lyricist") %></td>
										<td><%= rset.getString("album_name") %></td>
										<td><%= rset.getString("good") %></td>
										<td><%= rset.getString("bad") %></td>
										<td><a href="sgood.jsp?title=<%=rset.getString("title")%>">좋아요</a></td>
										<td><a href="sbad.jsp?title=<%=rset.getString("title")%>">싫어요</td>
									</tr>
								<%
									}
								%>
							</table>
							<%
									rset.close();
									stmt.close();
									conn.close();
									}
								}
							%>
						</div>
                    </div>
                </div>
            </div>
        </div>
		<div id="copyright" class="container">
			COPYRIGHT ⓒ Jin Seok Heo
			<br><br>Created : Jin Seok Heo, Design: <a href="http://templated.co">TEMPLATED</a></a>
		</div>
	</body>
</html>