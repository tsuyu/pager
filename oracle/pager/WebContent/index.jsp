<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="com.tsuyu.pager.Pager"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="style.css" media="screen" />
<title>Paging Demo</title>
</head>
<body>
	<%
		String url = "index.jsp?";
		int currentPage = 1;
		int rowPerPage = 5;
		int row = 0;
		Class.forName("oracle.jdbc.driver.OracleDriver");

		Connection conn = DriverManager.getConnection(
				"jdbc:oracle:thin:@localhost:1521:xe", "tsuyu", "123456");

		
		if (request.getParameter("page") != null) {
			currentPage = Integer.parseInt(request.getParameter("page"));
		}

		String sql = "SELECT * FROM EMP";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			ResultSet rset = pstmt.executeQuery();
			if (rset.isBeforeFirst()) {
				while (rset.next()) {
					row++;
				}
			}
		} catch (Exception e) {
			out.println(e.toString());
		}
		int totalRows = row;
		Pager pager = new Pager();
		int totalPages = pager.totalPages(totalRows, rowPerPage);
		int startRow = pager.pageToRow(currentPage, rowPerPage);
		int endRow = startRow + rowPerPage - 1;
		String sqlpager = "SELECT * FROM (SELECT E.*, ROWNUM R FROM EMP E WHERE ROWNUM <= "+endRow+")"+
				"WHERE "+startRow+" <= R";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sqlpager);
			ResultSet rset = pstmt.executeQuery();
			if (rset.isBeforeFirst()) {
	%>
	<div align="center">
	<h2>Paging Demo</h2>
	<table border="1">
		<tr>
			<th>No</th>
			<th>Employee No.</th>
			<th>Name</th>
			<th>Job</th>
		</tr>
		<%
			while (rset.next()) {
						int no = rset.getRow();
						String empno = rset.getString(1);
						String ename = rset.getString(2);
						String job = rset.getString(3);
		%>
		<tr>
			<td>
				<%=no%>
			</td>
			<td>
				<%=empno%>
			</td>
			<td>
				<%=ename%>
			</td>
			<td>
				<%=job%>
			</td>
		</tr>
		<%
			}
		%>
	</table>
	
	<div class="pagination">
		<%=pager.drawPager(url, totalPages, currentPage)%>
	</div>
	<%
		}
		} catch (Exception e) {
			out.println(e.toString());
		}
	%>
	</div>
</body>
</html>