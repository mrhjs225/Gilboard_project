<!DOCTYPE HTML>

<html>
	<head>
		<title>회원가입</title>
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
							<li><a href="top100.jsp">Top 100</a></li>
							<li><a href="playlist.jsp">재생목록</a></li>
							<li><a href="mupload.jsp">음악 업로드</a></li>
						</ul>
					</nav>
				</div>
			</div>
		</div>
        <div id="wrapper">
            <div id="page">
                <div class="container">
                    <div class="row1">
                        <h2>회원 가입</h2>
                        <div class = "chart100">
                            <form action="user_registration.jsp" method="POST">
								<table id="registration_user">
									<tr class = "registration_tr">
										<td>아이디 </td>
										<td><input type="text" size="15" name="user_id" required></td>
									</tr>
									<tr class = "registration_tr">
										<td>비밀번호 </td>
										<td><input type="text" size="15" name="user_pw" required></td>
									</tr>
									<tr class = "registration_tr">
										<td>비밀번호 확인 </td>
										<td><input type="text" size="15" name="user_pwcheck" required></td>
									</tr>
									<tr class = "registration_tr">
										<td colspan="2"><input type="submit" value="가입하기"></td>
									</tr>
								</table>
							</form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
		<div id="copyright">
			<div class="container">
				<div class="row">
					<div class="12u">
						COPYRIGHT ⓒ Jin Seok Heo
						<br><br>Created : Jin Seok Heo, Design: <a href="http://templated.co">TEMPLATED</a></a>)
					</div>
				</div>
			</div>
		</div>
	</body>
</html>