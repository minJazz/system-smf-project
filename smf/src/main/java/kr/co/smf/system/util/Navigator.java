package kr.co.smf.system.util;

import org.springframework.stereotype.Component;

@Component
public class Navigator {
	public String getNavigator(int allNo, int pageNo) {
        StringBuffer navigator = new StringBuffer("");

        navigator.append("<table>");
        navigator.append("<tr>");
        
        if (pageNo == 0) {
            navigator.append("<td><a id = 'firstPage'>&laquo;</a></td>");
        } else {
            navigator.append("<td><a id = 'firstPage' ");
            navigator.append("href='#' ");
            navigator.append("onclick='changePage(" + 0 + ")'>&laquo;</a></td> ");
        }

        if ((pageNo / 5) == 0) {
        	navigator.append("<td><a id = 'backPage'>&lt;</a></td>");
        } else {
        	navigator.append("<td><a id = 'backPage' ");
        	navigator.append("href='#' ");
        	navigator.append("onclick='changePage(" + (((pageNo / 5) * 5) - 5) + ")'>&lt;</a></td>");
        }

        int endPageNo = 0;

        if (((allNo - 1) / 10) + 1 < ((pageNo / 5) * 5) + 5) {
            endPageNo = (allNo - 1) / 10 + 1;
        } else {
            endPageNo = ((pageNo / 5) * 5) + 5;
        }

        int count = 1;
        for (int i = ((pageNo / 5) * 5); i < endPageNo; i++) {
            if (pageNo == i) {
            	 navigator.append("<td><a>" + (i + 1) + "</a></td>");
            } else {
                navigator.append("<td><a href='#' onclick='changePage(" + i + ")'>" + (i + 1) + "</a></td>");
            }
        }

        if (endPageNo < (allNo - 1) / 10 + 1) {
        	navigator.append("<td><a id = 'nextPage' ");
            navigator.append("href='#' ");
            navigator.append("onclick='changePage(" + (((pageNo / 5) * 5) + 5) + ")'>&gt;</a></td> ");
        } else {
        	navigator.append("<td><a id = 'nextPage'>&gt;</a></td>");
        }

        if (pageNo < (allNo - 1) / 10) {
        	navigator.append("<td><a id = 'nextPage' ");
            navigator.append("href='#' ");
            navigator.append("onclick='changePage(" + ((allNo - 1) / 10) + ")'>&raquo;</a></td> ");
        	
        } else {
        	navigator.append("<td><a id = 'lastPage'>&raquo;</a></td>");
        }

        navigator.append("</tr>");
        navigator.append("</table>");
        
        return navigator.toString();
    }
}
