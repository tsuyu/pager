package com.tsuyu.servlets;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tsuyu.dao.EmployeeDAO;
import com.tsuyu.to.Employee;

public class EmployeeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	 
    public EmployeeServlet() {
            super();
    }
 
    public void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {
        int page = 1;
        int recordsPerPage = 5;
        if(request.getParameter("page") != null)
            page = Integer.parseInt(request.getParameter("page"));
        EmployeeDAO dao = new EmployeeDAO();
        List<Employee> list = dao.viewAllEmployees((page-1)*recordsPerPage,
                                 recordsPerPage);
        int noOfRecords = dao.getNoOfRecords();
        int noOfPages = (int) Math.ceil(noOfRecords * 1.0 / recordsPerPage);
        request.setAttribute("employeeList", list);
        request.setAttribute("noOfPages", noOfPages);
        request.setAttribute("currentPage", page);
        RequestDispatcher view = request.getRequestDispatcher("displayEmployee.jsp");
        view.forward(request, response);
    }
}
