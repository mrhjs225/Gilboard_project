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
		<title>재생목록 순위</title>
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
							<li class="current_page_item"><a href="topplaylist.jsp">재생목록 순위</a></li>
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
                        <h2 class = "index_subtitle">재생목록 Top 50</h2>
                        <div class = "chart100">
								<%
                                Class.forName("com.mysql.jdbc.Driver");
                                Connection conn = null;
                                PreparedStatement pstmt = null;
                                ResultSet rset = null;

                                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/m_project?characterEncoding=UTF-8&serverTimezone=UTC", "root", "root1234");

                                String select_sql = "SELECT * FROM playlist p, playlist_evaluation e where p.playlist_title = e.playlist_title order by e.good-e.bad desc";
                                pstmt = conn.prepareStatement(select_sql);
                                rset = pstmt.executeQuery();
								int rank = 0;
								int limit = 0;
                            %>

                                <table class="gilboard_chart" border="1">
                                    <tr>
                                        <th>순위</th>
                                        <th>제목</th>
                                        <th>작성자</th>
										<th>좋아요</th>
                                        <th>싫어요</th>
                                        <th></th>
                                        <th></th>
                                    </tr>

                            <%
                                // select 된 tuple들을 table에 추가
                                while (rset.next()) {
									if (limit++ > 50) break;
                                    rank++;
                                    String title = rset.getString("playlist_title");
                                    String writer = rset.getString("u_id");
									String good = rset.getString("good");
									String bad = rset.getString("bad");
                            %>
                                    <tr>
                                        <td><%= rank %></td>
                                        <td><%= title %></td>
                                        <td><%= writer %></td>
										<td><%= good %></td>
                                        <td><%= bad %></td>
                                        <td><a href="list_good.jsp?title=<%= title%>">좋아요</a></td>
										<td><a href="list_bad.jsp?title=<%= title%>">싫어요</td>
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