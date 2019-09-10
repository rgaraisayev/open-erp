<%@ page import="az.sufilter.bpm.entity.DictionaryType" %><%--
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
<%@ taglib prefix="uj" uri="/WEB-INF/tld/UtilJson.tld"%>
<div class="kt-container  kt-grid__item kt-grid__item--fluid">
    <div class="row">
        <div class="col-lg-12">
            <div class="kt-portlet kt-portlet--mobile">
                <div class="kt-portlet__body">

<c:choose>
    <c:when test="${not empty list}">
<table class="table table-striped- table-bordered table-hover table-checkable" id="module_operation_table">
    <thead>
    <tr>
        <th>№</th>
        <th>ID</th>
        <th>Üst modul</th>
        <th>Modul</th>
        <th>Əməliyyat</th>
        <th>Əməliyyat</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="t" items="${list}" varStatus="loop">
        <c:choose>
            <c:when test="${not empty t.module.module}">
                <tr>
                    <td>${loop.index + 1}</td>
                    <td><c:out value="${t.id}" /> <%--${uj:toJson(t)}--%></td>
                    <td><c:out value="${t.module.module.name}" /></td>
                    <td><c:out value="${t.module.name}" /></td>
                    <td><c:out value="${t.operation.name}" /></td>>
                    <td nowrap>
                        <a href="#" class="btn btn-sm btn-clean btn-icon btn-icon-md" title="View">
                            <i class="la la-remove"></i>
                        </a>
                    </td>
                </tr>
            </c:when>
        </c:choose>
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


<div class="modal fade" id="modal-create-new" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Yeni sorğu tipi yarat</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form:form modelAttribute="form" method="post" action="/admin/module-operation" cssClass="form-group">
                    <form:input type="hidden" name="id" path="id"/>
                    <div class="form-group">
                        <form:label path="module">Modul</form:label>
                        <form:select  path="module" cssClass="custom-select form-control">
                            <form:options items="${modules}" itemLabel="name" itemValue="id" />
                        </form:select>
                    </div>
                    <div class="form-group">
                        <form:label path="operation">Əməliyyat</form:label>
                        <form:select  path="operation" cssClass="custom-select form-control">
                            <form:options items="${operations}" itemLabel="name" itemValue="id" />
                        </form:select>
                    </div>
                </form:form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" onclick="$('#form').submit()">Yadda saxla</button>
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Bağla</button>
            </div>
        </div>
    </div>
</div>

<script src="<c:url value="/assets/js/demo4/pages/crud/datatables/advanced/row-grouping.js" />" type="text/javascript"></script>




