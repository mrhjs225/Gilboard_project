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
		<title>음악 업로드</title>
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
							<li ><a href="playlist.jsp">재생목록</a></li>
							<li class="current_page_item"><a href="mupload.jsp">음악 업로드</a></li>
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
							<h2 class = "index_subtitle">앨범등록</h2>
							<form action="album_registration.jsp" method="POST">
								<p class = "index_subp">
									앨범제목 : 
									<input type="text" size="15" name="a_title" required>
								</p>
								<p class = "index_subp">
									아티스트 : 
									<input type="text" size="15" name="a_artist" required>
								</p>
								<p class = "index_subp">
									<input type="submit" value="등록하기">
								</p>
							</form>
						</div>
						<hr>
                        <div class = "chart100">
							<h2 class = "index_subtitle">음악 등록</h2>
                            <form action="music_registration.jsp" method="POST">
								<p class = "index_subp">
									제목 : 
									<input type="text" size="15" name="m_title" required>
								</p>
								<p class = "index_subp">
								아티스트 :
									<input type="text" size="15" name="m_artist" required>
								</p>
								<p class = "index_subp">
								작곡가 : 
									<input type="text" size="15" name="composer" required>
								</p>
								<p class = "index_subp">
								작사가 : 
									<input type="text" size="15" name="lyricist" required>
								</p>
								<p class = "index_subp">
								앨범이름 : 
									<input type="text" size="15" name="album_name" required>
								</p>
								<p class = "index_subp">
								곡번호 : 
									<input type="text" size="15" name="numbering" required placeholder="숫자만 적어주세요.">
								</p>
								<p class = "index_subp">
									<input type="submit" value="등록하기">
								</p>
							</form>
						</div>
						<hr>
                        <div class = "chart100">
							<h2 class = "index_subtitle">내 음악</h2>
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

							String select_sql = "SELECT * FROM evaluation e, music m where m.title = e.music_name and m.m_artist = ?";
							pstmt = conn.prepareStatement(select_sql);
							pstmt.setString(1, id);
							rset = pstmt.executeQuery();
							%>

								<table class="gilboard_chart" border="1">
									<tr>
										<th>제목</th>
										<th>아티스트</th>
										<th>작곡가</th>
										<th>작사가</th>
										<th>앨범명</th>
										<th>좋아요</th>
										<th>싫어요</th>
									</tr>

							<%
								// select 된 tuple들을 table에 추가
								while (rset.next()) {
									String title = rset.getString("music_name");
									String artist = rset.getString("m_artist");
									String composer = rset.getString("composer");
									String lyricist = rset.getString("lyricist");
									String album = rset.getString("album_name");
									String good = rset.getString("good");
									String bad = rset.getString("bad");
							%>
									<tr>
										<td><%= title %></td>
										<td><%= artist %></td>
										<td><%= composer %></td>
										<td><%= lyricist %></td>
										<td><%= album %></td>
										<td><%= good %></td>
										<td><%= bad %></td>
									</tr>
							<%
								}
							%>
								</table>
							<%
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