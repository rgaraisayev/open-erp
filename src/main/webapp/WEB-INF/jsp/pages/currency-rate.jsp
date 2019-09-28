<%--
  Created by IntelliJ IDEA.
  User: irkan.ahmadov
  Date: 01.09.2019
  Time: 1:22
  To change this template use File | Settings | File Templates.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="utl" uri="/WEB-INF/tld/Util.tld"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="kt-container  kt-grid__item kt-grid__item--fluid">
    <div class="row">
        <div class="col-lg-12">
            <div class="kt-portlet kt-portlet--mobile">
                <div class="kt-portlet__body">
                    <form:form modelAttribute="form" id="form" method="post" action="/admin/currency-rate" cssClass="form-group">
                        <div class="row">
                            <div class="col-md-2 offset-md-10 text-right">
                                <button onclick="submit($('#form'))" class="btn btn-primary">Yenilə</button>
                            </div>
                        </div>
                    </form:form>
                        <hr style="width: 100%"/>
                    <c:choose>
                        <c:when test="${not empty list}">
                            <table class="table table-striped- table-bordered table-hover table-checkable" id="group_table">
                                <thead>
                                <tr>
                                    <th>№</th>
                                    <th>ID</th>
                                    <th>Tipi</th>
                                    <th>Tarix</th>
                                    <th>Kod</th>
                                    <th>Nominal</th>
                                    <th>Ad</th>
                                    <th>Dəyər</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="t" items="${list}" varStatus="loop">
                                    <tr>
                                        <td>${loop.index + 1}</td>
                                        <td><c:out value="${t.id}" /></td>
                                        <td><c:out value="${t.type}"/></td>
                                        <td><c:out value="${utl:getFormattedDate(t.rateDate)}"/></td>
                                        <td><c:out value="${t.code}"/></td>
                                        <td><c:out value="${t.nominal}"/></td>
                                        <td><c:out value="${t.name}"/></td>
                                        <td><c:out value="${t.value}"/></td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </c:when>
                        <c:otherwise>
                            Məlumat yoxdur
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="<c:url value="/assets/js/demo4/pages/crud/datatables/advanced/row-grouping.js" />" type="text/javascript"></script>