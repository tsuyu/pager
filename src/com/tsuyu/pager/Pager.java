package com.tsuyu.pager;


public class Pager {
	public int totalPages(int totalRows, int rowPerPage) {
		if (totalRows < 1) {
			totalRows = 1;
		}
		return (int) Math.ceil((totalRows / (double)rowPerPage));
	}

	public int pageToRow(int currentPage, int rowPerPage) {
		return (currentPage - 1) * rowPerPage + 1;
	}

	public String drawPager(String url, int totalPages, int currentPage) {

		StringBuffer sb = new StringBuffer();

		if (currentPage <= 0 || currentPage > totalPages) {
			currentPage = 1;
		}

		if (currentPage > 1) {
			sb.append("<a href='" + url + "page=" + 1 + "'>Start</a> \n");
			sb.append("<a href='" + url + "page=" + (currentPage - 1)
					+ "'>Prev</a> \n");
		}

		for (int i = (currentPage - 3); i <= currentPage + 3; i++) {

			if (i < 1) {
				continue;
			}
			if (i > totalPages) {
				break;
			}
			if (i != currentPage) {
				sb.append("<a href='" + url + "page=" + i + "'>" + i
						+ "</a> \n");
			} else {
				sb.append("<a href='" + url + "page=" + i
						+ "' class=\"active\">" + i + "</a> \n");
			}

		}

		if (currentPage < totalPages) {
			sb.append("<a href='" + url + "page=" + (currentPage + 1)
					+ "'>Next</a> \n");
			sb.append("<a href='" + url + "page=" + totalPages
					+ "'>End</a> \n");
		}
		return sb.toString();

	}
}
