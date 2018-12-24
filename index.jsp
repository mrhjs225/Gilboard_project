<!DOCTYPE HTML>
<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<html>
	<head>
		<title>Gillboard</title>
		<meta http-equiv="content-type" content="text/html; charset=utf-8" />
		<meta name="description" content="" />
		<meta name="keywords" content="" />
		<link href="http://fonts.googleapis.com/css?family=Oswald:400,300" rel="stylesheet" type="text/css" />
		<!--[if lte IE 8]><script src="js/html5shiv.js"></script><![endif]-->
		
		<link rel="stylesheet" href="css/skel-noscript.css" />
		<link rel="stylesheet" href="css/style.css" />
		<link rel="stylesheet" href="css/style-desktop.css" />
	</head>
	<body class="homepage">
		<div id="header-wrapper">
			<div class="container">
				<div id="header">
					<div id="logo">
						<h1><a href="#">Gillboard</a></h1>
					</div>
					<nav id="nav">
						<ul>
                            <li ><a href="search.jsp">검색</a></li>
                            <li ><a href="top100.jsp">Top 100</a></li>
                            <li ><a href="topplaylist.jsp">재생목록 순위</a></li>
							<li><a href="playlist.jsp">재생목록</a></li>
							<li><a href="mupload.jsp">음악 업로드</a></li>
						</ul>
					</nav>
				</div>
			</div>
		</div>
		<div id="wrapper">
            <div class="container" id="page">
                <div class="row">
                    <div class="6u">
                        <div class="post">
                            <h2 class = "index_subtitle">최신 앨범</h2>
                                <span class = "newalbumspan"><a  href="#"><img class = "newalbum" src="images/album1.jpg" alt=""></a>
                                <a href="#"><img class = "newalbum" src="images/album2.jpg" alt=""></a>
                                <a href="#"><img class = "newalbum" src="images/album3.jpg" alt=""></a>
                                <a href="#"><img class = "newalbum" src="images/album4.jpg" alt=""></a></span>
                            </div>
                        </div>
                        <div class="3u">
                                        <%
                                            if (session.getAttribute("id") == null) {
                                        %>
                                        <form action="login.jsp" method="POST">
                                            <h2 class ="index_subtitle">로그인</h2>
                                            <table>
                                                <tr>
                                                    <td>ID : </td>
                                                    <td><input type="text" size="10" name="user_id"></td>
                                                    <td rowspan="2"><input type="submit" value="Login"></td>
                                                </tr>
                                                <tr>
                                                    <td>PW : </td>
                                                    <td><input type="password" size="10" name="user_pw"></td>
                                                </tr>
                                            </table>
                                            <p><a href="signup.jsp">회원가입</a></p>
                                        </form>
                                        <% 
                                            } else {
                                                String id = session.getAttribute("id").toString();
                                        %>
                                        <span class = "index_span"><%=id%>님 환영합니다.</span><br><br>
                                        <button onclick="location.href='logout.jsp'">로그아웃</button>
                                        <%
                                            }
                                        %>

                        </div>
                    </div>
                </div>
			<div class="container" id="marketing">
				<div class="chart">
                    <section>
                        <br>
                        <h2 class="index_subtitle">길보드 차트</h2>
                        <%
                            Class.forName("com.mysql.jdbc.Driver");
                            Connection conn = null;
                            PreparedStatement pstmt = null;
                            ResultSet rset = null;

                            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/m_project?characterEncoding=UTF-8&serverTimezone=UTC", "root", "root1234");

                            String select_sql = "SELECT m.title, m.m_artist, m.album_name FROM evaluation e, music m where m.title = e.music_name order by e.good-e.bad desc";
                            pstmt = conn.prepareStatement(select_sql);
                            rset = pstmt.executeQuery();
                            int rank = 0;
                        %>

                            <table id="gilboard10" border="1">
                                <tr>
                                    <th>순위</th>
                                    <th>제목</th>
                                    <th>가수명</th>
                                    <th>앨범명</th>
                                </tr>

                        <%
                            // select 된 tuple들을 table에 추가
                            while (rset.next()) {
                                rank++;
                                String title = rset.getString("title");
                                String artist = rset.getString("m_artist");
                                String album = rset.getString("album_name");
                        %>
                                <tr>
                                    <td><%= rank %></td>
                                    <td><%= title %></td>
                                    <td><%= artist %></td>
                                    <td><%= album %></td>
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
                    </section>					
				</div>
			</div>
			
		</div>
		<div id="copyright" class="container">
			COPYRIGHT ⓒ Jin Seok Heo
			<br><br>Created : Jin Seok Heo, Design: <a href="http://templated.co">TEMPLATED</a></a>
		</div>
	</body>
</html>