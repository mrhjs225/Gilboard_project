<!DOCTYPE HTML>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8"); %>

<%
	if (session.getAttribute("id") == null) {
		out.println("<script>alert('로그인후 이용 가능합니다.'); location.href='index.jsp';</script>");
	}
%>
<html>
	<head>
		<title>재생목록</title>
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
							<li ><a href="search.jsp">검색</a></li>
							<li ><a href="top100.jsp">Top 100</a></li>
							<li ><a href="topplaylist.jsp">재생목록 순위</a></li>
							<li class="current_page_item"><a href="playlist.jsp">재생목록</a></li>
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
					<span class="index_subspan">
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
                        <div class = "chart99">
							<h2 class = "index_subtitle">재생목록 등록</h2>
							<form action="playlist_registration.jsp" method="POST">
								<span class="index_subspan">
									재생목록 제목 :
									<input type="text" size="15" name="p_title" required>
									<input type="submit" value="생성하기">
								</span>
							</form>
						</div>
						<hr>
						
                        <div class = "chart100">
							<h2 class = "index_subtitle">재생목록 음악 추가</h2>
							<form action="playlistmusic_registration.jsp" method="POST">
								<p class = "index_subp">
									<span>재생목록 제목 :</span>
									<input type="text" size="15" name="p_title" required>
								</p>
								<p class = "index_subp">
									음악 순서 : 
									<input type="text" size="15" name="pm_number" required placeholder="숫자만 적어주세요.">
								</p>
								<p class = "index_subp">
									음악 제목 : 
									<input type="text" size="15" name="pm_title" required>
								</p>
								<p class = "index_subp">
									아티스트 : 
									<input type="text" size="15" name="pm_artist" required>
								</p>
								<p class = "index_subp">
									<input type="submit" value="추가하기">
								</p>
							</form>
						</div>
						<hr>
						
                        <div class = "chart100">
							<h2 class = "index_subtitle">나의 재생목록</h2>
							<%
							Class.forName("com.mysql.jdbc.Driver");
							Connection conn = null;
							PreparedStatement pstmt = null;
							ResultSet rset = null;
							String id = "";
							if (session.getAttribute("id") != null) {
								id = session.getAttribute("id").toString();
							}
							conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/m_project?characterEncoding=UTF-8&serverTimezone=UTC", "root", "root1234");

							String select_sql = "SELECT * FROM playlist where u_id = ?";
							pstmt = conn.prepareStatement(select_sql);
							pstmt.setString(1, id);
							rset = pstmt.executeQuery();
							ArrayList<String> p_titles = new ArrayList<String>();
							ArrayList<String> l_ids = new ArrayList<String>();
							while(rset.next()) {
								p_titles.add(rset.getString("playlist_title"));
								l_ids.add(rset.getString("l_id"));
							}
							int i = 0;
							for (String temp : p_titles) {
								String idtemp = l_ids.get(i);
							%>
								<br>
								<h3 class = "index_subsubtitle"><%= temp%></h3>
								<table class="gilboard_chart" border="1">
									<tr>
										<th>번호</th>
										<th>제목</th>
										<th>아티스트</th>
										<th>작곡가</th>
										<th>작사가</th>
										<th>앨범명</th>
									</tr>

							<%
								select_sql = "SELECT * FROM playlist_music where l_id = ?";
								pstmt = conn.prepareStatement(select_sql);
								pstmt.setString(1, idtemp);
								rset = pstmt.executeQuery();
								while (rset.next()) {
									String number = rset.getString("order_number");
									String title = rset.getString("title");
									String artist = rset.getString("artist");

									PreparedStatement pstmt2 = null;
									ResultSet rset2 = null;
									String select_sql2 = "SELECT * FROM music where title=?";
									pstmt2 = conn.prepareStatement(select_sql2);
									pstmt2.setString(1, title);
									rset2 = pstmt2.executeQuery();
									rset2.next();
									String composer = rset2.getString("composer");
									String lyricist = rset2.getString("lyricist");
									String album = rset2.getString("album_name");
							%>
									<tr>
										<td><%= number %></td>
										<td><%= title %></td>
										<td><%= artist %></td>
										<td><%= composer %></td>
										<td><%= lyricist %></td>
										<td><%= album %></td>
									</tr>
								
							<%
										}
							%>
							</table>
							<%
								i++;
								}
								if(rset != null) rset.close();
								if(pstmt != null) pstmt.close();
								if(conn != null) conn.close();
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