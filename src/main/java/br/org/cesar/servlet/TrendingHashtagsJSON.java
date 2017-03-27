package br.org.cesar.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.org.cesar.service.TrendingHashtagsService;

/**
 * Servlet implementation class TrendingSearch
 */
@WebServlet("/TrendingHashtags")
public class TrendingHashtagsJSON extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TrendingHashtagsJSON() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		TrendingHashtagsService service = new TrendingHashtagsService();
		String hashtagList = service.getTrendingTopicsBrazil();
		response.setContentType("application/json");
		response.setCharacterEncoding("utf-8");
		response.getWriter().write(hashtagList);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
